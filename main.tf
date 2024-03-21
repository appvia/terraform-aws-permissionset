#
## Related to provisioning an permissionset
#

#
## Define the permissionset 
#
resource "aws_ssoadmin_permission_set" "this" {
  instance_arn     = var.instance_arn
  name             = var.name
  description      = var.description
  session_duration = var.session_duration
  tags             = var.tags
}

#
## Attach any managed policy to the permissionset 
#
resource "aws_ssoadmin_permissions_boundary_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  permissions_boundary {
    managed_policy_arn = each.value
  }
}

#
## Attach any customer managed policy to the permissionset 
#
resource "aws_ssoadmin_permissions_boundary_attachment" "customer" {
  for_each = { for p in var.customer_managed_policy_references : p.name => p }

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  permissions_boundary {
    customer_managed_policy_reference {
      name = each.value.name
      path = each.value.path
    }
  }
}

#
## Assign the permissionset to the accounts 
#
resource "aws_ssoadmin_account_assignment" "this" {
  for_each = toset(var.assignment.targets)

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn
  principal_id       = var.assignment.principal_id
  principal_type     = "GROUP"
  target_id          = each.value
  target_type        = "AWS_ACCOUNT"
}

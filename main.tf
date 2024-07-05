
## Define the permissionset 
resource "aws_ssoadmin_permission_set" "this" {
  instance_arn     = var.instance_arn
  name             = var.name
  description      = var.description
  relay_state      = var.relay_state
  session_duration = var.session_duration
  tags             = var.tags
}

## Attach any managed policies to the permissionset 
resource "aws_ssoadmin_managed_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  instance_arn       = var.instance_arn
  managed_policy_arn = each.value
  permission_set_arn = aws_ssoadmin_permission_set.this.arn
}

## Attach any customer managed policies to the permissionset
resource "aws_ssoadmin_customer_managed_policy_attachment" "customer" {
  for_each = { for x in var.customer_managed_policy_references : x.name => x }

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  customer_managed_policy_reference {
    name = each.value.name
    path = each.value.path
  }
}

## Attach any boundary policy to the permissionset 
resource "aws_ssoadmin_permissions_boundary_attachment" "managed" {
  for_each = toset(var.managed_boundary_policy_arns)

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  permissions_boundary {
    managed_policy_arn = each.value
  }
}

## Attach any customer managed boundary policy to the permissionset 
resource "aws_ssoadmin_permissions_boundary_attachment" "customer" {
  for_each = { for x in var.customer_managed_boundary_policy_references : x.name => x }

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn

  permissions_boundary {
    customer_managed_policy_reference {
      name = each.value.name
      path = each.value.path
    }
  }
}

## Assign any inline policies to the permissionset 
resource "aws_ssoadmin_permission_set_inline_policy" "customer" {
  count = var.customer_managed_inline_policy != null ? 1 : 0

  inline_policy      = var.customer_managed_inline_policy
  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn
}

## Assign the permission set to the groups 
module "assignments" {
  source = "./modules/assignment"

  for_each           = { for x in var.assignments : x.principal_id => x }
  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this.arn
  principal_id       = each.value.principal_id
  principal_type     = each.value.principal_type
  targets            = each.value.targets
}

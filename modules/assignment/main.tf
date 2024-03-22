#
## Assign the permissionset to the accounts 
#
resource "aws_ssoadmin_account_assignment" "this" {
  for_each = toset(var.targets)

  instance_arn       = var.instance_arn
  permission_set_arn = var.permission_set_arn
  principal_id       = var.principal_id
  principal_type     = var.principal_type
  target_id          = each.value
  target_type        = "AWS_ACCOUNT"
}

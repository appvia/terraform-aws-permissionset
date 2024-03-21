
output "permission_set_arn" {
  description = "The ARN of the permission set provisioned"
  value       = aws_ssoadmin_permission_set.this.arn
}


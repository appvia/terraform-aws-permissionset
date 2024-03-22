variable "instance_arn" {
  description = "The arn of the instance to which the permission set is to be attached"
  type        = string
}

variable "permission_set_arn" {
  description = "The ARN of the permission set"
  type        = string
}

variable "principal_id" {
  description = "The ID of the principal we are adding to the permission set"
  type        = string
}

variable "principal_type" {
  description = "The type of principal we are adding to the permission set"
  type        = string
  default     = "GROUP"
}

variable "targets" {
  description = "The targets to which the permission set is to be attached"
  type        = list(string)
  default     = []
}

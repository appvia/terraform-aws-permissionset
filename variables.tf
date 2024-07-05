variable "assignments" {
  description = "An optional list of assignments to be attached to the permission set"
  type = list(object({
    principal_id   = string
    principal_type = optional(string, "GROUP")
    targets        = list(string)
  }))
  default = []
}

variable "customer_managed_inline_policy" {
  description = "An optional inline policy to be attached to the permission set"
  type        = string
  default     = null
}

variable "customer_managed_boundary_policy_references" {
  description = "The list of customer managed boundary policy references to be attached to the permission set"
  type = list(object({
    name = string
    path = optional(string, "/")
  }))
  default = []
}

variable "customer_managed_policy_references" {
  description = "The list of customer managed policy references to be attached to the permission set"
  type = list(object({
    name = string
    path = optional(string, "/")
  }))
  default = []
}

variable "relay_state" {
  description = "The relay state of the permission set, used to redirect users to a specific page after login"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of this permission set to be created"
  type        = string
}

variable "instance_arn" {
  description = "The arn of the instance to which the permission set is to be attached"
  type        = string
}

variable "managed_boundary_policy_arns" {
  description = "The list of managed boundary policy arns to be attached to the permission set"
  type        = list(string)
  default     = []
}

variable "managed_policy_arns" {
  description = "The list of managed policy arns to be attached to the permission set"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "The name of this permission set to be created"
  type        = string
}

variable "session_duration" {
  description = "The duration of the session"
  type        = string
  default     = "PT2H"
}

variable "tags" {
  description = "The tags to be attached to the permission set"
  type        = map(string)
}

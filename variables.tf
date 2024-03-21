#
## Related to the inputs to the module 
#

variable "name" {
  description = "The name of this permission set to be created"
  type        = string
}

variable "description" {
  description = "The description of this permission set to be created"
  type        = string
}

variable "tags" {
  description = "The tags to be attached to the permission set"
  type        = map(string)
}

variable "session_duration" {
  description = "The duration of the session"
  type        = string
  default     = "PT2H"
}

variable "assignment" {
  description = "An optional list of accounts to assign the permission"
  type = object({
    principal_id = string
    targets      = list(string)
  })
  default = {
    principal_id = ""
    targets      = []
  }
}

variable "instance_arn" {
  description = "The arn of the instance to which the permission set is to be attached"
  type        = string
}

variable "managed_policy_arns" {
  description = "The list of managed policy arns to be attached to the permission set"
  type        = list(string)
  default     = []
}

variable "customer_managed_policy_references" {
  description = "The list of customer managed policy references to be attached to the permission set"
  type = list(object({
    name = string
    path = optional(string, "/")
  }))
  default = []
}

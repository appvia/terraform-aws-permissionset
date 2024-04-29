variable "sso_groups" {
  description = "List of SSO groups to be retreived"
  type        = list(string)
  default = [
    "Cloud Administrators",
  ]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "Test"
    Terraform   = "True"
  }
}

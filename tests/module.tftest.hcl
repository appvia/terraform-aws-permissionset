mock_provider "aws" {}

run "basic" {
  command = plan

  variables {
    description  = "Permissons to view only billing information"
    instance_arn = "arn:aws:sso:::instance/ins-abc123456"
    name         = "MyTestPermissionSet"
    tags = {
      Environment = "Test"
      Terraform   = "True"
    }
  }
}

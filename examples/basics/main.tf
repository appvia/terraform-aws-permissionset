data "aws_organizations_organization" "this" {}
data "aws_ssoadmin_instances" "this" {}

data "aws_organizations_organizational_unit_descendant_accounts" "this" {
  parent_id = data.aws_organizations_organization.this.roots[0].id
}

# Lookup all the sso groups 
data "aws_identitystore_group" "groups" {
  for_each = toset(var.sso_groups)

  identity_store_id = local.identity_store_id

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.value
    }
  }
}

locals {
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  instance_arn      = tolist(data.aws_ssoadmin_instances.this.arns)[0]

  accounts = {
    for x in data.aws_organizations_organizational_unit_descendant_accounts.this.accounts :
    x.name => x.id if x.status == "ACTIVE"
  }
}

## Define the permission set
module "billing_viewer" {
  source = "../.."

  name         = "MyTestPermissionSet"
  description  = "Permissons to view only billing information"
  tags         = var.tags
  instance_arn = local.instance_arn

  customer_managed_inline_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "aws-portal:ViewBilling"
        Resource = "*"
      },
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSBillingConductorReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSBillingReadOnlyAccess",
    "arn:aws:iam::aws:policy/CostOptimizationHubReadOnlyAccess",
  ]

  managed_boundary_policy_arns = [
    "arn:aws:iam::aws:policy/AWSBillingConductorReadOnlyAccess",
  ]

  customer_managed_boundary_policy_references = [
    {
      name = "MyBoundaryPolicy"
    }
  ]

  assignments = [
    {
      principal_id = data.aws_identitystore_group.groups["Cloud Administrators"].group_id
      targets      = [local.accounts["appvia-io"]]
    }
  ]
}

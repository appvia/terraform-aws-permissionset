![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform AWS Permission Set

This module can be used to manage permission sets and assignments within AWS Identity Center. Permission sets can use both managed and customer managed policies to define permissions. Note this module does not create the custom policies in the target accounts, it is assumed to be performed by another function.

## Usage

The following example will provision a permission set with a managed policy and a customer managed policy attached to it, assigning the permission set to two groups.

```hcl
data "aws_ssoadmin_instances" "this" {}

locals {
  instance_arn      = tolist(data.aws_ssoadmin_instances.this.arns)[0]
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

module "permissionset" {
  source  = "appvia/permissionset/aws"
  version = "0.1.1"

  name                = "MyPermissionSet"
  description         = "Permission to do something in the cloud"
  instance_arn        = local.instance_arn
  tags                = var.tags

  # The managed policy arns to be attached to the permission set
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]

  # The customer managed policy references to be attached to the permission set
  customer_managed_policy_references = [
    {
      name = "MyCustomerManagedPolicy"
    }
  ]

  assignments = [
    {
      principal_id = data.aws_identitystore_group.groups["Cloud Administrators"].group_id
      targets      = var.another_list_of_accounts_ids
    },
    {
      principal_id = data.aws_identitystore_group.groups["Cloud Solutions"].group_id
      targets      = var.list_of_accounts_ids
    },
  ]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_assignments"></a> [assignments](#module\_assignments) | ./modules/assignment | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ssoadmin_customer_managed_policy_attachment.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_customer_managed_policy_attachment) | resource |
| [aws_ssoadmin_managed_policy_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_managed_policy_attachment) | resource |
| [aws_ssoadmin_permission_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set) | resource |
| [aws_ssoadmin_permission_set_inline_policy.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set_inline_policy) | resource |
| [aws_ssoadmin_permissions_boundary_attachment.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permissions_boundary_attachment) | resource |
| [aws_ssoadmin_permissions_boundary_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permissions_boundary_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description of this permission set to be created | `string` | n/a | yes |
| <a name="input_instance_arn"></a> [instance\_arn](#input\_instance\_arn) | The arn of the instance to which the permission set is to be attached | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of this permission set to be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to be attached to the permission set | `map(string)` | n/a | yes |
| <a name="input_assignments"></a> [assignments](#input\_assignments) | An optional list of assignments to be attached to the permission set | <pre>list(object({<br/>    principal_id   = string<br/>    principal_type = optional(string, "GROUP")<br/>    targets        = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_customer_managed_boundary_policy_reference"></a> [customer\_managed\_boundary\_policy\_reference](#input\_customer\_managed\_boundary\_policy\_reference) | Customer managed boundary policy reference to be attached to the permission set | <pre>object({<br/>    name = string<br/>    path = optional(string, "/")<br/>  })</pre> | `null` | no |
| <a name="input_customer_managed_inline_policy"></a> [customer\_managed\_inline\_policy](#input\_customer\_managed\_inline\_policy) | An optional inline policy to be attached to the permission set | `string` | `null` | no |
| <a name="input_customer_managed_policy_references"></a> [customer\_managed\_policy\_references](#input\_customer\_managed\_policy\_references) | The list of customer managed policy references to be attached to the permission set | <pre>list(object({<br/>    name = string<br/>    path = optional(string, "/")<br/>  }))</pre> | `[]` | no |
| <a name="input_managed_boundary_policy_arns"></a> [managed\_boundary\_policy\_arns](#input\_managed\_boundary\_policy\_arns) | The list of managed boundary policy arns to be attached to the permission set | `list(string)` | `[]` | no |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | The list of managed policy arns to be attached to the permission set | `list(string)` | `[]` | no |
| <a name="input_relay_state"></a> [relay\_state](#input\_relay\_state) | The relay state of the permission set, used to redirect users to a specific page after login | `string` | `null` | no |
| <a name="input_session_duration"></a> [session\_duration](#input\_session\_duration) | The duration of the session | `string` | `"PT2H"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_permission_set_arn"></a> [permission\_set\_arn](#output\_permission\_set\_arn) | The ARN of the permission set provisioned |
<!-- END_TF_DOCS -->

```

```

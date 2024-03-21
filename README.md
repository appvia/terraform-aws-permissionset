<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssoadmin_account_assignment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_ssoadmin_permission_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permission_set) | resource |
| [aws_ssoadmin_permissions_boundary_attachment.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permissions_boundary_attachment) | resource |
| [aws_ssoadmin_permissions_boundary_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_permissions_boundary_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assignment"></a> [assignment](#input\_assignment) | An optional list of accounts to assign the permission | <pre>object({<br>    principal_id = string<br>    targets      = list(string)<br>  })</pre> | <pre>{<br>  "principal_id": "",<br>  "targets": []<br>}</pre> | no |
| <a name="input_customer_managed_policy_references"></a> [customer\_managed\_policy\_references](#input\_customer\_managed\_policy\_references) | The list of customer managed policy references to be attached to the permission set | <pre>list(object({<br>    name = string<br>    path = optional(string, "/")<br>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of this permission set to be created | `string` | n/a | yes |
| <a name="input_instance_arn"></a> [instance\_arn](#input\_instance\_arn) | The arn of the instance to which the permission set is to be attached | `string` | n/a | yes |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | The list of managed policy arns to be attached to the permission set | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of this permission set to be created | `string` | n/a | yes |
| <a name="input_session_duration"></a> [session\_duration](#input\_session\_duration) | The duration of the session | `string` | `"PT2H"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to be attached to the permission set | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_permission_set_arn"></a> [permission\_set\_arn](#output\_permission\_set\_arn) | The ARN of the permission set provisioned |
<!-- END_TF_DOCS -->
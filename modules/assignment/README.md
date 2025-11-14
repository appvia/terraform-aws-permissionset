<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_arn"></a> [instance\_arn](#input\_instance\_arn) | The arn of the instance to which the permission set is to be attached | `string` | n/a | yes |
| <a name="input_permission_set_arn"></a> [permission\_set\_arn](#input\_permission\_set\_arn) | The ARN of the permission set | `string` | n/a | yes |
| <a name="input_principal_id"></a> [principal\_id](#input\_principal\_id) | The ID of the principal we are adding to the permission set | `string` | n/a | yes |
| <a name="input_principal_type"></a> [principal\_type](#input\_principal\_type) | The type of principal we are adding to the permission set | `string` | `"GROUP"` | no |
| <a name="input_targets"></a> [targets](#input\_targets) | The targets to which the permission set is to be attached | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
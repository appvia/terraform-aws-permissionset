<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sso_groups"></a> [sso\_groups](#input\_sso\_groups) | List of SSO groups to be retreived | `list(string)` | <pre>[<br/>  "Cloud Administrators"<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br/>  "Environment": "Test",<br/>  "Terraform": "True"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
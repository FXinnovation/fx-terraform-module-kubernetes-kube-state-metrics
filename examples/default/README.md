# terraform-module-kubernetes-kube-state-metrics (default example)

## Usage

To run this example, you need to execute:

```
$ terraform init
$ terraform plan
$ terraform apply
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default"></a> [default](#module\_default) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.default](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [random_string.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_cluster_role_binding_name"></a> [default\_cluster\_role\_binding\_name](#output\_default\_cluster\_role\_binding\_name) | n/a |
| <a name="output_default_cluster_role_name"></a> [default\_cluster\_role\_name](#output\_default\_cluster\_role\_name) | n/a |
| <a name="output_default_deployment_name"></a> [default\_deployment\_name](#output\_default\_deployment\_name) | n/a |
| <a name="output_default_service_account_name"></a> [default\_service\_account\_name](#output\_default\_service\_account\_name) | n/a |
| <a name="output_default_service_name"></a> [default\_service\_name](#output\_default\_service\_name) | n/a |
| <a name="output_default_service_port"></a> [default\_service\_port](#output\_default\_service\_port) | n/a |
| <a name="output_default_service_port_name"></a> [default\_service\_port\_name](#output\_default\_service\_port\_name) | n/a |
| <a name="output_disabled_cluster_role_binding_name"></a> [disabled\_cluster\_role\_binding\_name](#output\_disabled\_cluster\_role\_binding\_name) | n/a |
| <a name="output_disabled_cluster_role_name"></a> [disabled\_cluster\_role\_name](#output\_disabled\_cluster\_role\_name) | n/a |
| <a name="output_disabled_deployment_name"></a> [disabled\_deployment\_name](#output\_disabled\_deployment\_name) | n/a |
| <a name="output_disabled_service_account_name"></a> [disabled\_service\_account\_name](#output\_disabled\_service\_account\_name) | n/a |
| <a name="output_disabled_service_name"></a> [disabled\_service\_name](#output\_disabled\_service\_name) | n/a |
| <a name="output_disabled_service_port"></a> [disabled\_service\_port](#output\_disabled\_service\_port) | n/a |
| <a name="output_disabled_service_port_name"></a> [disabled\_service\_port\_name](#output\_disabled\_service\_port\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

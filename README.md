# terraform-module-kubernetes-kube-state-metrics

Terraform module that will deploy kube-state-metrics on kubernetes.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_deployment.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_service.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service_account.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [random_string.selector](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Additionnal annotations that will be merged on all resources. | `map` | `{}` | no |
| <a name="input_cluster_role_annotations"></a> [cluster\_role\_annotations](#input\_cluster\_role\_annotations) | Additionnal annotations that will be merged for the cluster\_role. | `map` | `{}` | no |
| <a name="input_cluster_role_binding_annotations"></a> [cluster\_role\_binding\_annotations](#input\_cluster\_role\_binding\_annotations) | Additionnal annotations that will be merged for the cluster\_role\_binding. | `map` | `{}` | no |
| <a name="input_cluster_role_binding_labels"></a> [cluster\_role\_binding\_labels](#input\_cluster\_role\_binding\_labels) | Additionnal labels that will be merged for the cluster\_role\_binding. | `map` | `{}` | no |
| <a name="input_cluster_role_binding_name"></a> [cluster\_role\_binding\_name](#input\_cluster\_role\_binding\_name) | Name of the cluster\_role\_binding that will be create | `string` | `"kube-state-metrics"` | no |
| <a name="input_cluster_role_labels"></a> [cluster\_role\_labels](#input\_cluster\_role\_labels) | Additionnal labels that will be merged for the cluster\_role. | `map` | `{}` | no |
| <a name="input_cluster_role_name"></a> [cluster\_role\_name](#input\_cluster\_role\_name) | Name of the cluster\_role that will be create | `string` | `"kube-state-metrics"` | no |
| <a name="input_deployment_annotations"></a> [deployment\_annotations](#input\_deployment\_annotations) | Additionnal annotations that will be merged on the deployment. | `map` | `{}` | no |
| <a name="input_deployment_labels"></a> [deployment\_labels](#input\_deployment\_labels) | Additionnal labels that will be merged on the deployment. | `map` | `{}` | no |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | Name of the deployment that will be create. | `string` | `"kube-state-metrics"` | no |
| <a name="input_deployment_service_account_name"></a> [deployment\_service\_account\_name](#input\_deployment\_service\_account\_name) | Only if `rbac_enabled` is false, name of the service account to be used by the container. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether or not to enable this module. | `bool` | `true` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Name of the docker image to use. | `string` | `"quay.io/coreos/kube-state-metrics"` | no |
| <a name="input_image_pull_policy"></a> [image\_pull\_policy](#input\_image\_pull\_policy) | Image pull policy on the main container. | `string` | `"IfNotPresent"` | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Tag of the docker image to use. | `string` | `"v1.6.0"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Additionnal labels that will be merged on all resources. | `map` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace in which the module will be deployed. | `string` | `"kube-system"` | no |
| <a name="input_prometheus_alert_groups_rules_annotations"></a> [prometheus\_alert\_groups\_rules\_annotations](#input\_prometheus\_alert\_groups\_rules\_annotations) | Map of strings that will be merge on all prometheus alert groups rules annotations. | `map` | `{}` | no |
| <a name="input_prometheus_alert_groups_rules_labels"></a> [prometheus\_alert\_groups\_rules\_labels](#input\_prometheus\_alert\_groups\_rules\_labels) | Map of strings that will be merge on all prometheus alert groups rules labels. | `map` | `{}` | no |
| <a name="input_rbac_enabled"></a> [rbac\_enabled](#input\_rbac\_enabled) | Whether or not to enabled rbac on the module. | `bool` | `true` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Number of replicas to deploy. | `number` | `1` | no |
| <a name="input_service_account_annotations"></a> [service\_account\_annotations](#input\_service\_account\_annotations) | Additionnal annotations that will be merged for the service\_account. | `map` | `{}` | no |
| <a name="input_service_account_automount_service_account_token"></a> [service\_account\_automount\_service\_account\_token](#input\_service\_account\_automount\_service\_account\_token) | Whether or not to automatically mount the service account token for the service account. | `bool` | `false` | no |
| <a name="input_service_account_labels"></a> [service\_account\_labels](#input\_service\_account\_labels) | Additionnal labels that will be merged for the service\_account. | `map` | `{}` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | Name of the service\_account that will be create | `string` | `"kube-state-metrics"` | no |
| <a name="input_service_annotations"></a> [service\_annotations](#input\_service\_annotations) | Additionnal annotations that will be merged for the service. | `map` | `{}` | no |
| <a name="input_service_labels"></a> [service\_labels](#input\_service\_labels) | Additionnal labels that will be merged for the service. | `map` | `{}` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service that will be create | `string` | `"kube-state-metrics"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_role_binding_name"></a> [cluster\_role\_binding\_name](#output\_cluster\_role\_binding\_name) | Name of the cluster\_role\_binding created by the module. |
| <a name="output_cluster_role_name"></a> [cluster\_role\_name](#output\_cluster\_role\_name) | Name of the cluster\_role created by the module. |
| <a name="output_deployment_name"></a> [deployment\_name](#output\_deployment\_name) | Name of the deployment created by the module. |
| <a name="output_prometheus_alert_groups"></a> [prometheus\_alert\_groups](#output\_prometheus\_alert\_groups) | List of ovjects representing prometheus alert groups |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | Name of the service\_account created by the module. |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | Name of the service created by the module. |
| <a name="output_service_port"></a> [service\_port](#output\_service\_port) | Port to be used to access the service. |
| <a name="output_service_port_name"></a> [service\_port\_name](#output\_service\_port\_name) | Name of the port to be used to access the service. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

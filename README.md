# terraform-module-kubernetes-kube-state-metrics

Terraform module that will deploy kube-state-metrics on kubernetes.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| kubernetes | >= 1.10.0 |
| random | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| annotations | Additionnal annotations that will be merged on all resources. | `map` | `{}` | no |
| cluster\_role\_annotations | Additionnal annotations that will be merged for the cluster\_role. | `map` | `{}` | no |
| cluster\_role\_binding\_annotations | Additionnal annotations that will be merged for the cluster\_role\_binding. | `map` | `{}` | no |
| cluster\_role\_binding\_labels | Additionnal labels that will be merged for the cluster\_role\_binding. | `map` | `{}` | no |
| cluster\_role\_binding\_name | Name of the cluster\_role\_binding that will be create | `string` | `"kube-state-metrics"` | no |
| cluster\_role\_labels | Additionnal labels that will be merged for the cluster\_role. | `map` | `{}` | no |
| cluster\_role\_name | Name of the cluster\_role that will be create | `string` | `"kube-state-metrics"` | no |
| deployment\_annotations | Additionnal annotations that will be merged on the deployment. | `map` | `{}` | no |
| deployment\_labels | Additionnal labels that will be merged on the deployment. | `map` | `{}` | no |
| deployment\_name | Name of the deployment that will be create. | `string` | `"kube-state-metrics"` | no |
| deployment\_service\_account\_name | Only if `rbac_enabled` is false, name of the service account to be used by the container. | `string` | n/a | yes |
| enabled | Whether or not to enable this module. | `bool` | `true` | no |
| image\_name | Name of the docker image to use. | `string` | `"quay.io/coreos/kube-state-metrics"` | no |
| image\_pull\_policy | Image pull policy on the main container. | `string` | `"IfNotPresent"` | no |
| image\_version | Tag of the docker image to use. | `string` | `"v1.6.0"` | no |
| labels | Additionnal labels that will be merged on all resources. | `map` | `{}` | no |
| namespace | Namespace in which the module will be deployed. | `string` | `"kube-system"` | no |
| prometheus\_alert\_groups\_rules\_annotations | Map of strings that will be merge on all prometheus alert groups rules annotations. | `map` | `{}` | no |
| prometheus\_alert\_groups\_rules\_labels | Map of strings that will be merge on all prometheus alert groups rules labels. | `map` | `{}` | no |
| rbac\_enabled | Whether or not to enabled rbac on the module. | `bool` | `true` | no |
| replicas | Number of replicas to deploy. | `number` | `1` | no |
| service\_account\_annotations | Additionnal annotations that will be merged for the service\_account. | `map` | `{}` | no |
| service\_account\_automount\_service\_account\_token | Whether or not to automatically mount the service account token for the service account. | `bool` | `false` | no |
| service\_account\_labels | Additionnal labels that will be merged for the service\_account. | `map` | `{}` | no |
| service\_account\_name | Name of the service\_account that will be create | `string` | `"kube-state-metrics"` | no |
| service\_annotations | Additionnal annotations that will be merged for the service. | `map` | `{}` | no |
| service\_labels | Additionnal labels that will be merged for the service. | `map` | `{}` | no |
| service\_name | Name of the service that will be create | `string` | `"kube-state-metrics"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_role\_binding\_name | Name of the cluster\_role\_binding created by the module. |
| cluster\_role\_name | Name of the cluster\_role created by the module. |
| deployment\_name | Name of the deployment created by the module. |
| prometheus\_alert\_groups | List of ovjects representing prometheus alert groups |
| service\_account\_name | Name of the service\_account created by the module. |
| service\_name | Name of the service created by the module. |
| service\_port | Port to be used to access the service. |
| service\_port\_name | Name of the port to be used to access the service. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

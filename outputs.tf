output "deployment_name" {
  description = "Name of the deployment created by the module."
  value       = element(concat(kubernetes_deployment.this.*.metadata.0.name, [""]), 0)
}

output "service_name" {
  description = "Name of the service created by the module."
  value       = element(concat(kubernetes_service.this.*.metadata.0.name, [""]), 0)
}

output "service_port" {
  description = "Port to be used to access the service."
  value       = var.enabled ? local.service_port : ""
}

output "service_port_name" {
  description = "Name of the port to be used to access the service."
  value       = var.enabled ? local.service_port_name : ""
}

output "service_account_name" {
  description = "Name of the service_account created by the module."
  value       = element(concat(kubernetes_service_account.this.*.metadata.0.name, [""]), 0)
}

output "cluster_role_name" {
  description = "Name of the cluster_role created by the module."
  value       = element(concat(kubernetes_cluster_role.this.*.metadata.0.name, [""]), 0)
}

output "cluster_role_binding_name" {
  description = "Name of the cluster_role_binding created by the module."
  value       = element(concat(kubernetes_cluster_role_binding.this.*.metadata.0.name, [""]), 0)
}

output "prometheus_alert_groups" {
  description = "List of ovjects representing prometheus alert groups"
  value       = var.enabled ? local.prometheus_alert_groups : []
}

#####
# Global
#####

variable "annotations" {
  description = "Additionnal annotations that will be merged on all resources."
  default     = {}
}

variable "enabled" {
  description = "Whether or not to enable this module."
  default     = true
}

variable "labels" {
  description = "Additionnal labels that will be merged on all resources."
  default     = {}
}

variable "namespace" {
  description = "Namespace in which the module will be deployed."
  default     = "kube-system"
}

variable "rbac_enabled" {
  description = "Whether or not to enabled rbac on the module."
  default     = true
}

#####
# Deployment
#####

variable "deployment_annotations" {
  description = "Additionnal annotations that will be merged on the deployment."
  default     = {}
}

variable "deployment_labels" {
  description = "Additionnal labels that will be merged on the deployment."
  default     = {}
}

variable "deployment_name" {
  description = "Name of the deployment that will be create."
  default     = "kube-state-metrics"
}

variable "deployment_service_account_name" {
  description = "Only if `rbac_enabled` is false, name of the service account to be used by the container."
  default     = null
  type        = string
}

variable "image_name" {
  description = "Name of the docker image to use."
  default     = "quay.io/coreos/kube-state-metrics"
}

variable "image_pull_policy" {
  description = "Image pull policy on the main container."
  default     = "IfNotPresent"
}

variable "image_version" {
  description = "Tag of the docker image to use."
  default     = "v1.6.0"
}

variable "replicas" {
  description = "Number of replicas to deploy."
  default     = 1
}

#####
# Service
#####

variable "service_annotations" {
  description = "Additionnal annotations that will be merged for the service."
  default     = {}
}

variable "service_labels" {
  description = "Additionnal labels that will be merged for the service."
  default     = {}
}

variable "service_name" {
  description = "Name of the service that will be create"
  default     = "kube-state-metrics"
}

#####
# Service Account
#####

variable "service_account_annotations" {
  description = "Additionnal annotations that will be merged for the service_account."
  default     = {}
}

variable "service_account_automount_service_account_token" {
  description = "Whether or not to automatically mount the service account token for the service account."
  default     = false
}

variable "service_account_labels" {
  description = "Additionnal labels that will be merged for the service_account."
  default     = {}
}

variable "service_account_name" {
  description = "Name of the service_account that will be create"
  default     = "kube-state-metrics"
}

#####
# Cluster Role
#####

variable "cluster_role_annotations" {
  description = "Additionnal annotations that will be merged for the cluster_role."
  default     = {}
}

variable "cluster_role_labels" {
  description = "Additionnal labels that will be merged for the cluster_role."
  default     = {}
}

variable "cluster_role_name" {
  description = "Name of the cluster_role that will be create"
  default     = "kube-state-metrics"
}

#####
# Cluster Role Binding
#####

variable "cluster_role_binding_annotations" {
  description = "Additionnal annotations that will be merged for the cluster_role_binding."
  default     = {}
}

variable "cluster_role_binding_labels" {
  description = "Additionnal labels that will be merged for the cluster_role_binding."
  default     = {}
}

variable "cluster_role_binding_name" {
  description = "Name of the cluster_role_binding that will be create"
  default     = "kube-state-metrics"
}

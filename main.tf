#####
# Locals
#####

locals {
  labels = {
    "app.kubernetes.io/version"    = var.image_version
    "app.kubernetes.io/component"  = "exporter"
    "app.kubernetes.io/part-of"    = "monitoring"
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/name"       = "kube-state-metrics"
  }
  port              = 8080
  service_port      = 80
  service_port_name = "http"
  prometheus_alert_groups_rules_labels = merge(
    {
      "source" = "https://github.com/FXinnovation/fx-terraform-module-kubernetes-kube-state-metrics"
    },
    var.prometheus_alert_groups_rules_labels
  )
  prometheus_alert_groups_rules_annotations = merge(
    {},
    var.prometheus_alert_groups_rules_annotations
  )
  prometheus_alert_groups = [
    {
      "name" = "kube-state-metrics"
      "rules" = [
        {
          "alert" = "kube-state-metrics - deployment availability warning"
          "expr"  = "(kube_deployment_status_replicas_available / kube_deployment_spec_replicas) * 100 < 100"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Deployment replica availability warning on {{ $labels.namespace }}-{{ $labels.deployment }}"
              "description" = "kube-state-metrics:\nDeployment {{ $labels.deployment }} in namespace {{ $labels.namespace }} has had less then 100% available replica's for 15min.\nValue: {{ $value }}%\nLabels: {{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - deployment availability critical"
          "expr"  = "(kube_deployment_status_replicas_available / kube_deployment_spec_replicas) * 100 < 50"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Deployment replica availability critical on {{ $labels.namespace }}-{{ $labels.deployment }}"
              "description" = "kube-state-metrics:\nDeployment {{ $labels.deployment }} in namespace {{ $labels.namespace }} has had less then 50% available replica's for 15min.\nValue: {{ $value }}%\nLabels: {{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - deployment availability down"
          "expr"  = "(kube_deployment_status_replicas_available / kube_deployment_spec_replicas) * 100 == 0 and kube_deployment_spec_replicas > 1"
          "for"   = "1m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Deployment down on {{ $labels.namespace }}-{{ $labels.deployment }}"
              "description" = "kube-state-metrics:\nDeployment {{ $labels.deployment }} in namespace {{ $labels.namespace }} has had 0% available replica's for 1min.\nLabels: {{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - deployment availability down single replica"
          "expr"  = "(kube_deployment_status_replicas_available / kube_deployment_spec_replicas) * 100 == 0 and kube_deployment_spec_replicas == 1"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Deployment down on {{ $labels.namespace }}-{{ $labels.deployment }}"
              "description" = "kube-state-metrics:\nDeployment {{ $labels.deployment }} in namespace {{ $labels.namespace }} has had 0% available replica's for 15min.\nLabels: {{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - statefulset availability warning"
          "expr"  = "(kube_statefulset_status_replicas_ready / kube_statefulset_replicas) * 100 < 100"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Statefulset replica availability warning on {{ $labels.namespace }}-{{ $labels.statefulset }}"
              "description" = "kube-state-metrics:\nStatefulset {{ $labels.statefulset }} in namespace {{ $labels.namespace }} has had less then 100% available replica's for 15min.\nValue: {{ $value }}%\nLabels: {{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - statefulset availability critical"
          "expr"  = "(kube_statefulset_status_replicas_ready / kube_statefulset_replicas) * 100 < 50"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Statefulset replica availability critical on {{ $labels.namespace }}-{{ $labels.statefulset }}"
              "description" = "kube-state-metrics:\nStatefulset {{ $labels.statefulset }} in namespace {{ $labels.namespace }} has had less then 50% available replica's for 15min.\nValue: {{ $value }}%\nLabels: {{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - statefulset availability down"
          "expr"  = "(kube_statefulset_status_replicas_ready / kube_statefulset_replicas) * 100 == 0 and kube_statefulset_replicas > 1"
          "for"   = "1m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Statefulset down on {{ $labels.namespace }}-{{ $labels.statefulset }}"
              "description" = "kube-state-metrics:\nStatefulset {{ $labels.statefulset }} in namespace {{ $labels.namespace }} has had 0% available replica's for 1min.\nLabels: {{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - statefulset availability down single replica"
          "expr"  = "(kube_statefulset_status_replicas_ready / kube_statefulset_replicas) * 100 == 0 and kube_statefulset_spec_replicas == 1"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Statefulset down on {{ $labels.namespace }}-{{ $labels.statefulset }}"
              "description" = "kube-state-metrics:\nStatefulset {{ $labels.statefulset }} in namespace {{ $labels.namespace }} has had 0% available replica's for 15min.\nLabels: {{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - daemonset availability critical"
          "expr"  = "(kube_daemonset_status_number_ready / kube_daemonset_status_desired_number_scheduled) * 100  < 100"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Daemonset Replica Availability Critical on {{ $labels.namespace }}-{{ $labels.daemonset }}"
              "description" = "kube-state-metrics:\nDaemonset {{ $labels.daemonset }} in namespace {{ $labels.namespace }} has had less then 100% available replica's for 5min.\nValue: {{ $value }}%\nLabels: {{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - pod container oom killed"
          "expr"  = "kube_pod_container_status_terminated_reason{reason=\"OOMKilled\"} > 0"
          "for"   = "1m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Container got {{ $labels.reason }} for {{ $labels.namespace }}-{{ $labels.pod }}-{{ $labels.container }}"
              "description" = "kube-state-metrics:\nContainer {{ $labels.container }} got {{ $labels.reason }} on pod {{ $labels.pod }} in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - pod container cannot run"
          "expr"  = "kube_pod_container_status_terminated_reason{reason=\"ContainerCannotRun\"} > 0"
          "for"   = "1m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Container teminated with {{ $labels.reason }} reason for {{ $labels.namespace }}-{{ $labels.pod }}-{{ $labels.container }}"
              "description" = "kube-state-metrics:\nContainer {{ $labels.container }} teminated with {{ $labels.reason }} Run on pod {{ $labels.pod }} in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - pod container crashloop backoff"
          "expr"  = "kube_pod_container_status_waiting_reason{reason=\"CrashLoopBackOff\"} > 0"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Container {{ $labels.namespace }}-{{ $labels.pod }}-{{ $labels.container }} is waiting creation with {{ $labels.reason }} reason."
              "description" = "kube-state-metrics:\nContainer {{ $labels.container }} is waiting to be created with {{ $labels.reason }} reason on pod {{ $labels.pod }} in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - pod container config creation error"
          "expr"  = "kube_pod_container_status_waiting_reason{reason=\"CreateContainerConfigError\"} > 0"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Container {{ $labels.namespace }}-{{ $labels.pod }}-{{ $labels.container }} is waiting creation with {{ $labels.reason }} reason."
              "description" = "kube-state-metrics:\nContainer {{ $labels.container }} is waiting to be created with {{ $labels.reason }} reason on pod {{ $labels.pod }} in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - pod container image pull backoff"
          "expr"  = "kube_pod_container_status_waiting_reason{reason=\"ImagePullBackOff\"} > 0"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Container {{ $labels.namespace }}-{{ $labels.pod }}-{{ $labels.container }} is waiting creation with {{ $labels.reason }} reason."
              "description" = "kube-state-metrics:\nContainer {{ $labels.container }} is waiting to be created with {{ $labels.reason }} reason on pod {{ $labels.pod }} in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - pod failed phase"
          "expr"  = "kube_pod_status_phase{phase=\"Failed\"} > 0"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Pod {{ $labels.namespace }}-{{ $labels.pod }} has a phase of Failed."
              "description" = "kube-state-metrics:\nPod {{ $labels.pod }} has been in phase Failed for 15m in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - pod unknown phase"
          "expr"  = "kube_pod_status_phase{phase=\"Unknown\"} > 0"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Pod {{ $labels.namespace }}-{{ $labels.pod }} has a phase of Unknown."
              "description" = "kube-state-metrics:\nPod {{ $labels.pod }} has been in phase Unknown for 15m in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - persistent volume failed phase"
          "expr"  = "kube_persistentvolume_status_phase{phase=\"Failed\"} > 0"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Persistent Volume {{ $labels.namespace }}-{{ $labels.persistentvolume }} has a phase of Failed."
              "description" = "kube-state-metrics:\nPersistent Volume {{ $labels.persistentvolume }} has been in phase Failed for 5m in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - persistent volume pending phase"
          "expr"  = "kube_persistentvolume_status_phase{phase=\"Pending\"} > 0"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Persistent Volume {{ $labels.namespace }}-{{ $labels.persistentvolume }} has a phase of Pending."
              "description" = "kube-state-metrics:\nPersistent Volume {{ $labels.persistentvolume }} has been in phase Pending for 15m in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - persistent volume claim pending phase"
          "expr"  = "kube_persistentvolumeclaim_status_phase{phase=\"Pending\"} > 0"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Persistent Volume Claim {{ $labels.namespace }}-{{ $labels.persistentvolumeclaim }} has a phase of Pending."
              "description" = "kube-state-metrics:\nPersistent Volume Claim {{ $labels.persistentvolumeclaim }} has been in phase Pending for 15m in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - persistent volume claim lost phase"
          "expr"  = "kube_persistentvolumeclaim_status_phase{phase=\"Lost\"} > 0"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Persistent Volume Claim {{ $labels.namespace }}-{{ $labels.persistentvolumeclaim }} has a phase of Lost."
              "description" = "kube-state-metrics:\nPersistent Volume Claim {{ $labels.persistentvolumeclaim }} has been in phase Lost for 5m in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - endpoint address not ready"
          "expr"  = "kube_endpoint_address_not_ready > 0"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Endpoint Address {{ $labels.namespace }}-{{ $labels.endpoint }} is not in a Ready state."
              "description" = "kube-state-metrics:\nEndpoint Address {{ $labels.endpoint }} has not been Ready for 5m in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - service load balancer ingress down"
          "expr"  = "kube_service_status_load_balancer_ingress < 1"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Service Load Balancer Ingress {{ $labels.namespace }}-{{ $labels.service }} is down."
              "description" = "kube-state-metrics:\nService Load Balancer Ingress {{ $labels.service }} has not been down for 5m in namespace {{ $labels.namespace }}\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - node condition unkown"
          "expr"  = "kube_node_status_condition{status=\"unknown\"} > 0"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Condition {{ $labels.condition }} on node {{ $labels.node }} is unknown."
              "description" = "kube-state-metrics:\nCondition {{ $labels.condition }} on node {{ $labels.node }} has been unknown for 5m.\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - node condition true"
          "expr"  = "kube_node_status_condition{condition!=\"Ready\",status=\"true\"} > 0"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Condition {{ $labels.condition }} on node {{ $labels.node }} is failing."
              "description" = "kube-state-metrics:\nCondition {{ $labels.condition }} on node {{ $labels.node }} has been failing for 5m.\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - node condition false"
          "expr"  = "kube_node_status_condition{condition=\"Ready\",status=\"false\"} > 0"
          "for"   = "5m"
          "labels" = merge(
            {
              "severity" = "critical"
              "urgency"  = "2"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Condition {{ $labels.condition }} on node {{ $labels.node }} is failing."
              "description" = "kube-state-metrics:\nCondition {{ $labels.condition }} on node {{ $labels.node }} has been failing for 5m.\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - node memory limits warning"
          "expr"  = "sum(kube_pod_container_resource_limits_memory_bytes) by (instance, node) * 100 / sum(kube_node_status_allocatable_memory_bytes) by (instance, node) > 200"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Node {{ $labels.node }} on cluster {{ $labels.instance }} is under-provisionned in memory"
              "description" = "kube-state-metrics:\nNode {{ $labels.node }} on cluster {{ $labels.instance }} is under-provisionned in memory.\nDescription:\nPods on that node are allowed to use up to {{ $value }}% of the allocatable memory on the node.\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - node memory requests warning"
          "expr"  = "sum(kube_pod_container_resource_requests_memory_bytes) by (instance, node) * 100 / sum(kube_node_status_allocatable_memory_bytes) by (instance, node) > 100"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Node {{ $labels.node }} on cluster {{ $labels.instance }} is dangerously under-provisionned in memory"
              "description" = "kube-state-metrics:\n\nNode {{ $labels.node }} on cluster {{ $labels.instance }} is dangerously under-provisionned in memory.\nDescription:\nPods on the node are requesting {{ $value }}% of the allocatable memory of the node.\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - cluster memory limits warning"
          "expr"  = "sum(kube_pod_container_resource_limits_memory_bytes) by (instance) * 100 / sum(kube_node_status_allocatable_memory_bytes) by (instance) > 200"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Cluster {{ $labels.instance }} is under-provisionned in memory"
              "description" = "kube-state-metrics:\n\nCluster {{ $labels.instance }} is under-provisionned in memory.\nDescription:\nPods on the cluster are currently allowed to use up to {{ $value }}% of the allocatable memory of the cluster.\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        },
        {
          "alert" = "kube-state-metrics - cluster memory requests warning"
          "expr"  = "sum(kube_pod_container_resource_requests_memory_bytes) by (instance) * 100 / sum(kube_node_status_allocatable_memory_bytes) by (instance) > 100"
          "for"   = "15m"
          "labels" = merge(
            {
              "severity" = "warning"
              "urgency"  = "3"
            },
            local.prometheus_alert_groups_rules_labels
          )
          "annotations" = merge(
            {
              "summary"     = "kube-state-metrics - Cluster {{ $labels.instance }} is dangerously under-provisionned in memory"
              "description" = "kube-state-metrics:\n\nCluster {{ $labels.instance }} is dangerously under-provisionned in memory.\nDescription:\nPods on the cluster are requesting {{ $value }}% of the allocatable memory of the cluster.\nLabels:\n{{ $labels }}"
            },
            local.prometheus_alert_groups_rules_annotations
          )
        }
      ]
    }
  ]
}

#####
# Randoms
#####

resource "random_string" "selector" {
  special = false
  upper   = false
  numeric = false
  length  = 8
}

#####
# Deployment
#####

resource "kubernetes_deployment" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.deployment_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.deployment_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.deployment_name
      },
      local.labels,
      var.labels,
      var.deployment_labels
    )
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app    = "kube-state-metrics"
        random = random_string.selector.result
      }
    }
    template {
      metadata {
        annotations = merge(
          var.annotations,
          var.deployment_annotations
        )
        labels = merge(
          {
            "app.kubernetes.io/instance" = var.deployment_name
            app                          = "kube-state-metrics"
            random                       = random_string.selector.result
          },
          local.labels,
          var.labels,
          var.deployment_labels
        )
      }
      spec {
        automount_service_account_token = true
        service_account_name            = var.rbac_enabled ? element(concat(kubernetes_service_account.this.*.metadata.0.name, [""]), 0) : var.deployment_service_account_name
        container {
          name              = "kube-state-metrics"
          image             = "${var.image_name}:${var.image_version}"
          image_pull_policy = var.image_pull_policy

          readiness_probe {
            http_get {
              path   = "/"
              port   = local.port
              scheme = "HTTP"
            }

            timeout_seconds   = 5
            period_seconds    = 5
            success_threshold = 1
            failure_threshold = 35
          }

          liveness_probe {
            http_get {
              path   = "/"
              port   = local.port
              scheme = "HTTP"
            }

            timeout_seconds   = 5
            period_seconds    = 10
            success_threshold = 1
            failure_threshold = 3
          }

          port {
            name           = "metrics"
            container_port = local.port
            protocol       = "TCP"
          }

          resources {
            requests = {
              memory = "16Mi"
              cpu    = "10m"
            }
            limits = {
              memory = "128Mi"
              cpu    = "50m"
            }
          }
        }
      }
    }
  }
}

#####
# Service
#####

resource "kubernetes_service" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.service_name
    namespace = var.namespace
    annotations = merge(
      {
        "prometheus.io/scrape" = "true"
      },
      var.annotations,
      var.service_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.service_name
      },
      local.labels,
      var.labels,
      var.service_labels
    )
  }

  spec {
    selector = {
      random = random_string.selector.result
      app    = "kube-state-metrics"
    }
    type = "ClusterIP"
    port {
      port        = local.service_port
      target_port = "metrics"
      protocol    = "TCP"
      name        = local.service_port_name
    }
  }
}

#####
# Service Account
#####

resource "kubernetes_service_account" "this" {
  count = var.enabled && var.rbac_enabled ? 1 : 0

  automount_service_account_token = var.service_account_automount_service_account_token

  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.service_account_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.service_account_name
      },
      local.labels,
      var.labels,
      var.service_account_labels
    )
  }

}

#####
# Cluster Role
#####

resource "kubernetes_cluster_role" "this" {
  count = var.enabled && var.rbac_enabled ? 1 : 0

  metadata {
    name = var.cluster_role_name
    annotations = merge(
      var.annotations,
      var.cluster_role_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.cluster_role_name
      },
      local.labels,
      var.labels,
      var.cluster_role_labels
    )
  }

  rule {
    api_groups = [""]
    resources = [
      "namespaces",
      "nodes",
      "persistentvolumeclaims",
      "pods",
      "services",
      "resourcequotas",
      "replicationcontrollers",
      "limitranges",
      "persistentvolumeclaims",
      "persistentvolumes",
      "endpoints",
      "secrets",
      "configmaps",
    ]
    verbs = ["list", "watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["daemonsets", "deployments", "ingresses", "replicasets"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["daemonsets", "deployments", "statefulsets", "replicasets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["conjobs", "job"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["autoscaling"]
    resources  = ["horizontalpodautoscalers"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["authorization.k8s.io"]
    resources  = ["subjectaccessreviews"]
    verbs      = ["create"]
  }

  rule {
    api_groups = ["policy"]
    resources  = ["poddisruptionbudgets"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["certificates.k8s.io"]
    resources  = ["certificatesigningrequests"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["networkpolicies", "ingresses"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["coordination.k8s.io"]
    resources  = ["leases"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["storageclasses", "volumeattachments"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["admissionregistration.k8s.io"]
    resources  = ["mutatingwebhookconfigurations", "validatingwebhookconfigurations"]
    verbs      = ["list", "watch"]
  }
}

#####
# Cluster Rolebinding
#####

resource "kubernetes_cluster_role_binding" "this" {
  count = var.enabled && var.rbac_enabled ? 1 : 0

  metadata {
    name = var.cluster_role_binding_name
    annotations = merge(
      var.annotations,
      var.cluster_role_binding_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.cluster_role_binding_name
      },
      local.labels,
      var.labels,
      var.cluster_role_binding_labels
    )
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = element(concat(kubernetes_cluster_role.this.*.metadata.0.name, [""]), 0)
  }

  subject {
    kind      = "ServiceAccount"
    name      = element(concat(kubernetes_service_account.this.*.metadata.0.name, [""]), 0)
    namespace = var.namespace
  }
}

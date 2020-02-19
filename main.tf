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
}

#####
# Randoms
#####

resource "random_string" "selector" {
  special = false
  upper   = false
  number  = false
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
        service_account_name            = var.rbac_enabled ? element(concat(kubernetes_service_account.this.*.metadata.0.name, list("")), 0) : var.deployment_service_account_name
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
            requests {
              memory = "16Mi"
              cpu    = "10m"
            }
            limits {
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
    resources  = ["daemonsets", "deployments", "statefulsets"]
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
    api_groups = ["policy"]
    resources  = ["poddisruptionbudgets"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["certificates.k8s.io"]
    resources  = ["certificatesigningrequests"]
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
    name      = element(concat(kubernetes_cluster_role.this.*.metadata.0.name, list("")), 0)
  }

  subject {
    kind      = "ServiceAccount"
    name      = element(concat(kubernetes_service_account.this.*.metadata.0.name, list("")), 0)
    namespace = var.namespace
  }
}

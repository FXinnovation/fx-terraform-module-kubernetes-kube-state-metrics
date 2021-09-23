#####
# Randoms
#####

resource "random_string" "default" {
  upper   = false
  number  = false
  special = false
  length  = 8
}

#####
# Context
#####

resource "kubernetes_namespace" "default" {
  metadata {
    name = random_string.default.result
  }

  # for some reasons, the build can fail while attempting to
  # delete the namespace. since the default timeout is 5m
  # we will use 10m for this purpose, as a workaround.
  timeouts {
    delete = "30m"
  }
}

#####
# default example
#####

module "default" {
  source = "../.."

  namespace = kubernetes_namespace.default.metadata.0.name
}

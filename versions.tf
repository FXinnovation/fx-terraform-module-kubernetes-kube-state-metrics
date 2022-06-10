terraform {
  required_version = ">= 1.0"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    random = ">= 2.0.0"
  }
}

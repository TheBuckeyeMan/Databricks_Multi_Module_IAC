terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.10.0"
    }
  }

  cloud {
    organization = "1220-IAC"
    workspaces {
      name = "databricks_cluster_deployment"
    }
  }
}

provider "aws" {
    region = var.region
    access_key  = var.aws_access_key
    secret_key  = var.aws_secret_key
}

provider "databricks" {
  host     = var.HOST
  token    = var.PAT
}
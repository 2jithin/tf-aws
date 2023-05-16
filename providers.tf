# aws tf provider 
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0"
      #version = "~> 4.0"
    }
  }
}

provider "random" {
}

provider "tls" {}

resource "tls_private_key" "t" {
  algorithm = "RSA"
}
provider "local" {}

resource "local_file" "key" {
  content  = tls_private_key.t.private_key_pem
  filename = "id_rsa"
  provisioner "local-exec" {
    command = "chmod 600 id_rsa"
  }
}

resource "random_string" "admin_passwords" {
  count            = var.instance_count
  length           = 16
  special          = true
  override_special = "_%@"
  upper            = true
  lower            = true
  keepers = {
    timestamp = timestamp()
  }
}

resource "random_password" "ec2_passwords" {
  count       = var.instance_count
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}



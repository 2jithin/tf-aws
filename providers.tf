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
      source = "hashicorp/aws"
      version = ">= 3.66.0"
      #version = "~> 4.0"
    }
  }
}

provider "random" {
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
  count            = var.instance_count
  length = 16
  special = false
  min_upper = 1
  min_lower = 1
  min_numeric = 1
}

output "output_password" {
  value = random_password.ec2_passwords.*.result
}
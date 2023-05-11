# All root variables.
variable "stage" {
  type        = string
  default     = "dev"
  description = "The dev stage"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "access_key" {
  description = "access key"
  type        = string
  default     = "AKIATBNIB4Z3SYMM4UUN"
  sensitive   = true
}

variable "secret_key" {
  type      = string
  default   = "kJN+bi22MLC/Wz7WfEqeNqxnY7KP48Ve7wBT+g/1"
  sensitive = true

}

variable "path_to_public_key" {
  default = "ssh_keys/dev_mykey.pub"
}

variable "get_password_data" {
  description = "If true, wait for password data to become available and retrieve it"
  type        = bool
  default     = null
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-03c7d01cf4dedc891"
    us-east-2 = "ami-007855ac798b5175e"
  }
}

variable "ec2_type" {
  type        = string
  description = "size of the ec2 type like small ,micro, large etc.."
  default     = "t2.micro"
}

variable "stage_mapping" {
  type = map(object({
    unique_stage : string
    shared_stage : string
  }))
  default = {
    "dev" : {
      unique_stage : "dev"
      shared_stage : "nonprod"
    },
    "qa" : {
      unique_stage : "qa"
      shared_stage : "nonprod"
    },
    "prod" : {
      unique_stage : "prod"
      shared_stage : "prod"
    }
  }
}

variable "project" {
  type    = string
  default = "terraform_task"
}

variable "name" {
  type    = string
  default = "eus1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "instance_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 2
  validation {
    condition = var.instance_count >= 2 && var.instance_count <= 100
    error_message = "Number of VMs must be between 2 and 100"
  }
}

variable "vm_flavor" {
  description = "VM flavor"
  type        = string
  default     = "t2.micro"
}

variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting EC2 instance resources"
  type        = map(string)
  default     = {}
}

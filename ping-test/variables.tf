# Module Variables
variable "instance_ids" {
  description = "List of EC2 instance IDs to perform ping test on"
  type        = list(string)
}

variable "path_to_private_key" {
  description = "private key path"
  type        = string
}

variable "private_ip" {
  description = "private ip"
  type        = list(string)
}

variable "instance_count" {
  description = "Number of VMs to create"
  type        = number
}
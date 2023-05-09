# Module Variables
variable "instance_ids" {
  description = "List of EC2 instance IDs to perform ping test on"
  type        = list(string)
}

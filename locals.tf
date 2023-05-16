# Static functions and Labels
locals {
  unique_stage        = lookup(var.stage_mapping, lower(var.stage)).unique_stage
  environment         = var.stage
  timestamp           = timestamp()
  timestamp_sanitized = replace("${local.timestamp}", "/[-| |T|Z|:]/", "")
}

locals {
  public_ips = [for instance in aws_instance.ec2-instance : instance.public_ip]
}
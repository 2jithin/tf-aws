output "aws_eip" {
  value = try(aws_instance.ec2-instance.*.public_ip, null)
}

output "aws_vpc" {
  value = try(aws_vpc.main.id, null)
}
output "ec2_complete_instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = try(aws_instance.ec2-instance.*.instance_state, null)
}

output "ping_results" {
  value = {
    for i in aws_instance.ec2-instance[*] :
    i.id => i.public_ip
  }
}

# store result
# resource "local_file" "output_file" {
#   filename = "ping_results.txt"
#   content  = join(" ", [for r in aws_instance.ec2-instance : r])
# }

# output "ec2_admin_passwords" {
#   value = random_string.admin_passwords[*].result
# }
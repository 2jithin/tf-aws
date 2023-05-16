#ping task code
module "ping_test" {
  source                = "./ping-test"
  instance_ids          = aws_instance.ec2-instance.*.public_ip
  path_to_private_key   = var.path_to_private_key
  private_id            = aws_instance.ec2-instance.*.private_ip
}

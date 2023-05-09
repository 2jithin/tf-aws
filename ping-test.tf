# ping task code
module "ping_test" {
  source       = "./ping-test"
  instance_ids = aws_instance.ec2-instance.*.public_ip
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = aws_vpc.main.id
}

output "default_security_group_id" {
  value = data.aws_security_group.default.id
}

resource "aws_security_group_rule" "default" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.default.id
}

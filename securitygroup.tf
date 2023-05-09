resource "random_string" "random" {
  length  = 3
  lower   = true
  special = false

}

# Security group

resource "aws_security_group" "allow-ssh" {
  name        = "asg-allow-ssh-${random_string.random.id}"
  vpc_id      = aws_vpc.main.id
  description = "security group that allows ssh and all egress traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [ingress, egress]
  }

  tags = {
    Name = "sg-${var.project}_${random_string.random.id}_${local.unique_stage}"
  }
}

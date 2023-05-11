# EC2 Provision
resource "aws_instance" "ec2-instance" {

  count             = var.instance_count
  get_password_data = var.get_password_data

  ami = var.AMIS[var.region]

  instance_type = var.ec2_type

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name


  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              useradd admin # Create the admin user
              usermod -aG wheel admin  # Add the admin user to the sudo group
              admin -c 'mkdir ~/.ssh'  # Create the .ssh directory for the admin user
              su admin -c 'chmod 700 ~/.ssh'  # Set permissions for the .ssh directory
              su admin -c 'touch ~/.ssh/authorized_keys'  # Create the authorized_keys file
              su admin -c 'chmod 600 ~/.ssh/authorized_keys'  # Set permissions for the authorized_keys file
              echo "admin:${random_string.admin_passwords[count.index].result}" | chpasswd
              EOF
  lifecycle {
    ignore_changes        = [tags]
    create_before_destroy = true
  }

  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }

  tags = {
    Name        = "ec2_${count.index + 1}-${var.project}_${local.unique_stage}"
    Batch       = "5AM"
    Terraform   = "true"
    Environment = var.stage
  }
  provisioner "file" {
    source       = "ssh_keys/dev_mykey.pem"
    destination =  ".ssh/dev_mykey.pem"
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("ssh_keys/dev_mykey.pem")
      host = self.public_ip
      timeout = "4m"
    }
  }

  # provisioner "local-exec" {
  #   command     = "ping -c 1 ${aws_instance.ec2-instance[(var.instance_count + 1) % var.instance_count].private_ip} > /dev/null && echo 'Ping successful' >> ping_results.txt || echo 'Ping failed' >> ping_results.txt"
  #   #command     = "ping -c 1 ${self.private_ip} >/dev/null 2>&1; if [ $? -eq 0 ]; then echo 'Ping from $source_ip to $target_ip: PASS'; else echo 'Ping from $source_ip to $target_ip: FAIL'; fi"
  #   when        = create
  #   interpreter = ["/bin/bash", "-c"]
  #   on_failure  = continue
  # }

  #   provisioner "remote-exec" {
  #     inline = [
  #       "ping -c 1 ${element(self.private_ip, (count.index + 1) % var.instance_count)} > /dev/null && echo 'Ping successful' || echo 'Ping failed'"
  #     ]
  #     on_failure  = continue
  # }
}


data "aws_instance" "ec2" {
  count = var.instance_count
  depends_on  = [aws_instance.ec2-instance]
  instance_id = "${element(aws_instance.ec2-instance.*.id,count.index)}"
  #instance_id = "${element(aws_instance.ec2-instance.*.id,count.index)}${count.index + 1}"
}
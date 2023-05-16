# module
resource "null_resource" "ping_test" {
  count = length(var.instance_ids)

  triggers = {
    instance_id = var.instance_ids[count.index]
    exec        = uuid() // everytime gets changed
  }

  # provisioner "file" {
        
  # }
  # provisioner "local-exec" {
  #   command = "echo -n  ${element(var.instance_ids, count.index)} >> output.tf"
  # }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      # agent = true
      host = "${element(var.instance_ids, count.index)}"
      user = "ec2-user"
      private_key = file(var.path_to_private_key)  //ssh_keys/dev_mykey.pem
    }
    inline = [ "ping -c 3 ${element(var.private_ip, count.index+1) % var.instance_count}" ]
  }
}

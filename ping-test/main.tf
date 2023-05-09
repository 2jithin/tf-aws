# module
resource "null_resource" "ping_test" {
  count = length(var.instance_ids)

  triggers = {
    instance_id = var.instance_ids[count.index]
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      agent = true
      host = "${element(var.instance_ids, count.index)}"
      user = "root"
      private_key = "${file("ssh_keys/dev_mykey.pem")}"
    }
    inline = [ "ping -c 3 ${element(var.instance_ids, count.index)}" ]
  }
}

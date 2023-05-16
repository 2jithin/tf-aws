resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair-${uuid()}"
  public_key = file(var.path_to_public_key)
  lifecycle {
    ignore_changes        = [key_name, public_key]
    create_before_destroy = false
  }
}

output "keypair" {
  value = aws_key_pair.mykeypair.public_key
}
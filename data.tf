
data "aws_instance" "ec2" {
  count       = var.instance_count
  depends_on  = [aws_instance.ec2-instance]
  instance_id = element(aws_instance.ec2-instance.*.id, count.index)
  #instance_id = "${element(aws_instance.ec2-instance.*.id,count.index)}${count.index + 1}"
}
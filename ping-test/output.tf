output "public_ip" {
    value  = null_resource.ping_test.instance_id[*]      
}
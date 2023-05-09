# Setting Up EC2 Instances in a VPC and associated services

## Introduction


This Terraform code required to provision an EC2 instance inside a VPC. While doing so, it will,

- provision public and private subnet.
- expose the EC2 instance to the internet via an Internet Gateway.
- place required route associations in route tables.
- create a NAT gateway to allow internet access in private subnets.

### Prerequisites

In Bosch n/w need to install px.exe application and create system enviroment with proxy url then only terraform remote modules can be download to local

### Code organization

Code in this repository is organized as below,

```
|-- backend.tf
|-- ebs.tf
|-- instance.tf
|-- internetgateway.tf
|-- key.tf
|-- nat.tf
|-- providers.tf
|-- securitygroup.tf
|-- subnets.tf
|-- vars.tf
|-- vpc.tf
```

`backend.tf`: Configures the Terraform backend requires to store state remotely. In this case the backend is AWS S3.

`ebs.tf`: Declares the AWS EBS resource required to be provisioned to mount into the EC2 instances.

`instance.tf`: Declares the AWS EC2 instance required in the solution.

`internetgateway.tf`: Declares the internet gateway, the route table for public access, and routing rules for the public subnet.

`key.tf`: Declares the public key required to place in EC2 instance.

`nat.tf`: Declares the NAT gateway, the private route table, and routing rules for the private subnet.

`providers.tf`: Declares the AWS terrform provider.

`securitygroup.tf`: Declares the security group associated with the VPC to define ingress and egress.

`subnets.tf`: Declares the public and private subnets of the VPC.

`vars.tf`: Declares all the variables to be used by the infrastructure code.

`vpc.tf`: Declares the virtual private cloud.

### EC2 Instance

EC2 instances are the virtual machine instances. These can be launched in the default VPC or in a private VPC and attach it to a subnet.


### Naming Standard

variable naming <var> <string>/<null> // to meaningful name

resources Naming <res_type><projectName><region><Stage/Environment>

### Solution for challenges

1. Random password can generate using terraform provider module
    - create admin username and password can be created in linux using command "" and this can be add in the user_data ec2_provision argument
2. Round Robin fashion ping test
    - Testing can be achieve by following steps
        - Already created ec2_instance data or public or private ip get by using data resource block
        - using this each ips add remote-exec provisioner command in inline method. Then added command ping -c <index of each ec2 ip>+1 then {totalcount} last ec2 instance to first index i=1

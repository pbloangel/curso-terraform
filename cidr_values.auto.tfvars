irlanda_cidr = "10.10.0.0/16"
# public_subnet  = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"         = "dev"
  "owner"       = "parr"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "IAC_Version" = "1.6.0"
  "project"     = "cerberus"
  "region"      = "virginia"
}

sg_ingress_cidr = "79.116.57.181/32"

ec2_specs = {
  "ami"           = "ami-0f3164307ee5d695a"
  "instance_type" = "t2.micro"
}

enable_monitoring = 0

ingress_ports_list = [22, 80, 443]
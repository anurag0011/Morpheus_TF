### Build VPCs
# DR
variable "vpc_dr" {
    type = string
	default = "app1_vpc_iaas_DR"
}

resource "aws_vpc" "dr" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = var.vpc_dr
    }
}

### Gather Info
# AZs
data "aws_availability_zones" "available" {
    state = "available"
}
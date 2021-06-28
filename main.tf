#------------------------------------------------------------------------------
# AWS Virtual Private Network
#------------------------------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  # The CIDR block for the VPC.
  enable_dns_support = true
  # A boolean flag to enable/disable DNS support in the VPC.
  enable_dns_hostnames = true
  # A boolean flag to enable/disable DNS hostnames in the VPC.
  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-vpc"
    },
  )
}

#------------------------------------------------------------------------------
# AWS Internet Gateway
#------------------------------------------------------------------------------
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-internet-gw"
    },
  )
}
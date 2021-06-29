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

#------------------------------------------------------------------------------
# AWS Subnets - Public
#------------------------------------------------------------------------------
# Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(var.availability_zones, count.index)
  cidr_block              = element(var.public_subnets_cidrs_per_availability_zone, count.index)
  map_public_ip_on_launch = true
  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-public-net-${element(var.availability_zones, count.index)}"
    },
  )

# Elastic IPs for NAT
resource "aws_eip" "nat_eip" {
  count = var.single_nat ? 1 : length(var.availability_zones)
  vpc   = true
  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-nat-eip-${element(var.availability_zones, count.index)}"
    },
  )
}
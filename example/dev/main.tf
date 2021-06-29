provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_force_path_style         = true
  access_key                  = ""
  secret_key                  = ""
}

module "aws-base-network" {
  source         = "../../"
  name_prefix    = "dev"
  single_nat     = true
  vpc_cidr_block = "192.168.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets_cidrs_per_availability_zone = [
    "192.168.0.0/19",
    "192.168.32.0/19"
  ]
  private_subnets_cidrs_per_availability_zone = [
    "192.168.128.0/19",
    "192.168.160.0/19"
  ]
}
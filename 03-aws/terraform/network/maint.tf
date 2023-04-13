# terraform init \
#       -backend-config="bucket=dh-terraform-state" \
#       -backend-config="key=nicolas.osorio/network/terraform.tfstate" \
#       -backend-config="region=us-east-1"
# terraform plan -out out.tfplan
# terraform apply "out.tfplan"

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = "dh-infra-ii-vpc"
  cidr            = "10.0.0.0/16"
  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = cidrsubnets("10.0.0.0/17", 4, 4, 4)     # https://developer.hashicorp.com/terraform/language/functions/cidrsubnets
  public_subnets  = cidrsubnets("10.0.128.0/17", 4, 4, 4)   # https://developer.hashicorp.com/terraform/language/functions/cidrsubnets

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  create_igw             = true

  vpc_tags = {
    role = "vpc"
  }

  private_subnet_tags = {
    role = "subnet"
    tier = "private"
  }

  public_subnet_tags = {
    role = "subnet"
    tier = "public"
  }

  tags = local.common_tags
}
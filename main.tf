module "network" {
  source = "./modules/network"

  vpc_name = "cmtr-ouv17nh6-vpc"
  vpc_cidr = "10.10.0.0/16"

  subnet_public_a_name = "cmtr-ouv17nh6-subnet-public-a"
  subnet_public_b_name = "cmtr-ouv17nh6-subnet-public-b"
  subnet_public_c_name = "cmtr-ouv17nh6-subnet-public-c"

  subnet_public_a_cidr = "10.10.1.0/24"
  subnet_public_b_cidr = "10.10.3.0/24"
  subnet_public_c_cidr = "10.10.5.0/24"

  az_a = "eu-west-1a"
  az_b = "eu-west-1b"
  az_c = "eu-west-1c"

  igw_name = "cmtr-ouv17nh6-igw"
  rt_name  = "cmtr-ouv17nh6-rt"
}

module "network_security" {
  source = "./modules/network_security"

  vpc_id           = module.network.vpc_id
  allowed_ip_range = var.allowed_ip_range

  ssh_sg_name          = "cmtr-ouv17nh6-ssh-sg"
  public_http_sg_name  = "cmtr-ouv17nh6-public-http-sg"
  private_http_sg_name = "cmtr-ouv17nh6-private-http-sg"
}

module "application" {
  source = "./modules/application"

  subnet_ids = module.network.public_subnet_ids

  ssh_sg_id          = module.network_security.ssh_sg_id
  public_http_sg_id  = module.network_security.public_http_sg_id
  private_http_sg_id = module.network_security.private_http_sg_id

  vpc_id = module.network.vpc_id
}
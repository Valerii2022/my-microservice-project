

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "lesson5-terraform-state-bucket"
  table_name  = "terraform-locks"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_name           = "lesson-5-vpc"
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-5-ecr"
  scan_on_push = true
}

provider "aws" {
  region = "us-west-2"
}

module "eks" {
  source       = "./modules/eks"
  vpc_id       = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnets
  cluster_name = "django-cluster"
}

provider "kubernetes" {
  alias       = "jenkins"
  config_path = "~/.kube/config"
}

provider "helm" {
  alias = "jenkins"
}

module "jenkins" {
  source        = "./modules/jenkins"
  namespace     = "jenkins"
  chart_version = "4.10.1"

  providers = {
    kubernetes = kubernetes.jenkins
    helm       = helm.jenkins
  }
}

module "argo_cd" {
  source = "./modules/argo_cd"
  cluster_name = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  cluster_ca_cert = module.eks.cluster_ca_cert
}

module "rds" {
  source         = "./modules/rds"
  name           = "my-rds"
  use_aurora     = true
  engine         = "aurora-postgresql"
  engine_version = "15.4"
  instance_class = "db.t3.medium"
  username       = "admin"
  password       = "SuperSecret123"
  db_name        = "mydb"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnets
  multi_az       = false
}

module "monitoring" {
  source = "./modules/monitoring"
}

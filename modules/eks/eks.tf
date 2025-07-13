module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.21.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

  enable_irsa = true
}


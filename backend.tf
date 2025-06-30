

terraform {
  backend "s3" {
    bucket         = "lesson5-terraform-state-bucket"
    key            = "lesson-5/terraform.tfstate"
    region         = "us-west-2"
    use_lockfile = true
    encrypt        = true
  }
}

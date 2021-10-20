###############################################################################
# Terraform main config
###############################################################################
terraform {
  required_version = ">= 0.13.0"
  required_providers {
    aws = ">= 3.57.0"
  }
}

###############################################################################
# Providers
###############################################################################
provider "aws" {
  region              = var.region
  allowed_account_ids = [var.aws_account_id]
}

###############################################################################
# Security Groups - DocumentDB
###############################################################################
module "documentdb_sg" {
  source = "../modules/documentdb_security_group"

  sg_name     = "documentdb-sg"
  vpc_id      = "vpc-02d63e1e9b9c6513c"
  source_cidr = "0.0.0.0/0"
  # source_address = "XXXXXXX"
}

###############################################################################
# DocumentDB Module
###############################################################################
module "documentdb" {
  source = "../modules/documentdb"

  apply_immediately       = true
  backup_retention_period = 7
  cluster_instance_class  = "db.r5.large"
  cluster_instance_count  = 1
  cluster_security_group  = [module.documentdb_sg.security_group_id]
  engine                  = "docdb"
  engine_version          = "4.0.0"
  family                  = "docdb4.0"
  group_subnets           = ["subnet-014dc02934501c0b4", "subnet-06b15981de51ef3ee", "subnet-067beb2686c93ce4c"]
  master_password         = "demo_pass123"
  master_username         = "demo_user"
  name                    = "demo"
  skip_final_snapshot     = true

  create_global           = false
  global_identifier       = "global"
  global_region           = ["us-east-2","us-west-2"]
  region                  = var.region
  account_id              = var.aws_account_id
}

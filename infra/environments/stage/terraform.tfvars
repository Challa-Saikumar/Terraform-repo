aws_region   = "us-east-1"
project_name = "nodejs-three-tier"
environment  = "stage"

vpc_cidr = "10.20.0.0/16"

public_subnet_cidrs = [
  "10.20.1.0/24",
  "10.20.2.0/24"
]

private_subnet_cidrs = [
  "10.20.11.0/24",
  "10.20.12.0/24"
]

database_subnet_cidrs = [
  "10.20.21.0/24",
  "10.20.22.0/24"
]

eks_endpoint_public_access  = true
eks_endpoint_private_access = true

node_instance_types = [
  "t3.small"
]

node_capacity_type = "ON_DEMAND"
node_desired_size  = 2
node_min_size      = 2
node_max_size      = 4

ecr_image_tag_mutability  = "IMMUTABLE"
ecr_image_retention_count = 15

db_name                  = "stageappdb"
db_username              = "dbadmin"
db_instance_class        = "db.t3.micro"
db_allocated_storage     = 20
db_max_allocated_storage = 50
db_multi_az              = false

db_backup_retention_period = 3
db_deletion_protection     = false
db_skip_final_snapshot     = true

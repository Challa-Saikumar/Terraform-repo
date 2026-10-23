variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used in AWS resource names"
  type        = string
  default     = "nodejs-three-tier"
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["dev", "stage"], var.environment)
    error_message = "The environment must be either dev or stage."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) >= 2
    error_message = "At least two public subnet CIDRs are required."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private EKS subnets"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) >= 2
    error_message = "At least two private subnet CIDRs are required."
  }
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for private database subnets"
  type        = list(string)

  validation {
    condition     = length(var.database_subnet_cidrs) >= 2
    error_message = "At least two database subnet CIDRs are required."
  }
}

variable "eks_endpoint_public_access" {
  description = "Whether the EKS Kubernetes API is publicly accessible"
  type        = bool
  default     = true
}

variable "eks_endpoint_private_access" {
  description = "Whether the EKS Kubernetes API is privately accessible"
  type        = bool
  default     = true
}

variable "node_instance_types" {
  description = "EC2 instance types used by the EKS managed node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_capacity_type" {
  description = "Capacity type for the EKS managed nodes"
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_capacity_type)
    error_message = "node_capacity_type must be ON_DEMAND or SPOT."
  }
}

variable "node_desired_size" {
  description = "Desired number of EKS worker nodes"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of EKS worker nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of EKS worker nodes"
  type        = number
  default     = 3
}

variable "ecr_image_tag_mutability" {
  description = "Whether existing ECR image tags can be overwritten"
  type        = string
  default     = "MUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.ecr_image_tag_mutability)
    error_message = "The value must be MUTABLE or IMMUTABLE."
  }
}

variable "ecr_image_retention_count" {
  description = "Number of recent ECR images to retain"
  type        = number
  default     = 10
}

variable "db_name" {
  description = "Initial MySQL database name"
  type        = string
  default     = "appdb"

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9]*$", var.db_name))
    error_message = "db_name must begin with a letter and contain only letters and numbers."
  }
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "dbadmin"
}

variable "db_instance_class" {
  description = "RDS database instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Initial RDS storage in GB"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Maximum autoscaled RDS storage in GB"
  type        = number
  default     = 50
}

variable "db_multi_az" {
  description = "Whether RDS Multi-AZ is enabled"
  type        = bool
  default     = false
}

variable "db_backup_retention_period" {
  description = "Number of days to retain RDS backups"
  type        = number
  default     = 1
}

variable "db_deletion_protection" {
  description = "Whether deletion protection is enabled for RDS"
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Whether to skip the final RDS snapshot during deletion"
  type        = bool
  default     = true
}

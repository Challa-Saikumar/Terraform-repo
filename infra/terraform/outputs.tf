output "aws_region" {
  description = "AWS region used by the infrastructure"
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the project VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private EKS subnets"
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "IDs of private database subnets"
  value       = aws_subnet.database[*].id
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  description = "EKS Kubernetes API endpoint"
  value       = aws_eks_cluster.main.endpoint
  sensitive   = true
}

output "eks_cluster_security_group_id" {
  description = "Security group created for the EKS cluster"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "eks_node_role_arn" {
  description = "IAM role ARN used by EKS worker nodes"
  value       = aws_iam_role.eks_node.arn
}

output "ecr_repository_name" {
  description = "ECR repository name"
  value       = aws_ecr_repository.nodejs_app.name
}

output "ecr_repository_url" {
  description = "ECR repository URL used by the application pipeline"
  value       = aws_ecr_repository.nodejs_app.repository_url
}

output "rds_endpoint" {
  description = "RDS connection endpoint"
  value       = aws_db_instance.main.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS database port"
  value       = aws_db_instance.main.port
}

output "database_secret_arn" {
  description = "ARN of the Secrets Manager database secret"
  value       = aws_secretsmanager_secret.database.arn
}

output "configure_kubectl_command" {
  description = "Command for configuring kubectl"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${aws_eks_cluster.main.name}"
}

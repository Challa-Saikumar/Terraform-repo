resource "aws_security_group" "database" {
  name        = "${local.name_prefix}-database-sg"
  description = "Allow MySQL traffic from the EKS cluster security group"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${local.name_prefix}-database-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "database_from_eks" {
  security_group_id = aws_security_group.database.id

  description                  = "Allow MySQL from EKS worker nodes"
  referenced_security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id

  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "database_outbound" {
  security_group_id = aws_security_group.database.id

  description = "Allow database outbound traffic"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

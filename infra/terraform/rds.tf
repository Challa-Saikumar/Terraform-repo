resource "random_password" "database" {
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}"
}

resource "aws_db_subnet_group" "main" {
  name       = "${local.name_prefix}-db-subnet-group"
  subnet_ids = aws_subnet.database[*].id

  tags = {
    Name = "${local.name_prefix}-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier = "${local.name_prefix}-mysql"

  engine = "mysql"

  instance_class        = var.db_instance_class
  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  password = random_password.database.result
  port     = 3306

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [
    aws_security_group.database.id
  ]

  publicly_accessible = false
  multi_az            = var.db_multi_az

  backup_retention_period = var.db_backup_retention_period
  copy_tags_to_snapshot    = true

  auto_minor_version_upgrade = true
  apply_immediately           = true

  deletion_protection = var.db_deletion_protection
  skip_final_snapshot = var.db_skip_final_snapshot

  tags = {
    Name = "${local.name_prefix}-mysql"
    Tier = "Database"
  }
}

resource "aws_secretsmanager_secret" "database" {
  name = "${local.name_prefix}/database/credentials-v2"

  tags = {
    Name = "${local.name_prefix}-database-credentials-v2"
  }
}

resource "aws_secretsmanager_secret_version" "database" {
  secret_id = aws_secretsmanager_secret.database.id

  secret_string = jsonencode({
    host     = aws_db_instance.main.address
    port     = aws_db_instance.main.port
    database = aws_db_instance.main.db_name
    username = aws_db_instance.main.username
    password = random_password.database.result
  })
}

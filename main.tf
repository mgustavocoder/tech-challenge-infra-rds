provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  }
  
  resource "aws_security_group" "aurora_sg" {
    name        = "tc-aurora-security-group"
    description = "Allow MySQL traffic"
    vpc_id      = var.vpc_id
  
    ingress {
      description = "Allow MySQL inbound"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
    tags = {
      Name = "tc-aurora-security-group"
    }
  }
  
  resource "aws_db_subnet_group" "aurora_subnet_group" {
    name       = "tc-aurora-subnet-group"
    subnet_ids = var.subnet_ids
    tags = {
      Name = "tc-aurora-subnet-group"
    }
  }
  
  resource "aws_rds_cluster" "aurora_cluster" {
    cluster_identifier      = var.cluster_identifier
    engine                  = "aurora-mysql"
    engine_version          = "8.0.mysql_aurora.3.05.2"
    master_username         = var.master_username
    master_password         = var.master_password
    database_name           = "admin"
    skip_final_snapshot     = true
    vpc_security_group_ids  = [aws_security_group.aurora_sg.id]
    db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
    storage_encrypted       = true
    backup_retention_period = 7
    apply_immediately       = true
  
    tags = {
      Name = "tc-aurora-cluster"
    }
  }
  
  # Aurora Cluster Instance
  resource "aws_rds_cluster_instance" "aurora_instance" {
    identifier              = "aurora-cluster-instance-1"
    cluster_identifier      = aws_rds_cluster.aurora_cluster.id
    instance_class          = "db.t3.small"
    engine                  = aws_rds_cluster.aurora_cluster.engine
    engine_version          = aws_rds_cluster.aurora_cluster.engine_version
    publicly_accessible     = true
    apply_immediately       = true
  
    tags = {
      Name = "aurora-cluster-instance"
    }
  }
  
  # Output the Cluster Endpoint
  output "cluster_endpoint" {
    value = aws_rds_cluster.aurora_cluster.endpoint
  }
  
  output "reader_endpoint" {
    value = aws_rds_cluster.aurora_cluster.reader_endpoint
  }
  
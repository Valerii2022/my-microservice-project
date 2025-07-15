output "db_endpoint" {
  value = var.use_aurora ? aws_rds_cluster.this[0].endpoint : aws_db_instance.this[0].endpoint
}

output "db_sg_id" {
  value = aws_security_group.this.id
}

output "db_name" {
  value = var.db_name
}

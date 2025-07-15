resource "aws_rds_cluster" "this" {
  count                 = var.use_aurora ? 1 : 0
  cluster_identifier   = var.name
  engine               = var.engine
  engine_version       = var.engine_version
  master_username      = var.username
  master_password      = var.password
  database_name        = var.db_name
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  skip_final_snapshot  = true
}

resource "aws_rds_cluster_instance" "this" {
  count              = var.use_aurora ? 1 : 0
  identifier         = "${var.name}-instance"
  cluster_identifier = aws_rds_cluster.this[0].id
  instance_class     = var.instance_class
  engine             = var.engine
  engine_version     = var.engine_version
  publicly_accessible = true
}

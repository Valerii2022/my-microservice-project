resource "aws_db_instance" "this" {
  count                     = var.use_aurora ? 0 : 1
  identifier               = var.name
  engine                   = var.engine
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  name                     = var.db_name
  username                 = var.username
  password                 = var.password
  db_subnet_group_name     = aws_db_subnet_group.this.name
  vpc_security_group_ids   = [aws_security_group.this.id]
  parameter_group_name     = aws_db_parameter_group.this.name
  multi_az                 = var.multi_az
  publicly_accessible      = true
  skip_final_snapshot      = true
}

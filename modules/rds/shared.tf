resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.name}-subnet-group"
  }
}

resource "aws_security_group" "this" {
  name        = "${var.name}-rds-sg"
  description = "Allow RDS access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_parameter_group" "this" {
  name        = "${var.name}-param-group"
  family      = var.engine == "mysql" ? "mysql8.0" : "postgres15"
  description = "Parameter group"

  parameter {
    name  = "max_connections"
    value = "100"
  }

  parameter {
    name  = "log_statement"
    value = "all"
  }

  parameter {
    name  = "work_mem"
    value = "65536"
  }
}

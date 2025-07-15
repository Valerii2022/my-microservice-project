variable "name" {
  description = "Ім'я RDS або кластера"
  type        = string
}

variable "use_aurora" {
  description = "Створювати Aurora, якщо true"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Тип БД"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Версія движка"
  type        = string
  default     = "15.4"
}

variable "instance_class" {
  description = "Клас інстансу"
  type        = string
  default     = "db.t3.micro"
}

variable "multi_az" {
  description = "Multi-AZ для звичайної RDS"
  type        = bool
  default     = false
}

variable "username" {
  description = "Користувач БД"
  type        = string
}

variable "password" {
  description = "Пароль БД"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Назва бази даних"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Список приватних сабнетів для БД"
  type        = list(string)
}

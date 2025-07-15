# RDS Terraform Module

Цей модуль дозволяє створювати гнучкі та багаторазові бази даних у AWS:

- Aurora Cluster (PostgreSQL або MySQL)
- Звичайна RDS Instance (PostgreSQL або MySQL)

## Функціональність

Автоматично створює:

- aws_db_subnet_group
- aws_security_group
- aws_db_parameter_group
- А також або aws_db_instance, або aws_rds_cluster з writer instance

Модуль налаштовується за допомогою змінної use_aurora.

## Структура

```
modules/
└── rds/
    ├── aurora.tf
    ├── rds.tf
    ├── shared.tf
    ├── outputs.tf
    └── variables.tf
```

## Приклад використання

```bash
module "rds" {
  source         = "./modules/rds"
  name           = "my-rds"
  use_aurora     = true
  engine         = "aurora-postgresql"
  engine_version = "15.4"
  instance_class = "db.t3.medium"
  username       = "admin"
  password       = "SuperSecret123"
  db_name        = "mydb"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnets
  multi_az       = false }
```

## Як перемкнути тип бази даних

| Параметр       | Значення для RDS   | Значення для Aurora              |
| -------------- | ------------------ | -------------------------------- |
| use_aurora     | false              | true                             |
| engine         | postgres / mysql   | aurora-postgresql / aurora-mysql |
| instance_class | db.t3.micro і вище | db.r6g.large і вище              |

## Опис усіх змінних

| Назва змінної  | Тип          | Опис                              | Обов’язково | За замовчуванням |
| -------------- | ------------ | --------------------------------- | ----------- | ---------------- |
| db_name        | string       | Назва бази даних                  | так         | —                |
| username       | string       | Користувач БД                     | так         | —                |
| password       | string       | Пароль БД                         | так         | —                |
| engine         | string       | Тип БД                            | так         | —                |
| engine_version | string       | Версія движка                     | так         | —                |
| instance_class | string       | Клас інстансу                     | так         | —                |
| subnet_ids     | list(string) | Список приватних сабнетів для БД  | так         | —                |
| vpc_id         | string       | ID VPC                            | так         | —                |
| use_aurora     | bool         | Чи використовувати Aurora Cluster | ні          | false            |
| multi_az       | bool         | Multi-AZ для звичайної RDS        | ні          | false            |
| name           | string       | Ім'я RDS або кластера             | ні          | -                |

## Як перевірити

1. Ініціалізуйте Terraform:

```bash
terraform init
```

2. Перевірте план:

```bash
terraform plan
```

3. Якщо все ОК:

```bash
terraform apply
```

## Примітки

- Модуль підтримує aurora-postgresql, aurora-mysql, postgres, mysql
- Всі ресурси мають префікс із environment, щоб уникнути конфліктів
- Ви можете підключити цей модуль до будь-якого існуючого VPC

# Lesson 5 — Terraform AWS Infrastructure

Цей проєкт створює базову інфраструктуру AWS за допомогою Terraform.

## 📁 Структура проєкту

├── main.tf # Підключення модулів
├── backend.tf # Налаштування бекенду (S3 + DynamoDB)
├── outputs.tf # Загальні outputs з модулів
├── README.md # Документація
├── modules/
│ ├── s3-backend/ # Модуль для S3 і DynamoDB
│ ├── vpc/ # Модуль для VPC і мереж
│ └── ecr/ # Модуль для ECR репозиторію

## 🧱 Модулі

### `s3-backend`
- Створює S3 бакет для зберігання `terraform.tfstate`
- Увімкнено версіювання
- Створює DynamoDB таблицю `terraform-locks` для блокування

### `vpc`
- Створює VPC з CIDR `10.0.0.0/16`
- Три публічні й три приватні підмережі
- Internet Gateway для публічних
- NAT Gateway для приватних
- Маршрутизація через Route Tables

### `ecr`
- Створює ECR репозиторій
- Увімкнене сканування образів на вразливості

---

## ⚙️ Команди для запуску

> ⚠️ Перед запуском переконайтесь, що додані AWS креденшіали

# 1. Ініціалізація Terraform
terraform init

# 2. Перевірка правильності коду
terraform validate

# 3. Попередній перегляд змін
terraform plan

# 4. Застосування інфраструктури
terraform apply

# 5. Знищення інфраструктури
terraform destroy

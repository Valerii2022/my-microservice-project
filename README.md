# Домашнє завдання Lesson 7 — Terraform, Kubernetes (EKS), Docker, Helm, ECR

## Опис проєкту

Проєкт демонструє створення інфраструктури AWS для Django-застосунку за допомогою Terraform, розгортання застосунку в Kubernetes (EKS) через Helm, а також роботу з Amazon ECR для зберігання Docker-образів.

## Структура проєкту

```
lesson-7/
├── main.tf # Головний Terraform файл
├── backend.tf # Налаштування backend для Terraform state (S3 + DynamoDB)
├── outputs.tf # Outputs для Terraform
├── modules/ # Модулі Terraform
│ ├── s3-backend/
│ ├── vpc/
│ ├── ecr/
│ └── eks/
├── charts/
│ └── django-app/ # Helm-чарт для розгортання Django-застосунку
│ ├── Chart.yaml
│ ├── values.yaml
│ └── templates/
│ ├── deployment.yaml
│ ├── service.yaml
│ ├── configmap.yaml
│ └── hpa.yaml
├── django-app/ # Код Django-застосунку
│ ├── core/
│ ├── manage.py
│ ├── Dockerfile
│ ├── requirements.txt
│ └── nginx/
└── README.md
```

## Виконані кроки

1. **Створення кластера Kubernetes (EKS) через Terraform**

- Описано модуль `eks` з конфігурацією кластера у існуючій VPC.

2. **Налаштування ECR для зберігання Docker-образу**

- Модуль `ecr` створює репозиторій ECR.
- Docker-образ Django побудований локально.

3. **Docker-образ**

- Dockerfile розташований у `django-app/Dockerfile`.
- Образ збирається командою:

  ```bash
  docker build -t django-app .
  ```

4. **Helm-чарт**

- Розміщений у charts/django-app.
- Містить deployment.yaml, service.yaml, configmap.yaml, hpa.yaml.
- Значення образу та змінних середовища передаються через values.yaml.

5. **Застосунок використовує ConfigMap для env-перемінних.**

6. **Service типу LoadBalancer надає доступ ззовні.**

7. **HPA масштабує піди при навантаженні > 70%.**

## Інструкції для перевірки

### Перевірка Terraform

  ```bash
  terraform init
  terraform plan
  ```
- Переконайтеся, що plan проходить без помилок.
- Перевірте terraform output на наявність даних про кластер та ECR.

### Перевірка Docker

  ```bash
  cd django-app
  docker build -t django-app .
  docker images | grep django-app
  ```

### Перевірка Helm

  ```bash
  cd charts
  helm lint django-app
  helm template django-app django-app
  ```

## Команди для деплою

  ```bash
  terraform apply

  aws eks --region us-west-2 update-kubeconfig --name <cluster_name>
  kubectl get nodes

  aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <ECR_URL>
  docker tag django-app:latest <ECR_URL>/django-app:latest
  docker push <ECR_URL>/django-app:latest

  helm install django-app ./django-app
  ```













 




















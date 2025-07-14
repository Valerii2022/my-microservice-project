# Домашнє завдання Lesson 8-9 — CI/CD з Terraform + Jenkins + Argo CD + Helm

## Опис проєкту

Цей проєкт реалізує повноцінний CI/CD-процес розгортання Django-застосунку на Kubernetes з використанням таких інструментів:
-  Terraform — для управління інфраструктурою
-  Helm — для деплою застосунку
-  Jenkins — як CI-сервер
-  Argo CD — як CD-система
-  ECR — для зберігання Docker-образів
-  Kaniko — для безпечної збірки контейнерів без root

## Структура проєкту
```
lesson-8-9/
├── main.tf # Головний Terraform файл
├── backend.tf # Налаштування backend для Terraform state (S3 + DynamoDB)
├── outputs.tf # Outputs для Terraform
├── modules/ # Модулі Terraform
│ ├── s3-backend/
│ ├── vpc/
│ ├── ecr/
│ ├── jenkins/
│ ├── agro_cd/
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
├── Jenkinsfile
└── README.md

## Як застосувати Terraform

1. Ініціалізуйте проєкт:

```bash
terraform init
```

2. Перевірте план змін:

```bash
terraform plan
```

3. Запустіть створення інфраструктури:

```bash
terraform apply
```

Буде створено: S3, DynamoDB, VPC, EKS, ECR, Jenkins (через Helm), Argo CD (через Helm)


## Як працює Jenkins pipeline (CI)

Jenkins встановлюється через Helm та автоматично налаштовується за допомогою Terraform.

- Використовується Kubernetes Agent з Kaniko.
- Jenkinsfile автоматизує:
  - Побудову Docker-образу з django-app/
  - Публікацію в Amazon ECR
  - Оновлення image.tag у charts/django-app/values.yaml
  - Пуш змін у гілку main

## Як працює Argo CD (CD)

- Встановлюється через Helm автоматично (Terraform).
- В Argo CD створено Application, яке стежить за Helm chart charts/django-app.
- Кожне оновлення image.tag в репозиторії тригерить деплой в кластер.

### Доступ до Argo CD
- URL: https://<ARGO_CD_LOADBALANCER>
- Логін: admin
- Пароль: отримуємо з output:

```bash
terraform output argo_admin_password
```

## Як перевірити результат

### У Jenkins:
- Відкрити Jenkins через terraform output jenkins_url
- Зайти в pipeline
- Перевірити лог кожного етапу: збірка, пуш, git

### У Argo CD:
- Перейти в UI
- Вибрати application django-app
- Переконатись, що статус Synced ✅ і Healthy ✅

### У кластері:

```bash
kubectl get pods
kubectl get svc
kubectl get hpa
```
### Примітки

- ECR репозиторій створений у модулі ecr/
- Kubernetes кластер створений у eks/
- Jenkins і Argo CD через Helm
- Стейт зберігається в s3-backend/

## Посилання
GitHub: https://github.com/Valerii2022/my-microservice-project/tree/lesson-8-9

## Результат

- Jenkins з Kaniko працює
- Docker-образ збирається та пушиться в ECR
- Helm chart оновлюється з новим тегом
- Argo CD автоматично застосовує зміни
- Django-додаток оновлюється в кластері





 




















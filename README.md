# 🧰 Final DevOps Project — AWS + Terraform + Kubernetes + CI/CD + Monitoring

## 📝 Опис

Цей проєкт демонструє побудову повної інфраструктури в AWS за допомогою **Terraform**, з підтримкою **CI/CD (Jenkins + Argo CD)**, **Docker-контейнеризації**, **моніторингу (Prometheus + Grafana)** та деплоєм **Django застосунку** у **EKS кластер** через **Helm-чарти**.

---

## 🗂 Структура проєкту

```
project-root/
├── main.tf
├── backend.tf
├── outputs.tf
├── terraform.tfvars
├── modules/
│   ├── s3-backend/        # S3 + DynamoDB для Terraform state
│   ├── vpc/               # VPC, Subnets, IGW, NAT, маршрути
│   ├── ecr/               # Docker registry
│   ├── eks/               # Kubernetes кластер
│   ├── rds/               # Aurora або звичайна RDS база
│   ├── jenkins/           # Helm chart для Jenkins (CI)
│   ├── argo_cd/           # Helm chart для Argo CD (CD)
│   └── monitoring/        # Helm chart для Prometheus + Grafana
├── charts/
│   └── django-app/        # Helm-чарт для розгортання Django-застосунку
│     ├── Chart.yaml
│     ├── values.yaml
│     └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── configmap.yaml
│       └── hpa.yaml
├── django-app/             # Код Django-застосунку
│   ├── core/
│   ├── manage.py
│   ├── Dockerfile
│   ├── requirements.txt
│   └── nginx/
├── Jenkinsfile             # CI pipeline
└── README.md
```

---

## 🧱 Основні модулі

### 🔐 `s3-backend/`
- S3 bucket з версіюванням для `terraform.tfstate`
- DynamoDB table для state-locking

### 🌐 `vpc/`
- CIDR: `10.0.0.0/16`
- 3 публічні + 3 приватні сабнети
- Internet Gateway + NAT Gateway
- Route Tables

### 📦 `ecr/`
- Створює приватний Docker Registry
- Увімкнене автоматичне сканування на вразливості

### ☸️ `eks/`
- Kubernetes кластер у приватних сабнетах
- Створює node group, IAM ролі
- Встановлює EBS CSI Driver

### 🛢 `rds/`
- Підтримка Aurora PostgreSQL або звичайної RDS
- Multi-AZ, параметри, subnet group, SG

### 🔧 `jenkins/`
- Helm chart Jenkins із pipeline agent (Kaniko)
- Публікує Docker-образи в ECR
- Оновлює image тег у Helm-чарті

### 🚀 `argo_cd/`
- Встановлення Argo CD через Helm
- Деплой Helm-чарта django-app з Git-репозиторію

### 📊 `monitoring/`
- Встановлення Prometheus + Grafana (kube-prometheus-stack)
- Grafana підключений до Prometheus автоматично
- Порт-форвардинг: `kubectl port-forward svc/grafana 3000:80 -n monitoring`

---

## 🔁 CI/CD Flow

1. **Jenkins**:
   - Збирає Docker-образ з `django-app/`
   - Пушить в Amazon ECR
   - Оновлює Helm-чарт (image.tag)
   - Git push в репозиторій (гілка main)

2. **Argo CD**:
   - Слідкує за репозиторієм
   - Автоматично оновлює застосунок у кластері

---

## 🔎 Моніторинг (Prometheus + Grafana)

- Grafana dashboards доступні локально:
  ```bash
  kubectl port-forward svc/grafana 3000:80 -n monitoring
  ```
- Логін: `admin`, Пароль: `prom-operator`
- Метрики CPU, memory, pods, HPA

---

## ⚙️ Команди для запуску

> Перед запуском: переконайтесь, що `aws configure` виконаний та вказано `terraform.tfvars`

```bash
terraform init
terraform plan
terraform apply
```

### Доступ до EKS:

```bash
aws eks --region <region> update-kubeconfig --name <cluster_name>
kubectl get nodes
```

### Доступ до Jenkins:

```bash
kubectl port-forward svc/jenkins 8080:8080 -n jenkins
```

### Доступ до Argo CD:

```bash
kubectl port-forward svc/argocd-server 8081:443 -n argocd
```

### Доступ до Grafana:

```bash
kubectl port-forward svc/grafana 3000:80 -n monitoring
```

---

## 🧪 Тестування застосунку

```bash
kubectl get svc
```

🔎 Відкрийте IP вашого `django-app` service типу `LoadBalancer` у браузері.

---

## 🧼 Видалення ресурсів

```bash
terraform destroy
```

> ⚠️ Після `destroy` потрібно заново створити `s3-backend` перед наступним `init`

---

## ✅ Результат

- Повна інфраструктура в AWS через Terraform
- Jenkins збирає та публікує Docker-образи
- Argo CD автоматично оновлює Kubernetes-застосунок
- Моніторинг через Prometheus + Grafana
- Django-додаток розгорнутий через Helm

---

## 📎 Посилання

- Репозиторій: [GitHub Final Branch](https://github.com/Valerii2022/my-microservice-project/tree/final_project)

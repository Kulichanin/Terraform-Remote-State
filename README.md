Материалы для вебинара Командная работа с Terraform: настройка Remote State

Запуск окружения для стенда

```bash
docker compose up -d --force-recreate
```

Остановить окружения и удалить volume

```bash
docker compose up -d --force-recreate
```

Работа с postgres

```bash
psql -d terraform_backend -h 127.0.0.1 -U terraform
```

Запуск разного backend

```bash
terraform init -backend-config="backend/s3-yandex.tf" -reconfigure
```

```bash
terraform init -backend-config="backend/pg.tf" -reconfigure
```

```bash
terraform init -backend-config="backend/s3-minio.tf" -reconfigure
```

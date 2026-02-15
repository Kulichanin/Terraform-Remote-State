# Материалы для вебинара Командная работа с Terraform: настройка Remote State

## Запуск окружения для стенда

```bash
docker compose up -d --force-recreate
```

Остановить окружения и удалить volume

```bash
docker compose up -d --force-recreate
```

## Запуск разного backend

```bash
terraform init -backend-config="backend/s3-yandex.tf" -reconfigure
```

```bash
terraform init -backend-config="backend/pg.tf" -reconfigure
```

```bash
terraform init -backend-config="backend/s3-minio.tf" -reconfigure
```

## Работа с Minio

Получить ключи для пользователя admin  

```bash
mc alias set myminio http://127.0.0.1:9000 admin admin123
mc admin accesskey create myminio/
```

В выводе готовый набор ключей

```bash
Access Key: L42QLDUXFE3M7E1XG6M6
Secret Key: ws+mOcoOijrERMn9fpBk7FxHWGEaLhxKjU+P73TF
Expiration: NONE
Name: 
Description: 
```

## Работа с postgres

```bash
psql -d terraform_backend -h 127.0.0.1 -U terraform
```

```sql
SELECT pid, locktype, mode, granted 
FROM pg_locks 
WHERE locktype = 'advisory';
```

```sql
 pid | locktype |     mode      | granted 
-----+----------+---------------+---------
  82 | advisory | ExclusiveLock | t
(1 строка)
```

```sql
SELECT * FROM terraform_remote_state.states;
```

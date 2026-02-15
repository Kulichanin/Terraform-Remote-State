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

### Работа с Яндекс

[Создайте](https://yandex.cloud/ru/docs/iam/operations/sa/create) сервисный аккаунт.

Понадобиться [создать](https://yandex.cloud/ru/docs/storage/operations/buckets/create) уникальный бакет в я.облаке

Для него нужен [Статические ключи доступа, совместимые с AWS API](https://yandex.cloud/ru/docs/iam/concepts/authorization/access-key#supported-services).

Добавьте в переменные окружения идентификатор ключа и секретный ключ, полученные ранее:

```bash
export ACCESS_KEY="<идентификатор_ключа>"
export SECRET_KEY="<секретный_ключ>"
```

Установить модули

```bash
terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
```

### Работа с Minio

Получить ключи для пользователя admin  

```bash
mc alias set myminio http://127.0.0.1:9000 admin admin123
mc admin accesskey create myminio/
```

В выводе готовый набор ключей

```bash
Access Key: <Access Key>
Secret Key: <Secret Key>
Expiration: NONE
Name: 
Description: 
```

### Работа с postgres

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

# Материалы для вебинара Командная работа с Terraform: настройка Remote State

## Запуск окружения для стенда

```bash
docker compose up -d --force-recreate
```

Остановить окружения и удалить volume

```bash
docker compose down -v
```

## Запуск разного backend

### Работа с локальным файлом

Для создания локального terraform.tfstate выполните команды

```bash
terraform init
terraform apply
```

Для того чтобы скрыть output необходимо активировать sensitive

```terraform
output "server_pass" {
  value = random_string.password.id
  sensitive = true
}
```

Для того чтобы просмотреть актуальный state

```bash
terraform show
```

### Работа с Яндекс

[Создайте](https://yandex.cloud/ru/docs/iam/operations/sa/create) сервисный аккаунт.

Понадобиться [создать](https://yandex.cloud/ru/docs/storage/operations/buckets/create) уникальный бакет в я.облаке

Для него нужен [Статические ключи доступа, совместимые с AWS API](https://yandex.cloud/ru/docs/iam/concepts/authorization/access-key#supported-services).

Добавьте в переменные окружения идентификатор ключа и секретный ключ, полученные ранее:

```bash
export ACCESS_KEY="ACCESS_KEY"
export SECRET_KEY="SECRET_KEY"
```

Установить модули

```bash
terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY" -migrate-state
```

### Работа с Minio

Зарегистрировать у себя новый minio

```bash
mc alias set myminio http://127.0.0.1:9000 admin admin123
```

Создать bucket

```bash
mc mb myminio/web-bucket
```

Проверить версонирование

```bash
mc version info myminio/web-bucket
```

Включить версионирование

```bash
mc version enable myminio/web-bucket
```

Просмотр всех версий объекта

```bash
mc ls --versions myminio/web-bucket/terraform.tfstate
```

Скачать нужную версию

```bash
mc cp --vid "UUID" myminio/web-bucket/terraform.tfstate terraform.tfstate.recovery
```

Залить её как новую

```bash
mc cp terraform.tfstate.recovery myminio/web-bucket/terraform.tfstate
```

Удаление конкретной версии

```bash
mc rm --version-id=UUID myminio/web-bucket/terraform.tfstate
```

Получить ключи для пользователя admin  

```bash
mc admin accesskey create myminio/
```

В выводе готовый набор ключей

```bash
Access Key: "ACCESS_KEY"
Secret Key: "SECRET_KEY"
Expiration: NONE
Name: 
Description: 
```

Добавьте в переменные окружения идентификатор ключа и секретный ключ, полученные ранее:

```bash
export ACCESS_KEY="ACCESS_KEY"
export SECRET_KEY="SECRET_KEY"
```

Установить модули

```bash
terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY" -migrate-state
```

### Работа с postgres

Подключение к Бд через psql

```bash
psql -d terraform_backend -h 127.0.0.1 -U terraform
```

Просмотреть файл

```sql
SELECT * FROM terraform_remote_state.states;
```

Увидеть актуальные версии states

```sql
SELECT name, data FROM terraform_remote_state.states;
```

Увидеть блокировку

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

Удалить блокировку (advisory lock)

```sql
SELECT pg_terminate_backend(82)
```

Также доступен всегда вариант через terraform

```bash
terraform force-unlock <LOCK_ID>
```

### Материалы вебинара

[Презентация](https://disk.yandex.ru/i/wLWPvUOE4xV4TQ)

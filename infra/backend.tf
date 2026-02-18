terraform {
  backend "s3" {
    endpoints = {
      s3 = "http://127.0.0.1:9000" # Адрес MinIO
    }
    bucket = "test"                      # Твой бакет
    key    = "network/terraform.tfstate" # Путь к файлу внутри бакета
    region = "local"                     # Для MinIO можно писать любое значение

    skip_credentials_validation = true # Обязательно для MinIO
    skip_metadata_api_check     = true # Обязательно для MinIO
    skip_region_validation      = true # Обязательно для MinIO
    use_path_style              = true # Чтобы путь был http://127.0.0.1:9000/test, а не http://test.127.0.0.1:9000/
    skip_requesting_account_id  = true # Отключить запрос к AWS STS (Security Token Service) или Metadata API, чтобы узнать ID аккаунта AWS


    use_lockfile = true
  }
}

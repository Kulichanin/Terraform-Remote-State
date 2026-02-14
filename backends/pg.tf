terraform {
  backend "pg" {
    conn_str = "postgres://terraform:terraform123@127.0.0.1/terraform_backend?sslmode=disable"
  }
}

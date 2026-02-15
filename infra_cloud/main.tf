resource "random_pet" "server" {
  length = 2
}

resource "random_integer" "port" {
  min = 1000
  max = 9999
}

resource "random_string" "password" {
  length  = 16
  special = true
}

output "server_name" {
  value = "web-${random_pet.server.id}"
}

output "server_pass" {
  value = random_string.password.id
}

output "server_port" {
  value = random_integer.port.result
}

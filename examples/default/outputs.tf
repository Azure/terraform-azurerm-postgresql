output "test_postgresql_server_id" {
  value = module.postgresql.server_id
}

output "test_random_password" {
  value     = random_password.password.result
  sensitive = true
}
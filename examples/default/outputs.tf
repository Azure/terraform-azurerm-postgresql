output "test_postgresql_server_id" {
  value = module.postgresql.server_id
}

output "test_random_password" {
  sensitive = true
  value     = random_password.password.result
}

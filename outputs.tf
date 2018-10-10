output "server_name" {
  description = "The name of the PostgreSQL server"
  value       = "${azurerm_postgresql_server.server.name}"
}

output "server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL server"
  value       = "${azurerm_postgresql_server.server.fqdn}"
}

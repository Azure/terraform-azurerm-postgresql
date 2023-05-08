output "administrator_login" {
  description = "The Administrator login for the PostgreSQL Server"
  value       = var.administrator_login
}

output "administrator_password" {
  description = "The Password associated with the `administrator_login` for the PostgreSQL Server"
  sensitive   = true
  value       = var.administrator_password
}

output "database_ids" {
  description = "The list of all database resource ids"
  value       = [azurerm_postgresql_database.dbs[*].id]
}

output "firewall_rule_ids" {
  description = "The list of all firewall rule resource ids"
  value       = [azurerm_postgresql_firewall_rule.firewall_rules[*].id]
}

output "server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL server"
  value       = azurerm_postgresql_server.server.fqdn
}

output "server_id" {
  description = "The resource id of the PostgreSQL server"
  value       = azurerm_postgresql_server.server.id
}

output "server_name" {
  description = "The name of the PostgreSQL server"
  value       = azurerm_postgresql_server.server.name
}

output "vnet_rule_ids" {
  description = "The list of all vnet rule resource ids"
  value       = [azurerm_postgresql_virtual_network_rule.vnet_rules[*].id]
}

output "server_name" {
  value = module.postgresql.server_name
}

output "server_fqdn" {
  value = module.postgresql.server_fqdn
}

output "administrator_login" {
  value = module.postgresql.administrator_login
}

output "administrator_password" {
  value     = module.postgresql.administrator_password
  sensitive = true
}

output "firewall_rule_ids" {
  value = module.postgresql.firewall_rule_ids
}

output "vnet_rule_ids" {
  value = module.postgresql.vnet_rule_ids
}


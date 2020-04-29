terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = ">=2.0.0"
  features {}
}

resource "azurerm_postgresql_server" "server" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "${var.sku_tier}_${var.sku_family}_${var.sku_capacity}"

  storage_profile {
    storage_mb            = var.storage_mb
    backup_retention_days = var.backup_retention_days
    geo_redundant_backup  = var.geo_redundant_backup
  }

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_password
  version                      = var.server_version
  ssl_enforcement              = var.ssl_enforcement

  tags = var.tags
}

resource "azurerm_postgresql_database" "dbs" {
  count               = length(var.db_names)
  name                = var.db_names[count.index]
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  charset             = var.db_charset
  collation           = var.db_collation
}

resource "azurerm_postgresql_firewall_rule" "firewall_rules" {
  count               = length(var.firewall_rules)
  name                = "${var.firewall_rule_prefix}${lookup(var.firewall_rules[count.index], "name", count.index)}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  start_ip_address    = lookup(var.firewall_rules[count.index], "start_ip")
  end_ip_address      = lookup(var.firewall_rules[count.index], "end_ip")
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules" {
  count               = length(var.vnet_rules)
  name                = "${var.vnet_rule_name_prefix}${lookup(var.vnet_rules[count.index], "name", count.index)}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  subnet_id           = lookup(var.vnet_rules[count.index], "subnet_id")
}

resource "azurerm_postgresql_configuration" "db_configs" {
  count               = length(keys(var.postgresql_configurations))
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name

  name  = element(keys(var.postgresql_configurations), count.index)
  value = element(values(var.postgresql_configurations), count.index)
}

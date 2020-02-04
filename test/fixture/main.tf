provider "random" {
  version = "~> 1.0"
}

resource "random_id" "name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  name     = "test${random_id.name.hex}"
  location = "${var.location}"
}

module "postgresql" {
  source = "../../"

  resource_group_name = "${azurerm_resource_group.test.name}"
  location            = "${azurerm_resource_group.test.location}"

  server_name  = "postgresql${random_id.name.hex}"
  sku_name     = "B_Gen5_2"

  storage_mb            = 5120
  backup_retention_days = 7
  geo_redundant_backup  = "Disabled"

  administrator_login    = "azureuser"
  administrator_password = "Azur3us3r!"

  server_version  = "9.5"
  ssl_enforcement = "Enabled"

  db_names     = "${var.db_names}"
  db_charset   = "UTF8"
  db_collation = "English_United States.1252"

  firewall_rule_prefix = "${var.fw_rule_prefix}"
  firewall_rules       = "${var.fw_rules}"
}

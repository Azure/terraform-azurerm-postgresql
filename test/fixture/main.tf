provider "azurerm" {
  features {}
}

provider "random" {
  version = "~> 2.2"
}

resource "random_id" "name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  name     = format("test%s", random_id.name.hex)
  location = var.location
}

resource "azurerm_virtual_network" "test" {
  name                = format("testVN%s", random_id.name.hex)
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_subnet" "test" {
  name                 = format("testSN%s", random_id.name.hex)
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
}

module "postgresql" {
  source = "../../"

  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location

  server_name = "postgresql${random_id.name.hex}"
  sku_name    = "GP_Gen5_2"

  storage_mb                    = 5120
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  administrator_login           = "azureuser"
  administrator_password        = "Azur3us3r!"
  server_version                = "9.5"
  ssl_enforcement_enabled       = true
  db_names                      = var.db_names
  db_charset                    = "UTF8"
  db_collation                  = "English_United States.1252"
  public_network_access_enabled = true

  firewall_rule_prefix = var.fw_rule_prefix
  firewall_rules       = var.fw_rules

  vnet_rule_name_prefix = var.vnet_rule
  vnet_rules = [
    { name = "subnet1", subnet_id = azurerm_subnet.test.id }
  ]

  depends_on = [azurerm_resource_group.test]
}


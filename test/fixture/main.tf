provider "random" {
  version = "~> 1.0"
}

resource "random_id" "name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  name     = "test${random_id.name.hex}"
  location = "west us 2"
}

module "postgresql" {
  source = "../../"

  resource_group_name = "${azurerm_resource_group.test.name}"
  location            = "${azurerm_resource_group.test.location}"

  server_name  = "postgresql${random_id.name.hex}"
  sku_name     = "GP_Gen5_2"
  sku_capacity = 2
  sku_tier     = "GeneralPurpose"
  sku_family   = "Gen5"

  storage_mb            = 5120
  backup_retention_days = 7
  geo_redundant_backup  = "Disabled"

  administrator_login    = "azureuser"
  administrator_password = "Azur3us3r!"

  version         = "9.5"
  ssl_enforcement = "Enabled"

  db_names     = ["testdb1", "testdb2"]
  db_charset   = "UTF8"
  db_collation = "English_United States.1252"

  firewall_prefix = "firewall-"

  firewall_ranges = [
    {
      name = "test1"

      start_ip = "10.0.0.5"

      end_ip = "10.0.0.8"
    },
    {
      start_ip = "127.0.0.0"

      end_ip = "127.0.1.0"
    },
  ]
}

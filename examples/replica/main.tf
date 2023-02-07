resource "random_id" "rg_name" {
  byte_length = 8
}

resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

resource "azurerm_resource_group" "test" {
  location = var.location
  name     = "testRG-${random_id.rg_name.hex}"
}

module "postgresql" {
  source = "../../"

  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location

  server_name            = "test-pg-primary-${random_id.rg_name.hex}"
  administrator_login    = "login"
  administrator_password = random_password.password.result
}

resource "time_sleep" "sleep" {
  create_duration = "1m"

  depends_on = [module.postgresql]
}

module "postgresql_replica" {
  source = "../../"

  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location

  server_name            = "test-pg-replica-${random_id.rg_name.hex}"
  administrator_login    = "login"
  administrator_password = random_password.password.result

  create_mode               = "Replica"
  creation_source_server_id = module.postgresql.server_id

  depends_on = [time_sleep.sleep]
}
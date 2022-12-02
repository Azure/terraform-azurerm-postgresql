provider "azurerm" {
  features {}
}

resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  location = var.location
  name     = "testRG-${random_id.rg_name.hex}"
}

module "postgresql" {
  source = "Azure/postgresql/azurerm"

  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location

  server_name            = "test-server"
  administrator_login    = "login"
  administrator_password = "password"
}
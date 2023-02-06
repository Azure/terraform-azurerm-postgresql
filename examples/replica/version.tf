terraform {
  required_version = ">= 1.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0, < 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
    time = {
      source = "hashicorp/time"
      version = ">= 0.8.0"
    }
  }
}

provider "azurerm" {
  features {}
}

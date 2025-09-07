terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "6eb6ee21-8952-4718-9243-5a0101ee200e"
}
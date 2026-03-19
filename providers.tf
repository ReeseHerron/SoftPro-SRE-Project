terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Backend Block
  backend "azurerm" {
    resource_group_name  = "rg-softpro-tfstate"
    storage_account_name = "tfstatereese2026"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

terraform {
  required_version = ">= 1.6.0"

backend "azurerm" {
    # see backend.hcl for non-secret settings
    # use_azuread_auth = true  # uncomment to use Azure AD auth (instead of access key)
   }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  use_cli         = true
}

#create resource group
resource "azurerm_resource_group" "main" {
  name     = "rg-test-sindre123"
  location = var.location
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.55.0"
    }
  }
}

provider "azurerm" {
  features {} #This is required for v2 of the provider even if empty or plan will fail
}

variable "KV" {

}
#Data section
data "azurerm_resource_group" "ResGroup" {
  name = "terrafrom-test"
}

data "azurerm_key_vault_secret" "SamplePassword" {
  name         = "SamplePassword"
  key_vault_id = "${var.KV}"
}

#Resource section
resource "azurerm_storage_account" "terraformtest1212" {
  name                     = "terraformteststorage1212"
  resource_group_name      = data.azurerm_resource_group.ResGroup.name
  location                 = data.azurerm_resource_group.ResGroup.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = var.replicationType
}

resource "azurerm_storage_container" "Container1" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.terraformtest1212.name
  container_access_type = "private"
}
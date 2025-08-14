provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

# Key Vault
resource "azurerm_key_vault" "this" {
  name                          = var.keyvault_name
  location                      = var.keyvault_location
  resource_group_name           = var.resource_group_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"
  public_network_access_enabled = var.keyvault_public_access
  soft_delete_retention_days    = var.keyvault_soft_delete_days
  tags                          = var.tags
}

# Storage Account
resource "azurerm_storage_account" "this" {
  name                     = var.storage_name
  resource_group_name      = var.resource_group_name
  location                 = var.storage_location
  account_tier             = "Standard"
  account_replication_type = var.storage_sku
  allow_blob_public_access = var.storage_public_access
  tags                     = var.tags
}

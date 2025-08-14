provider "azurerm" {
  features {}
}

# Resource group for deployment
resource "azurerm_resource_group" "rg" {
  name     = "rg-demo"
  location = "Canada East"
}

# Key Vault in Canada East
module "keyvault_canada_east" {
  source                  = "../../modules/keyvault_storage"
  resource_group_name     = azurerm_resource_group.rg.name
  keyvault_name           = "demo-keyvault"
  keyvault_location       = "Canada East"
  keyvault_public_access  = false
  keyvault_soft_delete_days = 7
  storage_name            = "demolrsstorage"
  storage_location        = "Canada Central"
  storage_sku             = "LRS"
  storage_public_access   = false
  tags                    = { env = "dev" }
}

# Storage Account with RA-GRS and public access enabled in Canada East
module "storage_ragrs_canada_east" {
  source                  = "../../modules/keyvault_storage"
  resource_group_name     = azurerm_resource_group.rg.name
  keyvault_name           = "dummy-kv" # Can use a dummy KV as this module requires one
  keyvault_location       = "Canada East"
  keyvault_public_access  = false
  keyvault_soft_delete_days = 7
  storage_name            = "demoRAGRSstorage"
  storage_location        = "Canada East"
  storage_sku             = "RA-GRS"
  storage_public_access   = true
  tags                    = { env = "dev" }
}

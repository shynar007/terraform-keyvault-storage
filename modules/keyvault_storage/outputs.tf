output "keyvault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.this.id
}

output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.this.id
}

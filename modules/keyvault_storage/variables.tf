variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "keyvault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "keyvault_location" {
  description = "The region for Key Vault"
  type        = string
}

variable "keyvault_public_access" {
  description = "Enable public network access for Key Vault"
  type        = bool
  default     = false
}

variable "keyvault_soft_delete_days" {
  description = "Number of days for soft delete in Key Vault"
  type        = number
  default     = 7
}

variable "storage_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_location" {
  description = "The region for storage account"
  type        = string
}

variable "storage_sku" {
  description = "Replication type for storage account (LRS, RAGRS)"
  type        = string
}

variable "storage_public_access" {
  description = "Allow public blob access on storage account"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}

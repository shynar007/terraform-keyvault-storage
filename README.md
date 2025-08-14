# Terraform: Azure Key Vault + Storage (Module + Example)

Reusable Terraform module that deploys an **Azure Key Vault** and a **Storage Account**.  
The example under `examples/deployment` demonstrates the exact scenarios requested:

- **Key Vault** in **Canada East** with **public network access disabled** and **soft delete = 7 days**.  
- **Storage (LRS)** in **Canada Central** with **public access disabled**.  
- **Storage (RAGRS)** in **Canada East** with **public access enabled**.  
- All resources tagged with `env` (`dev`, `qa`, `stg`, or `prd`).


## Repository Layout

modules/keyvault_storage/ 
├── main.tf
├── variables.tf
└── outputs.tf

examples/deployment/ 
├── main.tf
└── terraform.tfvars 

#Quick Start 

cd examples/deployment
terraform init
terraform plan
terraform apply

#To clean up
terraform destroy

#Example Code
provider "azurerm" { features {} }

resource "azurerm_resource_group" "rg" {
  name     = "rg-demo"
  location = "Canada East"
}

# 1) Key Vault (Canada East) + LRS Storage (Canada Central), public access disabled
module "kv_lrs" {
  source                    = "../../modules/keyvault_storage"
  resource_group_name       = azurerm_resource_group.rg.name

  keyvault_name             = "demo-keyvault"
  keyvault_location         = "Canada East"
  keyvault_public_access    = false
  keyvault_soft_delete_days = 7

  storage_name            = "demolrsstorage"     # must be lowercase and globally unique
  storage_location        = "Canada Central"
  storage_sku             = "LRS"
  storage_public_access   = false

  tags = { env = "dev" }
}

# 2) Key Vault (Canada East) + RAGRS Storage (Canada East), public access enabled
module "kv_ragrs" {
  source                    = "../../modules/keyvault_storage"
  resource_group_name       = azurerm_resource_group.rg.name

  keyvault_name             = "demo-keyvault-2"
  keyvault_location         = "Canada East"
  keyvault_public_access    = false
  keyvault_soft_delete_days = 7

  storage_name            = "demoragrsstorage"  # must be lowercase and globally unique
  storage_location        = "Canada East"
  storage_sku             = "RAGRS"
  storage_public_access   = true

  tags = { env = "dev" }
}

#examples/deployment/terraform.tfvars

tags = { env = "dev" }


Note: This example does not include examples/deployment/outputs.tf. Running terraform output will show nothing by design.
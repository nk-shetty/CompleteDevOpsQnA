// ===================================================
// 1️⃣ Azure Resource Group + Storage Account Example
// ===================================================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_example" {
  name     = "example-rg"
  location = "East US"
}

resource "azurerm_storage_account" "storage_example" {
  name                     = "examplestorageacc"
  resource_group_name      = azurerm_resource_group.rg_example.name
  location                 = azurerm_resource_group.rg_example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

// ===================================================
// 2️⃣ Outputs
// ===================================================
output "resource_group_name" {
  value = azurerm_resource_group.rg_example.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage_example.name
}

// ===================================================
// 3️⃣ Module Usage Example
// ===================================================
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg_example.name
  location            = azurerm_resource_group.rg_example.location
  vnet_name           = "example-vnet"
  subnet_name         = "example-subnet"
  address_space       = ["10.0.0.0/16"]
  subnet_prefix       = "10.0.1.0/24"
}

// ===================================================
// 4️⃣ Terraform Interview Q&A (Basics + Real Scenarios)
// ===================================================

// Q: What is Terraform?
// A: Terraform is an Infrastructure as Code (IaC) tool used to define,
// provision, and manage infrastructure across multiple cloud providers
// using declarative configuration files.

// ---------------------------------------------------

// Q: What is Terraform State?
// A: State is a JSON file that maps Terraform resources to real
// infrastructure. Terraform uses state to know what exists and
// to calculate changes during plan and apply.

// ---------------------------------------------------

// Q: Why is remote backend important?
// A: Remote backends store state centrally, enable locking,
// prevent state corruption, and allow teams to collaborate safely.

// ---------------------------------------------------

// Q: What happens during `terraform init`?
// A:
// 1. Downloads required providers
// 2. Configures backend
// 3. Validates backend access
// 4. Initializes modules
// 5. Prepares working directory

// ---------------------------------------------------

// Q: What is drift in Terraform?
// A: Drift occurs when infrastructure is changed outside Terraform
// (Azure Portal, CLI, scripts), causing state to differ from reality.

// ---------------------------------------------------
// Q: How do you detect drift?

// Answer 1 (Most common):
// - Run `terraform plan`
// - Terraform refreshes state and shows differences

// Answer 2 (State-only sync):
// - Run `terraform apply -refresh-only`
// - Updates state without changing infrastructure

// ---------------------------------------------------

// Q: How do you handle drift?

// Option 1: Accept the manual change
// - Run `terraform apply -refresh-only`
// - State is updated to reflect real infra

// Option 2: Enforce Terraform configuration
// - Update `.tf` files with desired values
// - Run `terraform apply` to revert manual changes

// ---------------------------------------------------

// Q: What is terraform refresh?
// A: Refresh updates the state file to match real infrastructure.
// It does NOT change resources and is now built into plan/apply.

// ---------------------------------------------------

// Q: Difference between plan and apply?
// A:
// - plan: shows what will change
// - apply: executes those changes and updates state

// ---------------------------------------------------

// Q: What are data sources?
// A: Data sources fetch information about existing resources
// without managing them (read-only).

// ---------------------------------------------------

// Q: How does Terraform manage dependencies?
// A: Terraform builds a dependency graph automatically based
// on resource references (implicit dependencies).

// ---------------------------------------------------

// Q: count vs for_each?
// A:
// count: numeric index-based creation
// for_each: map/set-based creation with stable resource keys

// ---------------------------------------------------

// Q: How do you manage multiple environments?
// A:
// - Workspaces (dev, stage, prod)
// - OR separate backend/state per environment (preferred for prod)

// ---------------------------------------------------

// Q: How do you migrate an existing Azure resource into Terraform?

// Method 1: Classic terraform import (state only)
// 1. Write resource block manually
// 2. Run `terraform import <resource> <azure-id>`
// 3. Fix drift until plan shows no changes

// Method 2: Import block (Terraform 1.5+)
// 1. Define import block in .tf file
// 2. Run `terraform plan -generate-config-out=generated.tf`
// 3. Terraform generates resource configuration automatically

// Example Import Block:
import {
  to = azurerm_resource_group.imported_rg
  id = "/subscriptions/xxxx/resourceGroups/existing-rg"
}

// ---------------------------------------------------

// Q: Does terraform import create resources?
// A: No. It only updates the Terraform state file.

// ---------------------------------------------------

// Q: What is a provider?
// A: A provider is a plugin that allows Terraform to interact
// with APIs (Azure, AWS, GCP, Vault, etc.).

// ---------------------------------------------------

// Q: How does Terraform authenticate to Azure?
// A:
// 1. Azure CLI (az login)
// 2. Service Principal
// 3. Managed Identity (recommended in Azure)

// ---------------------------------------------------

// Q: What is locking in Terraform?
// A: Locking prevents multiple users from modifying
// the same state file at the same time.

// ---------------------------------------------------

// Q: Can Terraform run automatically on schedule?
// A: Yes, using CI/CD pipelines or cron jobs
// (cron usually for drift detection or refresh-only).

// ===================================================
// 5️⃣ Terraform Workflow Summary
// ===================================================
// terraform init
// terraform validate
// terraform plan
// terraform apply
// terraform apply -refresh-only   (state sync)
// terraform destroy

// ===================================================
// 6️⃣ Key Takeaways (Interview Closing Points)
// ===================================================
// - Terraform is declarative, not imperative
// - State is the source of truth
// - Drift is common and must be managed
// - Remote backend + locking is mandatory in teams
// - Import is used to adopt existing infrastructure
// - CI/CD is preferred over manual execution

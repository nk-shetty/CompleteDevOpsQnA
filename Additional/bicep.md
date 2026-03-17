## BASIC QUESTIONS

### 1. What is Bicep?
Bicep is a domain-specific language (DSL) for defining Azure infrastructure declaratively.

### 2. Why use Bicep over ARM templates?
- Cleaner syntax
- Easier readability
- Modular support
- Same underlying ARM engine

### 3. How do you deploy Bicep?
az deployment group create --resource-group <rg> --template-file main.bicep

---

## INTERMEDIATE QUESTIONS

### 4. What are parameters?
param location string = 'eastus'
param env string

### 5. What are variables?
var prefix = 'app-${env}'

### 6. Difference between param and var?
- param → external input
- var → internal usage

### 7. What are decorators?
@minLength(3)
@maxLength(24)
@allowed([
  'dev'
  'test'
  'prod'
])
@secure()

### 8. What is a resource?
resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'mystorage123'
  location: location
}

### 9. What are modules?
Reusable Bicep files.

module storageModule './modules/storage.bicep' = {
  name: 'deployStorage'
  params: {
    storageName: 'mystorage123'
  }
}

### 10. What are outputs?
output storageName string = storage.name

---

## ADVANCED QUESTIONS

### 11. How do you handle environment-specific deployments?
- Parameter files
- Pipeline inputs

### 12. What is idempotency?
Same deployment multiple times = same result.

### 13. How are dependencies handled?
Automatically or via dependsOn.

### 14. How do you manage secrets?
@secure()
param password string

Pass from pipeline or use Key Vault.

### 15. How does Bicep integrate with CI/CD?
Used with Azure CLI in pipelines.

---

## EXPERT LEVEL QUESTIONS

### 16. How do you design Bicep for large systems?
- Modular architecture
- Separate networking, compute, storage
- Reusable modules

### 17. How do you manage 300+ deployments?
- Central modules
- Parameterization
- Reusable pipelines

### 18. How do you ensure secure deployments?
- Use Key Vault
- Avoid hardcoding
- Use OIDC authentication

### 19. How do you version Bicep modules?
- Store in Git
- Use tags/branches

### 20. How do you validate Bicep before deployment?
az deployment group validate

---

## FULL SAMPLE BICEP

param location string = 'eastus'

@allowed([
  'dev'
  'test'
  'prod'
])
param environment string

@minLength(3)
@maxLength(24)
param storageName string

@secure()
param adminPassword string

var prefix = 'app-${environment}'

resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

module storageModule './modules/storage.bicep' = {
  name: 'deployStorageModule'
  params: {
    storageName: storageName
    location: location
  }
}

output storageName string = storage.name

---

## FINAL SUMMARY

- Bicep = declarative IaC for Azure
- Use params for flexibility
- Use decorators for validation
- Use modules for reuse
- Never hardcode secrets
- Integrate with pipelines using Azure CLI

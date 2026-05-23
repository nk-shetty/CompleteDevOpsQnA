# Azure Storage Account

## 1. What is an Azure Storage Account?

Azure Storage Account is a cloud-based storage solution that provides scalable, secure, and durable storage for data such as blobs, files, queues, and tables. In DevOps, it is commonly used for storing application artifacts, logs, backups, and Terraform state files.

---

## 2. What are the different types of storage services in Azure?

Azure provides four main storage types:
- Blob Storage – for unstructured data (images, logs, backups)
- File Storage – for shared file systems (SMB/NFS)
- Queue Storage – for messaging between services
- Table Storage – for NoSQL structured data

In DevOps, Blob Storage is most widely used.

---

## 3. What are LRS, ZRS, and GRS?

- **LRS (Locally Redundant Storage):** 3 copies in a single data center  
- **ZRS (Zone Redundant Storage):** Copies across multiple availability zones  
- **GRS (Geo Redundant Storage):** Replicates data to a secondary region  

Choice depends on availability, durability, and cost.

---

## 4. What are Blob Storage tiers?

Azure Blob Storage has three tiers:
- Hot – frequently accessed data
- Cool – infrequently accessed data
- Archive – rarely accessed data (lowest cost, high retrieval time)

Lifecycle policies are used to move data between tiers automatically.

---

## 5. What is a SAS token?

A SAS (Shared Access Signature) token provides temporary and limited access to storage resources. It defines permissions, expiry time, and allowed operations without exposing account keys.

---

## 6. How do you secure a Storage Account?

Security can be implemented using:
- Azure RBAC for access control
- Managed Identity (preferred over keys)
- Private Endpoints to restrict network access
- Storage firewalls and IP restrictions
- Encryption using Microsoft-managed or customer-managed keys (Key Vault)

---

## 7. What is the difference between Managed Identity and SAS?

- Managed Identity: Used for secure communication between Azure services without credentials  
- SAS Token: Used to provide temporary external access  

In DevOps pipelines, Managed Identity is preferred for better security.

---

## 8. How do you use Storage Accounts in CI/CD pipelines?

Storage accounts are used to:
- Store build artifacts
- Store logs and reports
- Manage Terraform state files
- Host static website content

Example: Upload build artifacts to Blob Storage in Azure DevOps or GitHub Actions.

---

## 9. What is lifecycle management in Azure Storage?

Lifecycle management allows automatic transition or deletion of blobs based on rules. For example:
- Move logs from Hot to Cool after 30 days
- Move to Archive after 90 days

This helps in cost optimization.

---

## 10. How do you optimize cost in Azure Storage?

Cost optimization strategies include:
- Using lifecycle policies
- Choosing appropriate redundancy (LRS vs GRS)
- Compressing large files
- Deleting unused data
- Monitoring usage via Azure Cost Management

---

## 11. What is soft delete in Azure Storage?

Soft delete allows recovery of deleted blobs or containers within a defined retention period. It protects against accidental deletions.

---

## 12. How do you restrict public access to storage?

- Disable public access at storage account level
- Use private endpoints for secure access
- Configure firewall rules to allow only trusted IPs

---

## 13. What is Azure Data Lake Storage Gen2?

Azure Data Lake Storage Gen2 is built on Blob Storage and provides hierarchical namespace support. It is optimized for big data analytics and integrates with tools like Azure Databricks and Synapse.

---

## 14. What are storage account access keys? Why avoid them?

Access keys provide full control over the storage account, making them risky if exposed. Best practice is to use Azure AD authentication or Managed Identity instead.

---

## 15. How do you monitor Storage Accounts?

Monitoring can be done using:
- Azure Monitor metrics (latency, throughput)
- Diagnostic logs
- Log Analytics workspace
- Alerts for failures or performance issues

---

## 16. How do you implement Disaster Recovery?

- Use GRS or GZRS replication
- Enable blob versioning and soft delete
- Perform failover testing
- Maintain backup strategies

---

## 17. How do you troubleshoot performance issues?

Steps include:
- Check Azure Monitor metrics (latency, throttling)
- Verify correct storage tier usage
- Analyze request patterns
- Use CDN for improving performance

---

## 18. Real-time DevOps Experience Answer

"In my projects, I have used Azure Storage Accounts mainly for storing build artifacts, logs, and Terraform state files. I have implemented secure access using Managed Identities and private endpoints, optimized cost with lifecycle policies, and ensured high availability using ZRS or GRS depending on the application criticality."

---

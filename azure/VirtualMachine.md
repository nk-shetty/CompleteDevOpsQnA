# Azure Virtual Machine

## 1. What is a Virtual Machine? When should you use Virtual Machines in Azure?

Virtual Machines are part of Azure Infrastructure as a Service (IaaS) offering. It provides on-demand computing infrastructure over the internet where Microsoft manages the physical hardware, and we manage the operating system, applications, networking, and configurations.

Azure Virtual Machines provide full control over the computing environment. We can install any software, configure custom settings, and run almost any type of application.

Typically, Virtual Machines are used when we need more control compared to Platform as a Service offerings like Azure App Service. They are suitable for lift-and-shift migrations, legacy applications, custom software installations, domain controllers, Dev/Test environments, and applications requiring OS-level access.

---

## 2. Which type of Virtual Machines did you create?

Azure provides multiple VM series based on workload requirements.

I have worked mostly with:

- D-Series for general-purpose workloads
- E-Series for memory-intensive applications
- F-Series for compute-optimized workloads
- B-Series for low-cost burstable workloads
- DSv2 and Dsv5 series for production environments
- Standard_NC and ND series for GPU-based workloads in some AI/ML use cases

The VM selection depends on CPU, memory, disk throughput, and workload requirements.

---

## 3. What are the various components of Virtual Machines?

A Virtual Machine in Azure is associated with multiple resources.

The main components are:

- Virtual Network (VNet)
- Subnet
- Network Interface Card (NIC)
- IP Address
- Network Security Group (NSG)
- Managed Disks
- Availability Set or Availability Zone
- Load Balancer (optional)

The Virtual Machine is directly attached to the NIC, and the NIC is associated with NSG and IP configurations.

---

## 4. What is a Disk?

A disk in Azure is similar to a physical hard disk in an on-premises server. It is used to store operating systems, applications, and data.

While creating a disk, we mainly define:

- Disk Size
- Disk Type
- Performance Tier

Azure provides managed disks which simplify storage management.

---

## 5. Is it possible to expand the size of OS Disk?

Yes, it is possible to expand the OS disk size.

Traditionally, the VM had to be deallocated before resizing the OS disk. However, Azure introduced the "Resize without downtime" feature which allows expanding supported disks without stopping the VM.

After resizing the disk in Azure, the partition inside the OS must also be extended.

---

## 6. What are managed Disk Types?

Azure provides four major managed disk types:

- Ultra Disks
- Premium SSD
- Standard SSD
- Standard HDD

Ultra Disks provide very high IOPS and throughput for critical applications.

Premium SSDs are used for production workloads requiring low latency.

Standard SSDs are cost-effective for web servers and low I/O applications.

Standard HDDs are suitable for backup or infrequently accessed workloads.

---

## 7. What is the maximum size of OS Disk in a Virtual Machine?

The maximum supported size for an OS disk in Azure Virtual Machines is 4,095 GB.

---

## 8. What is the difference between Managed Disks and Unmanaged Disks?

In Managed Disks, Azure automatically manages the storage accounts, scalability, availability, and performance.

In Unmanaged Disks, we had to manually create and manage storage accounts where VHD files were stored.

Managed disks are preferred because they simplify administration, provide better reliability, support availability zones, and reduce management overhead.

---

## 9. What is an Availability Set?

An Availability Set is a logical grouping of Virtual Machines that improves application availability and redundancy.

Azure distributes VMs across:

- Fault Domains
- Update Domains

Fault Domains protect against hardware failures like rack, power, or network switch failures.

Update Domains protect against planned maintenance where Azure reboots only one update domain at a time.

Using Availability Sets helps achieve the Azure SLA of 99.95%.

---

## 10. Is it possible to add a Virtual Machine to an Availability Set after the Virtual Machine is created?

No, it is not possible to directly add an existing VM into an Availability Set after creation.

To achieve this, we usually recreate the VM and place it into the Availability Set during deployment.

---

## 11. What is Network Security Group?

A Network Security Group is used to filter network traffic to and from Azure resources.

NSG contains security rules that allow or deny inbound and outbound traffic based on source, destination, port, and protocol.

NSGs can be associated with:

- Subnets
- Network Interface Cards

---

## 12. How do you create Network Security Group rules?

While creating NSG rules, we define:

- Rule Name
- Priority
- Source
- Destination
- Protocol
- Port Range
- Action (Allow or Deny)

Azure processes rules based on priority, where lower numbers get evaluated first.

---

## 13. How do you block accessing the Internet from within the Virtual Machine?

We can block internet access by creating outbound NSG rules.

Usually, we create a Deny rule using the "Internet" service tag as the destination in outbound rules. This blocks outgoing internet connectivity from the VM.

We can also use Azure Firewall or User Defined Routes for advanced outbound traffic control.

---

# Experienced Level Azure VM Interview Questions

## 14. What is the difference between Availability Set and Availability Zone?

Availability Sets protect against failures within a single datacenter using Fault Domains and Update Domains.

Availability Zones protect applications from complete datacenter failures by placing VMs across physically separate datacenters within the same Azure region.

Availability Zones provide higher availability SLA compared to Availability Sets.

---

## 15. What is Azure VM Scale Set?

Azure VM Scale Set allows us to deploy and manage a group of identical Virtual Machines.

It supports automatic scaling based on metrics like CPU, memory, or queue length.

VMSS is commonly used for high availability applications, microservices, and large-scale workloads.

---

## 16. How do you secure Azure Virtual Machines?

I secure Azure VMs using multiple layers such as:

- NSG rules
- Azure Bastion
- Just-In-Time VM Access
- Azure Defender
- Disk Encryption
- Managed Identity
- Key Vault
- Private IP usage
- Disabling password authentication
- Using SSH keys

I also avoid exposing RDP or SSH ports directly to the internet.

---

## 17. What is Azure Bastion?

Azure Bastion is a managed service that provides secure RDP and SSH connectivity to Azure VMs through the Azure Portal without exposing public IP addresses.

It improves security by eliminating direct internet exposure.

---

## 18. What is Just-In-Time VM Access?

Just-In-Time VM Access is an Azure Security Center feature that reduces exposure to attacks by opening management ports like RDP or SSH only for a limited time when access is requested.

---

## 19. What is Accelerated Networking in Azure VM?

Accelerated Networking improves VM networking performance by reducing latency, jitter, and CPU utilization.

It uses SR-IOV technology to bypass the host and directly connect traffic to the VM.

---

## 20. What is Azure Dedicated Host?

Azure Dedicated Host provides a physical server dedicated to a single organization.

It is mainly used for compliance, licensing, and isolation requirements.

---

## 21. What is the difference between Ephemeral OS Disk and Managed OS Disk?

Ephemeral OS Disk stores the OS disk on the local VM storage instead of Azure Storage.

It provides faster boot and reimage times but data is lost if the VM is redeployed.

Managed OS Disks are persistent and survive VM reboots and redeployments.

---

## 22. What are Azure Spot Virtual Machines?

Azure Spot VMs allow us to use unused Azure capacity at significantly reduced pricing.

They are suitable for non-critical and interruptible workloads like batch jobs, testing, and CI/CD agents.

Azure can evict Spot VMs when capacity is needed.

---

## 23. How do you monitor Azure Virtual Machines?

I use:

- Azure Monitor
- Log Analytics Workspace
- VM Insights
- Azure Alerts
- Application Insights

These services help monitor CPU, memory, disk usage, network traffic, and application performance.

---

## 24. How do you perform patch management in Azure VMs?

Patch management can be done using:

- Azure Update Management Center
- Automatic VM Guest Patching
- Azure Automation Account

This helps automate OS patching and maintain compliance.

---

## 25. What is Azure Disk Encryption?

Azure Disk Encryption encrypts both OS and data disks using BitLocker for Windows and DM-Crypt for Linux.

Encryption keys are usually stored securely in Azure Key Vault.

---

## 26. What is the difference between Azure Backup and Azure Site Recovery?

Azure Backup is used for backup and restore purposes.

Azure Site Recovery is used for disaster recovery and business continuity by replicating VMs to another region.

---

## 27. How do you resize an Azure Virtual Machine?

VM resizing can be done from:

- Azure Portal
- Azure CLI
- PowerShell
- ARM/Bicep/Terraform templates

Sometimes the VM must be deallocated before resizing depending on the VM family and hardware availability.

---

## 28. What happens when you stop a Virtual Machine from inside the OS?

If the VM is stopped from inside the operating system, Azure still allocates compute resources and billing continues.

To stop billing, the VM must be stopped and deallocated from Azure Portal, CLI, or PowerShell.

---

## 29. What is Azure Hybrid Benefit?

Azure Hybrid Benefit allows organizations to use existing on-premises Windows Server or SQL Server licenses with Software Assurance in Azure.

This reduces Azure VM licensing costs significantly.

---

## 30. What are Proximity Placement Groups?

Proximity Placement Groups help place Azure VMs physically close to each other within the datacenter to achieve low network latency.

They are useful for latency-sensitive applications.

---

## 31. What is Boot Diagnostics in Azure VM?

Boot Diagnostics helps troubleshoot VM boot failures by capturing serial console logs and screenshots during startup.

It is useful when the VM becomes inaccessible.

---

## 32. How do you recover an inaccessible Azure VM?

I usually troubleshoot using:

- Boot Diagnostics
- Serial Console
- Reset Password feature
- Redeploy VM
- Restore from Backup
- Detach and repair OS disk method

The approach depends on the type of failure.

---

## 33. What are extensions in Azure Virtual Machines?

VM Extensions are small applications that provide post-deployment configuration and automation.

Examples include:

- Custom Script Extension
- DSC Extension
- Azure Monitor Agent
- Antimalware Extension

---

## 34. What is the difference between Azure VM Agent and Extensions?

Azure VM Agent is a lightweight process installed inside the VM that manages interaction between Azure and the VM.

Extensions run through the VM Agent to perform specific configuration tasks.

---

## 35. How do you automate Azure VM deployments?

I automate VM deployments using:

- ARM Templates
- Bicep
- Terraform
- Azure DevOps Pipelines
- GitHub Actions
- PowerShell
- Azure CLI

Infrastructure as Code ensures consistency and repeatability.

---

## 36. What is the difference between Azure Image and Snapshot?

An Image is used as a reusable template for creating multiple VMs.

A Snapshot is a point-in-time backup copy of a managed disk.

---

## 37. What are Reserved Instances in Azure?

Reserved Instances allow organizations to reserve Azure VM capacity for 1-year or 3-year terms at discounted pricing.

They are useful for long-running predictable workloads.

---

## 38. How do you reduce Azure VM costs?

I reduce Azure VM costs using:

- Auto-shutdown
- Reserved Instances
- Spot VMs
- Rightsizing VMs
- Scaling policies
- Using B-Series VMs for low workloads
- Monitoring underutilized resources

---

## 39. What is VM Redeploy in Azure?

Redeploy moves the VM to a new physical host within Azure while retaining configuration and disks.

It is mainly used to fix host-level issues.

---

## 40. Explain the Azure VM provisioning process.

When a VM is created, Azure allocates compute resources, attaches storage, configures networking, installs the OS image, and starts the VM Agent.

The provisioning process can be automated using templates and pipelines.

---

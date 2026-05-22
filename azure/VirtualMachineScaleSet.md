# Azure VMSS (Virtual Machine Scale Set)

## 1. What is Azure VMSS?

Azure VMSS is a service used to deploy and manage a group of identical VMs with autoscaling and high availability. We mainly use it for stateless applications like web servers and APIs where traffic fluctuates dynamically.

---

## 2. Why do we use VMSS?

VMSS helps automatically scale infrastructure based on load and reduces manual operational effort. In production, it is commonly used behind Load Balancer or Application Gateway for scalable applications.

---

## 3. Difference between Availability Set and VMSS?

Availability Set provides high availability for fixed VMs, whereas VMSS provides both high availability and autoscaling. VMSS is preferred for dynamic workloads that require automated scaling.

---

## 4. What is Uniform orchestration mode?

Uniform mode treats all VMs as identical instances using the same image, size, and configuration. It is mainly used for stateless workloads like frontend or API servers.

---

## 5. What is Flexible orchestration mode?

Flexible mode allows mixed VM sizes and more VM-level customization. It is useful for specialized or stateful workloads where instances may differ.

---

## 6. If we configure one VM in Uniform VMSS, will others update automatically?

No. Changes made manually inside one VM are not automatically replicated to other instances. Consistency is maintained using Golden Images, extensions, or automation tools.

---

## 7. What are the limitations of Uniform VMSS?

Uniform mode requires all VMs to remain identical and is not ideal for stateful applications. It also provides less VM-level customization compared to Flexible mode.

---

## 8. How does autoscaling work in VMSS?

Autoscaling works using Azure Monitor metrics and scaling rules. If a condition like CPU > 70% remains true for a configured duration, VMSS automatically adds new instances.

---

## 9. Does VMSS scale immediately after threshold breach?

No. Azure first checks whether the threshold remains breached for the configured evaluation period. After scaling, cooldown time prevents repeated rapid scaling actions.

---

## 10. What is cooldown in VMSS autoscaling?

Cooldown is a waiting period after a scaling action. It prevents unnecessary repeated scale-in or scale-out operations caused by temporary metric fluctuations.

---

## 11. What are Health Probes in VMSS?

Health probes monitor application or VM health through Load Balancer or Application Gateway. Unhealthy instances stop receiving traffic and can be automatically replaced.

---

## 12. What is a Golden Image?

A Golden Image is a preconfigured VM image containing OS patches, monitoring agents, security configurations, and required software. It helps maintain consistency across VMSS instances.

---

## 13. How do you create a Golden Image?

We create a base VM, install all required tools and security configurations, validate the setup, generalize the VM, and capture it as an image or Shared Image Gallery version.

---

## 14. Why are Golden Images preferred in production?

Golden Images reduce provisioning time and avoid configuration drift. They ensure all VMSS instances are deployed consistently using immutable infrastructure practices.

---

## 15. What are VMSS extensions?

Extensions are used for post-deployment configuration and automation. Common examples include Custom Script Extension, Azure Monitor Agent, and Key Vault Extension.

---

## 16. What is the use of Custom Script Extension?

Custom Script Extension is used to execute scripts or install software after VM deployment. It is commonly used for bootstrapping applications or runtime configuration.

---

## 17. How do rolling upgrades work in VMSS?

Rolling upgrades update VM instances in batches instead of updating all instances together. Health probes validate each batch before proceeding to avoid downtime.

---

## 18. What is overprovisioning in VMSS?

Overprovisioning means Azure temporarily creates extra VMs during deployment to improve provisioning success rates. Unused extra instances are automatically removed afterward.

---

## 19. What is Azure Spot VM?

Azure Spot VM is a low-cost VM that uses unused Azure capacity. It is suitable for interruptible workloads because Azure can evict the VM anytime.

---

## 20. Where are Spot VMs commonly used?

Spot VMs are commonly used for CI/CD agents, batch processing, testing environments, and non-critical scalable workloads. They help significantly reduce infrastructure costs.

---

## 21. What happens if a Spot VM gets evicted?

When a Spot VM is evicted, Azure either stops/deallocates or deletes the VM depending on the eviction policy. Applications should be designed to handle interruptions gracefully.

---

## 22. What is quota in Azure VMSS?

Quota is the maximum resource limit assigned to a subscription or region. VMSS scaling can fail if vCPU or VM family quotas are exhausted.

---

## 23. How do you check Azure VM quotas?

Quotas can be checked from Azure Portal under Usage + Quotas or using Azure CLI commands. Monitoring quotas is important before enabling large-scale autoscaling.

---

## 24. Why does VMSS scaling sometimes fail?

Scaling may fail due to quota exhaustion, unavailable VM SKUs, failed health probes, or extension errors. Azure Activity Logs and Monitor metrics help troubleshoot these issues.

---

## 25. How do you deploy applications in VMSS?

Applications are usually deployed using Golden Images, CI/CD pipelines, or VMSS extensions. Immutable image-based deployments are preferred in enterprise environments.

---

## 26. How does VMSS integrate with CI/CD?

CI/CD pipelines build application artifacts, create updated VM images, and update VMSS using rolling deployments. Tools commonly used include Azure DevOps, Jenkins, and Terraform.

---

## 27. How do you secure VMSS?

VMSS security is implemented using Managed Identity, NSGs, private networking, Key Vault, disk encryption, and centralized monitoring. Production VMSS instances usually avoid public IP exposure.

---

## 28. Difference between VMSS and Kubernetes?

VMSS manages virtual machines, while Kubernetes manages containers. In Azure, AKS worker nodes internally run on VMSS infrastructure.

---

## 29. Can VMSS be used for stateful applications?

Technically yes, especially using Flexible orchestration mode, but VMSS is primarily recommended for stateless workloads. Stateful applications usually require additional storage and identity management.

---

## 30. What is the real-world architecture of VMSS in production?

A common production setup includes Application Gateway or Load Balancer in front of VMSS instances with autoscaling, health probes, centralized logging, and CI/CD-based image deployments.

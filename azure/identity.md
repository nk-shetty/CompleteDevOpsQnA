# Azure RBAC

## 1. Explain Azure RBAC and how it differs from classic subscription-level access

**Answer:**  
Azure RBAC is a **fine-grained access control system** that lets you assign permissions to users, groups, service principals, or managed identities at **different scopes**: management group, subscription, resource group, or individual resources. Unlike the older **classic subscription-level access**, which was all-or-nothing and tied to subscription administrator roles, RBAC is **policy-driven and supports least privilege access**.  

*Example:* Developers needed read/write access to a specific storage account. Instead of granting Contributor at the subscription level, I assigned **Storage Blob Data Contributor** at the storage account scope, enforcing least privilege while keeping other resources secure.

---

## 2. How do you troubleshoot permission issues in Azure RBAC?

**Answer:**  
Steps I follow when users report “access denied”:  

1. **Check effective permissions** using **Access Control (IAM) -> Check Access**.  
2. **Audit activity logs** to track who attempted which operation.  
3. **Validate group membership** in Azure AD for role inheritance.  
4. **Check custom roles** to ensure the required actions are included.  

*Example:* A service principal failed to deploy resources because Contributor role didn’t include Key Vault operations. I created a **custom role** combining Contributor + Key Vault access.

---

## 3. What are the scopes in Azure RBAC, and when would you use each?

**Answer:**  
RBAC scopes are hierarchical: **Management Group > Subscription > Resource Group > Resource**.  

- **Management Group:** Apply roles/policies across multiple subscriptions.  
- **Subscription:** Full access for teams within one subscription.  
- **Resource Group:** Limit access to a subset of resources.  
- **Resource:** Restrict access to specific sensitive resources.  

*Example:* Granted a DevOps engineer **Storage Blob Data Contributor** only on a production storage account to enforce least privilege.

---

## 4. Explain the difference between built-in, custom, and classic roles

**Answer:**  
- **Built-in roles:** Predefined roles like Owner, Contributor, Reader. Covers most scenarios.  
- **Custom roles:** When built-in roles are too broad or restrictive; can combine specific permissions.  
- **Classic roles:** Older subscription-level roles (Service Administrator, Co-Administrator), mostly for legacy systems.  

*Example:* Created a custom role for AKS management without allowing NSG changes to avoid accidental disruptions.

---

## 5. Can RBAC assignments be inherited? How does that work?

**Answer:**  
Yes. Roles are inherited **down the scope hierarchy**.  

*Example:* Assigned Contributor at the subscription → all resource groups inherit it.  
Assigned Reader at a resource group → only that group’s resources inherit it.  

*Scenario:* DevOps Monitoring team only needed read access to production resource groups, so I assigned **Reader** at the resource group scope, not subscription.

---

## 6. What is the difference between Azure RBAC and Azure AD roles?

**Answer:**  
- **Azure RBAC:** Controls access to **Azure resources** like VMs, storage, databases.  
- **Azure AD roles:** Controls access to the **directory itself**, like managing users or registering apps.  

*Example:* User with User Administrator in Azure AD cannot deploy a VM. They also need RBAC access.

---

## 7. Have you used Conditional Access or Privileged Identity Management (PIM) with RBAC?

**Answer:**  
Yes. PIM and Conditional Access help control **time-bound, approved, and secure access**.  

*Example:* Configured PIM for Owner role on a subscription, requiring temporary elevation with approval. Combined with Conditional Access to enforce MFA and compliant device checks.

---

## 8. How do you handle multi-subscription access in Azure RBAC?

**Answer:**  
- Use **management groups** to organize subscriptions.  
- Assign roles at the management group level for cross-subscription permissions.  
- For exceptions, assign roles at subscription/resource group levels.  

*Scenario:* Enterprise with 10 subscriptions needed a central monitoring team. I created a management group, assigned **Reader** role to the team, and selectively elevated access at subscription/resource group levels.

---

## 9. How would you design RBAC for a Dev/Test/Prod environment?

**Answer:**  
- **Dev:** Broad Contributor roles for engineers to experiment.  
- **Test:** Limited Contributor, restrict production-like resources.  
- **Prod:** Least privilege, PIM for temporary elevated access, restrict sensitive resources.  

*Scenario:* Production DB access was limited to a few users with **time-bound roles** to reduce risk while maintaining operational efficiency.

---

## 10. How do you implement least privilege in Azure RBAC?

**Answer:**  
- Assign the **narrowest scope** possible.  
- Use **built-in roles** first, then custom roles if needed.  
- Apply **PIM** for sensitive roles.  
- Audit role assignments regularly using **Azure Access Reviews**.  

*Example:* Developers could deploy to resource groups but could not access storage secrets or production databases.

---

## 11. What are some challenges you faced with RBAC in large organizations?

**Answer:**  
- **Role explosion:** Too many custom roles due to unique requirements.  
- **Inheritance confusion:** Users get unexpected access from parent scopes.  
- **Service principal limitations:** Certain actions require multiple roles.  

*Solution:* Document all roles, scopes, and inheritance paths. Periodically review with **Azure Access Reviews**.

---

## 12. Can RBAC be combined with resource locks?

**Answer:**  
Yes. **RBAC controls who can do what**, while **resource locks prevent accidental deletion/modification**.  

*Example:* Production storage account: Contributor role allowed deployment, but **ReadOnly lock** prevented accidental deletion.

---

## 13. How do you audit and monitor RBAC assignments?

**Answer:**  
- Use **Azure Activity Logs** and **Azure Monitor**.  
- **Access Reviews** in Azure AD for periodic evaluation of role assignments.  
- Implement **alerts** for changes to critical roles.  

*Example:* Audit revealed a service principal with expired credentials still had Contributor access → removed immediately.

---

## 14. Explain custom roles in RBAC. How do you create one?

**Answer:**  
- Identify exact actions/resources required.  
- Define **actions**, **notActions**, **dataActions**, **notDataActions**.  
- Assign at the appropriate scope.  

*Example:* Created a custom role allowing AKS deployment + Key Vault read, without network changes.

---

## 15. How would you handle cross-tenant RBAC scenarios?

**Answer:**  
- Use **guest accounts** in Azure AD.  
- Assign RBAC roles at subscription/resource group scopes.  
- Audit carefully to avoid over-permission.  

*Scenario:* External partner needed temporary access to a subset of resources; we used **Azure B2B guest accounts** with time-bound RBAC roles.

---

**Tip for interview:** Always explain with **real-life scenarios, scope considerations, and security implications**. Interviewers for experienced DevOps roles look for practical understanding, not textbook definitions.

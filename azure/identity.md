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

# Azure Active Directory (Azure AD) 

## 1. Basics of Azure AD

**Q1: What is Azure Active Directory?**  
**Answer:** Azure AD is Microsoft’s cloud-based identity and access management service. It manages authentication, authorization, and access to cloud apps like Office 365, Azure resources, and third-party SaaS apps. It supports single sign-on (SSO), multi-factor authentication (MFA), role-based access control (RBAC), and conditional access policies.  

*Scenario:* Employees log in to multiple cloud apps with one Azure AD account instead of separate passwords.

---

**Q2: How is Azure AD different from on-premises Active Directory?**  
**Answer:**  
- **AD DS:** Manages on-prem Windows environments (domain-joined devices, group policies).  
- **Azure AD:** Cloud-based, identity as a service (IDaaS), works with SaaS apps and cloud resources.  
- Integration via **Azure AD Connect** enables hybrid identity.  

*Scenario:* A company uses on-prem AD for file servers and Azure AD for Office 365 SSO.

---

**Q3: What is an Azure AD tenant?**  
**Answer:** A tenant represents an organization in Azure AD. All users, groups, and apps belong to a tenant. One subscription has a default tenant, but multiple tenants can exist for different divisions or subsidiaries.  

*Scenario:* Different subsidiaries maintain separate tenants but collaborate via B2B guest users.

---

## 2. Users, Groups, and Roles

**Q4: What are the types of users in Azure AD?**  
**Answer:**  
- **Member users:** Internal employees.  
- **Guest users:** External users invited via Azure AD B2B, with limited access.  

*Scenario:* A vendor is invited as a guest user to access a Dev/Test subscription.

---

**Q5: What are groups in Azure AD and why are they used?**  
**Answer:**  
- **Security groups:** Assign permissions collectively using RBAC.  
- **Microsoft 365 groups:** Collaboration-focused, used with Teams, SharePoint, etc.  
- **Dynamic groups:** Membership based on attributes like department or role.  

*Scenario:* “DevOps Engineers” group assigned Contributor role on a resource group; new members inherit access automatically.

---

**Q6: Explain Azure AD roles and RBAC integration.**  
**Answer:**  
- Azure AD roles (e.g., Global Administrator, User Administrator) manage directory-level permissions.  
- Azure RBAC roles (e.g., Contributor, Reader) manage resource-level permissions.  
- Roles can be built-in or custom, assigned at tenant, subscription, or resource level.  

*Scenario:* A DevOps engineer has Reader on production subscription but Contributor on staging.

---

## 3. Authentication and Access Management

**Q7: What are the authentication methods supported in Azure AD?**  
**Answer:**  
- **Cloud-only:** Password stored in Azure AD.  
- **Synchronized accounts:** Passwords synced from on-prem AD via Azure AD Connect.  
- **Federated authentication:** Via ADFS or other IdPs.  
- **Multi-factor authentication (MFA)** and **passwordless authentication** (FIDO2, Windows Hello).  

*Scenario:* Finance team uses MFA for sensitive apps; developers use passwordless FIDO2 keys.

---

**Q8: What is Conditional Access in Azure AD?**  
**Answer:** Policies enforce access based on conditions like location, device compliance, application, or user risk.  

*Scenario:* MFA is required only if login occurs outside corporate VPN.

---

**Q9: What is Privileged Identity Management (PIM)?**  
**Answer:**  
- Provides just-in-time, time-bound, and approval-based access to high-privilege roles in Azure AD or Azure resources.  
- Reduces risks from permanently assigned admin accounts.  

*Scenario:* Admin requests Global Administrator access for 1 hour to perform tenant updates; access expires automatically.

---

## 4. Applications and SSO

**Q10: How does Azure AD enable Single Sign-On (SSO)?**  
**Answer:**  
- SSO lets users authenticate once to access multiple apps.  
- Supports SAML, OAuth, OpenID Connect.  
- Manages SaaS apps (Salesforce, Jira, ServiceNow) or custom apps.  

*Scenario:* Employees access Jira and Salesforce with one Azure AD login, eliminating password sprawl.

---

**Q11: What is Azure AD B2B and B2C?**  
**Answer:**  
- **B2B:** Invite external business partners to your tenant as guest users.  
- **B2C:** Manage consumer identities for apps; supports social logins (Google, Facebook).  

*Scenario:* Contractors access Dev/Test subscription via B2B guest accounts; end-users log into a retail app via B2C using Google login.

---

**Q12: How do you secure applications in Azure AD?**  
**Answer:**  
- Assign roles using RBAC.  
- Use Conditional Access policies.  
- Enable Identity Protection for risk detection.  
- Use managed identities for applications to access resources securely without credentials.  

*Scenario:* An Azure Function accesses Key Vault secrets using a managed identity instead of storing credentials.

---

## 5. Hybrid Identity

**Q13: What is Azure AD Connect and why is it used?**  
**Answer:** Syncs on-premises AD users, groups, and passwords to Azure AD, enabling hybrid identity.  

**Modes:**  
- Password hash sync: Syncs password hash to Azure AD.  
- Pass-through authentication: Validates passwords against on-prem AD.  
- Federation: Redirects authentication to on-prem ADFS.  

*Scenario:* Employees use same password for on-prem apps and Office 365 via SSO.

---

**Q14: What is federation with Azure AD?**  
**Answer:** Uses SAML, WS-Fed, or OpenID Connect to allow users to authenticate via Azure AD into external applications.  

*Scenario:* HR portal uses SAML SSO via Azure AD for employee login.

---

## 6. Monitoring and Security

**Q15: How do you monitor Azure AD?**  
**Answer:**  
- Sign-in logs: Monitor login activity, failed logins, location, and risk.  
- Audit logs: Track role assignments, group changes, app registration, and security events.  
- Azure AD Identity Protection: Detects compromised accounts or risky sign-ins.  
- Access reviews: Periodic evaluation of access for users and groups.  

*Scenario:* Every 90 days, guest users’ access to production subscriptions is reviewed automatically.

---

**Q16: How do you implement least privilege in Azure AD?**  
**Answer:**  
- Assign the narrowest role possible.  
- Use PIM for temporary elevated access.  
- Monitor access via audit logs and access reviews.  

*Scenario:* Developers can deploy to resource groups but cannot access production databases or secrets.

---

## 7. Advanced/Expert Questions

**Q17: What are managed identities?**  
**Answer:** Assign an identity to Azure resources (VMs, Functions, App Service) to access other Azure resources without storing credentials.  

*Scenario:* A Function app reads Key Vault secrets using a managed identity.

---

**Q18: What are dynamic groups in Azure AD?**  
**Answer:** Membership is based on user attributes like department, role, or location. Users are automatically added or removed.  

*Scenario:* All users in “Sales” department automatically get access to sales apps.

---

**Q19: Explain entitlement management in Azure AD.**  
**Answer:** Automates access packages for users, groups, and guests with approval workflows and expiration policies.  

*Scenario:* New interns get temporary access to Dev/Test subscriptions and apps without manual IT intervention.

---

**Q20: How does Azure AD implement zero trust security?**  
**Answer:**  
- Verify identity, device, location, risk, and application context before granting access.  
- Use Conditional Access, MFA, PIM, and device compliance to enforce least privilege.  

*Scenario:* Remote login from an unmanaged device triggers MFA and blocks access to production apps until compliance is verified.

---

**Q21: How do you integrate Azure AD with DevOps pipelines?**  
**Answer:**  
- Use service principals or managed identities for automated access to Azure resources.  
- Access controlled via RBAC and Conditional Access.  

*Scenario:* CI/CD pipeline deploys resources to Azure subscription securely without storing credentials in code.

---

**Q22: How do you handle external collaboration securely?**  
**Answer:**  
- Invite as B2B guest users.  
- Assign access via groups or RBAC at required scopes.  
- Enforce Conditional Access and MFA.  
- Use access reviews to remove stale users.  

*Scenario:* Partner developers get temporary access to Dev/Test resources in a sandbox subscription.

---



# Azure App Service

## 1. What is Azure App Service?
Azure App Service is a fully managed Platform-as-a-Service (PaaS) used to host web apps, APIs, and backend services without managing infrastructure.

---

## 2. What is an App Service Plan?
An App Service Plan defines the compute resources, pricing tier, scaling capability, and region for one or more App Services.

---

## 3. Difference between App Service and Virtual Machine?
App Service is a managed PaaS platform while Virtual Machine gives full OS control and requires manual management.

---

## 4. What happens during autoscaling in App Service?
Autoscaling adds or removes new worker instances while using the same deployed application package.

---

## 5. Is a new deployment required during scaling?
No, scaling uses the same deployed application and only adds compute instances.

---

## 6. What is deployment slot?
Deployment slots are staging environments within App Service used for zero downtime deployments and safe releases.

---

## 7. What is slot swap?
Slot swap exchanges configuration and traffic between staging and production with minimal downtime.

---

## 8. What is ARR affinity?
ARR affinity is a cookie-based mechanism that routes a user to the same instance for session persistence.

---

## 9. What is SNAT exhaustion?
SNAT exhaustion occurs when outbound connections exceed available Azure port limits causing intermittent network failures.

---

## 10. How do you fix SNAT exhaustion?
It is fixed by reusing connections, scaling out instances, or using NAT Gateway for outbound traffic.

---

## 11. What is VNet Integration?
VNet Integration allows App Service to securely access private resources inside an Azure Virtual Network.

---

## 12. What is Private Endpoint?
Private Endpoint provides a private IP inside a virtual network to access App Service without using public internet.

---

## 13. Difference between VNet Integration and Private Endpoint?
VNet Integration is for outbound access while Private Endpoint is for secure inbound access.

---

## 14. What is Azure Front Door?
Azure Front Door is a global load balancer that provides traffic routing, caching, WAF, and high availability for web applications.

---

## 15. What is Managed Identity?
Managed Identity allows Azure services to authenticate securely without storing credentials.

---

## 16. What is Azure Key Vault used for?
Key Vault is used to securely store secrets, keys, and certificates for applications.

---

## 17. What is Kudu?
Kudu is the advanced debugging and deployment console for Azure App Service.

---

## 18. What is Oryx?
Oryx is the Azure build engine that detects runtime and builds applications during deployment.

---

## 19. What causes 500 error in App Service?
A 500 error usually occurs due to application exceptions, misconfiguration, or backend service failures.

---

## 20. What causes 502 error?
A 502 error occurs when the application fails to start or the backend service is unreachable.

---

## 21. What causes 503 error?
A 503 error happens when the service is unavailable due to scaling issues or high resource usage.

---

## 22. What causes 504 error?
A 504 error occurs when backend services take too long to respond causing a gateway timeout.

---

## 23. What is Deployment Center?
Deployment Center is a feature used to connect App Service with CI/CD pipelines like GitHub or Azure DevOps.

---

## 24. Why is GitHub Actions shown more than Azure DevOps?
GitHub Actions is Microsoft’s preferred modern CI/CD solution and is more tightly integrated with Azure.

---

## 25. Does Azure DevOps work with App Service?
Yes, Azure DevOps fully supports App Service deployment using pipelines and service connections.

---

## 26. What is Azure Service Linker?
Service Linker automatically configures secure connections between Azure services using managed identity.

---

## 27. What is autoscaling based on?
Autoscaling is based on CPU, memory, HTTP queue length, or custom performance metrics.

---

## 28. What is scale out vs scale up?
Scale out adds more instances while scale up increases the size of the existing instance.

---

## 29. What is App Service sandbox?
It is a secure isolated environment where App Service applications run with restricted system access.

---

## 30. What is zero downtime deployment?
Zero downtime deployment is achieved using deployment slots and traffic switching strategies.

---

## 31. What is CI/CD in App Service?
CI/CD is the automated process of building, testing, and deploying applications to App Service.

---

## 32. What is Application Insights?
Application Insights is a monitoring service used to track performance, logs, and failures in applications.

---

## 33. What is App Service Environment (ASE)?
ASE is a fully isolated and dedicated App Service deployment inside a virtual network for high security.

---

## 34. What is HTTPS in App Service?
HTTPS encrypts traffic between client and server using TLS certificates for secure communication.

---

## 35. What is a certificate in simple terms?
A certificate is a digital identity proof for a website that enables secure encrypted communication.

---

## 36. What is identity provider?
An identity provider is a system that authenticates users and issues secure login tokens.

---

## 37. What is Microsoft Entra ID?
Microsoft Entra ID is Azure’s identity service used for authentication, authorization, and single sign-on.

---

## 38. What is App Service deployment failure reason?
Deployment failure usually happens due to wrong runtime stack, missing dependencies, or build errors.

---

## 39. What is App Service scaling limitation?
Scaling is limited by the App Service Plan SKU and available regional capacity.

---

## 40. What is best practice for App Service in production?
Best practice is using deployment slots, managed identity, autoscaling, and Application Insights for monitoring.

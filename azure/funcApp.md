# Azure Function App — DevOps Interview Quick Notes

## 1. What is Azure Function App?

A serverless compute service used to run event-driven code without managing servers.

---

## 2. Difference between Azure Function and Function App?

* Function = single execution unit
* Function App = container hosting multiple functions

---

## 3. What are common Azure Function triggers?

* HTTP Trigger
* Timer Trigger
* Blob Trigger
* Queue Trigger
* Service Bus Trigger
* Event Grid Trigger

---

## 4. What is serverless?

Cloud model where infrastructure scaling and management are handled automatically by Azure.

---

## 5. Why is Storage Account mandatory?

Used internally for:

* scaling coordination
* trigger state
* checkpoints
* logs
* Durable Functions state

---

## 6. What hosting plans are available?

* Consumption
* Flex Consumption
* Premium
* Dedicated/App Service
* Container Apps

---

## 7. Difference between Consumption and Premium Plan?

| Consumption       | Premium              |
| ----------------- | -------------------- |
| Pay per execution | Pre-warmed instances |
| Cold starts       | No cold starts       |
| Cheap             | Expensive            |
| Scale to zero     | Always running       |

---

## 8. What is cold start?

Delay when Azure starts a new function instance after inactivity.

---

## 9. How to avoid cold starts?

Use:

* Premium Plan
* Always Ready instances

---

## 10. What is host.json?

Global runtime configuration file for Function App.

---

## 11. What is function.json?

Defines triggers and bindings for a function.

---

## 12. Difference between host.json and function.json?

| host.json        | function.json         |
| ---------------- | --------------------- |
| App-level config | Function-level config |

---

## 13. What are bindings?

Automatic integration with services without writing SDK code.

Examples:

* Blob binding
* Queue binding
* Cosmos DB binding

---

## 14. What runtimes are supported?

* .NET
* Python
* Node.js
* Java
* PowerShell
* Custom Handler

---

## 15. What is Custom Handler?

Allows unsupported languages like:

* Go
* Rust
* PHP

Azure forwards requests to your executable.

---

## 16. Can Function Apps host full websites?

Technically yes, but not recommended.
Best for:

* APIs
* background jobs
* event-driven systems

---

## 17. Difference between Function App and App Service?

| Function App | App Service      |
| ------------ | ---------------- |
| Event-driven | Full web hosting |
| Serverless   | Always running   |
| APIs/jobs    | Full websites    |

---

## 18. What is Managed Identity?

Azure-managed identity used for secure authentication without storing credentials.

---

## 19. How do Azure Functions scale?

Azure automatically creates/removes instances based on load and trigger events.

---

## 20. Difference between scale up and scale out?

| Scale Up  | Scale Out      |
| --------- | -------------- |
| Bigger VM | More instances |

---

## 21. What is Durable Function?

Extension used for stateful workflows and orchestration.

---

## 22. What is VNET integration?

Allows Function App to securely access private/internal resources.

---

## 23. What is Zone Redundancy?

Deploys app across multiple availability zones for high availability.

---

## 24. How to monitor Azure Functions?

Using:

* Application Insights
* Azure Monitor
* Log Analytics

---

## 25. What deployment methods are used?

* Azure DevOps
* GitHub Actions
* VS Code Publish
* Zip Deploy
* Terraform/Bicep

---

## 26. What are deployment slots?

Used for staging and zero-downtime deployments.

---

## 27. What authentication levels exist in HTTP triggers?

* anonymous
* function
* admin

---

## 28. Why choose Premium Plan?

* no cold starts
* VNET support
* better performance
* production workloads

---

## 29. Why choose Consumption Plan?

Cheap and best for:

* low traffic
* event-driven jobs
* development/testing

---

## 30. What happens if Storage Account goes down?

Functions may:

* stop triggering
* fail scaling
* lose checkpoints

---

## 31. What is the use of Application Insights?

Monitoring, logging, telemetry, failures, and performance tracking.

---

## 32. What is retry policy?

Automatic retry configuration for failed executions.

---

## 33. What causes Function timeout?

* long-running execution
* API delays
* memory exhaustion

---

## 34. What is API Management with Functions?

Used to:

* secure APIs
* rate limit
* expose centralized API gateway

---

## 35. Best practices for Function Apps?

* use Managed Identity
* use Key Vault
* avoid hardcoded secrets
* monitor with App Insights
* use IaC
* use deployment slots

---

## 36. Important numeric facts

| Item                         | Value     |
| ---------------------------- | --------- |
| Consumption timeout default  | 5 min     |
| Consumption timeout max      | 10 min    |
| Premium timeout              | Unlimited |
| Storage account max length   | 24 chars  |
| Function App name uniqueness | Global    |

---

## 37. Common interview scenario question

### Q:

API is slow only on first request.

### A:

Cold start issue. Move to Premium Plan or use Always Ready instances.

---

## 38. Common architecture question

```text id="r1"
Frontend
   ↓
API Management
   ↓
Azure Function App
   ↓
Storage/Database
```

---

## 39. Most important topics interviewers focus on

* Hosting plans
* Scaling
* Cold starts
* Storage dependency
* Security
* Monitoring
* CI/CD
* Networking
* Durable Functions

---

## 40. Most important DevOps tools around Function Apps

* Terraform
* Bicep
* Azure DevOps
* GitHub Actions
* Application Insights
* Key Vault
* API Management

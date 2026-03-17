# Advanced GitHub Actions Interview Questions & Answers

## 1. Why is using OpenID Connect (OIDC) more secure than storing cloud credentials in GitHub secrets? How do you implement it?

Using OIDC removes the need for long-lived static credentials such as AWS access keys or Azure secrets. Instead, it relies on short-lived tokens that are generated dynamically and expire automatically. This greatly reduces the risk of credential leakage.

### Why it is more secure:

* No credentials stored in GitHub
* Tokens automatically expire
* Trust is established dynamically with the cloud provider
* Reduced impact if a token is compromised

### How to implement:

* Configure trust between GitHub and your cloud provider (AWS, Azure, or GCP)
* Grant permission for ID token access in your workflow
* Use the cloud provider’s official authentication action to exchange the token

Example (plain format):
permissions:
id-token: write
contents: read

steps:

* Use cloud provider action to assume role

---

## 2. How do you prevent older workflow runs from overwriting newer deployments?

You can use the concurrency feature to ensure that only one deployment runs at a time for a specific group such as a branch or environment.

### Key idea:

* Cancel any in-progress workflow when a new one starts

Example:
concurrency:
group: production-deploy
cancel-in-progress: true

### Benefits:

* Prevents race conditions
* Ensures latest deployment wins
* Saves compute cost

---

## 3. When should you use a JavaScript action over a composite action?

### Use JavaScript actions when:

* You need complex logic
* You need better performance
* You want to use npm libraries
* You want tighter control over execution

### Use composite actions when:

* You are chaining simple shell commands
* You want a simple wrapper around existing actions

### Key difference:

JavaScript actions run directly in Node.js and are faster, while composite actions execute multiple shell steps.

---

## 4. What is an ephemeral runner and why is it preferred?

An ephemeral runner is a self-hosted runner that is created for a single job and destroyed immediately after the job finishes.

### Benefits:

* Clean environment every time
* No leftover configuration or data
* Improved security
* Better scalability

### Use case:

Large organizations and high-security environments

---

## 5. How do you run integration tests with services like Redis without installing them manually?

You can use GitHub Actions services, which start Docker containers alongside your job.

Example:
jobs:
test:
services:
redis:
image: redis
ports:
- 6379:6379

```
steps:
  - Run your tests
```

### Benefits:

* No manual installation required
* Consistent environment
* Easy setup

---

## 6. How do you pass dynamically generated values between jobs?

Use job outputs to share values between jobs.

Example:
Job 1:

* Generate a value
* Store it in outputs

Job 2:

* Access using: needs.job1.outputs.value

### Key idea:

Outputs from one job can be consumed by another dependent job

---

## 7. How do you create a manual workflow trigger with inputs?

Use workflow_dispatch with inputs to allow manual triggering.

Example:
on:
workflow_dispatch:
inputs:
environment:
description: Select environment
required: true
reason:
description: Reason for deployment
required: true

### Benefits:

* Adds control to deployments
* Forces user input
* Improves accountability

---

## 8. How do you secure the default GitHub token?

Use the permissions key to limit access based on least privilege.

Example:
permissions:
contents: read
pull-requests: write

### Best practice:

* Default everything to minimal access
* Only grant required permissions

---

## 9. Variable precedence: workflow vs job vs step

If the same variable is defined in multiple places:

Priority order:

1. Step level (highest)
2. Job level
3. Workflow level (lowest)

### Example:

If NODE_ENV is:

* production at workflow level
* staging at job level
* test at step level

Then the final value used is: test

---

## 10. How do you allow a step to fail without failing the pipeline?

Use continue-on-error.

Example:

* Run linter
* continue-on-error: true

### Behavior:

* Step can fail
* Pipeline continues execution
* Job marked successful with warning

### Use cases:

* Linting
* Optional checks
* Experimental steps

---

## Final Notes

These topics are important for senior roles because they demonstrate:

* Security (OIDC, permissions)
* Scalability (ephemeral runners, concurrency)
* Maintainability (outputs, reusable logic)
* Reliability (error handling, controlled deployments)

Mastering these helps you design production-ready CI/CD pipelines.

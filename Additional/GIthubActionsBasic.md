# GitHub Actions Interview Questions & Answers (Set 2)

## 1. What is the difference between `on: push` and `on: pull_request`? How do you trigger workflows only for specific file types?

### Difference:

* `on: push` triggers when code is pushed to a branch
* `on: pull_request` triggers when a PR is opened, updated, or synchronized

### When to use:

* Use `push` for deployments or post-merge workflows
* Use `pull_request` for validation before merging

### Trigger only for specific files:

Use path filters to run workflows only when certain files change.

Example:
on:
push:
paths:
- '**.js'

### Benefit:

* Saves CI/CD cost
* Runs workflows only when relevant files are modified

---

## 2. When should you use a self-hosted runner? What is the main security concern?

### Use self-hosted runners when:

* You need access to private resources (databases, internal APIs)
* You require specialized hardware (GPU, large memory)
* You want to reduce cost for long-running jobs

### Security concern:

In public repositories, anyone can create a pull request that executes code on your infrastructure.

### Risk:

* Malicious code execution
* Data exposure
* Infrastructure compromise

### Best practice:

* Avoid self-hosted runners for public repos
* If used, enforce strict environment protections and approvals

---

## 3. How do you securely pass a Docker Hub password? Why avoid using echo?

### Secure method:

* Store credentials in GitHub Secrets
* Access using: secrets.VARIABLE_NAME

Example:
Use secrets.DOCKER_PASSWORD inside your workflow

### Why avoid echo:

* GitHub masks secrets in logs, but manipulation can expose them
* Printing secrets increases risk of leakage

### Best practice:

* Never log secrets
* Use them directly in commands or environment variables

---

## 4. What is a matrix strategy?

A matrix strategy allows you to run the same job multiple times with different configurations.

### Example concept:

* Multiple OS: Ubuntu, Windows, macOS
* Multiple Node versions: 16, 18, 20

### Benefits:

* Parallel execution
* Cross-platform testing
* No need to duplicate workflows

### Real-world use:

Ensures your app works across environments without writing separate jobs

---

## 5. Difference between a custom action and a reusable workflow?

### Custom Action:

* Designed for a single task
* Reusable component inside jobs
* Example: Upload to S3, send notification

### Reusable Workflow:

* Entire workflow reused across repositories
* Standardizes CI/CD processes
* Called from other workflows

### Key difference:

* Custom action = single step logic
* Reusable workflow = full pipeline reuse

---

## 6. What are GitHub Actions contexts? How do you run a workflow only on main branch?

### Contexts:

They are variables that provide information about:

* Workflow
* Environment
* Events
* GitHub metadata

### Example:

github.ref contains branch information

### Run only on main:

Use conditional execution:

if: github.ref == 'refs/heads/main'

### Benefit:

* Control when workflows run
* Prevent accidental deployments

---

## 7. How do you speed up a Node.js workflow?

Use caching to avoid reinstalling dependencies.

### Methods:

* actions/cache
* actions/setup-node (built-in caching)

### How it works:

* Cache node_modules
* Use package-lock.json hash as cache key
* If unchanged → restore cache
* If changed → reinstall dependencies

### Benefit:

* Faster builds
* Reduced network usage
* Lower CI cost

---

## 8. How do you require manual approval before production deployment?

### Steps:

1. Create an environment (e.g., "production") in GitHub settings
2. Add required reviewers in environment protection rules
3. Reference the environment in your workflow

Example:
jobs:
deploy:
environment: production

### Behavior:

* Workflow pauses before deployment
* Requires approval from designated reviewer

### Benefit:

* Prevents accidental deployments
* Adds governance and control

---

## 9. How do you make one job wait for another?

By default, jobs run in parallel.

### Solution:

Use the `needs` keyword

Example:
deploy job depends on test job

### Behavior:

* Deploy runs only after test succeeds
* If test fails, deploy is skipped

### Benefit:

* Ensures proper pipeline order
* Avoids deploying untested code

---

## 10. Difference between secrets and artifacts? How do you pass files between jobs?

### Secrets:

* Used for sensitive data
* Examples: passwords, tokens, API keys
* Stored securely and encrypted

### Artifacts:

* Files generated during workflows
* Examples: build outputs, logs, binaries

### Passing files between jobs:

* Upload artifact in one job
* Download artifact in another job

Example concept:

* Job 1 → upload build file
* Job 2 → download and use it

### Benefit:

* Enables multi-stage pipelines
* Keeps workflows modular

---

## Final Notes

These concepts demonstrate:

* Security (secrets management, approvals)
* Efficiency (caching, matrix builds)
* Scalability (reusable workflows)
* Reliability (job dependencies, validations)

Mastering these ensures you can build production-ready CI/CD pipelines and handle real-world DevOps challenges.

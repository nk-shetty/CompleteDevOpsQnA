# ============================================================
# 1. What is PowerShell and how is it different from CMD?
# ============================================================
# PowerShell is a task automation and configuration management framework
# built on top of .NET. Unlike CMD, which works with plain text output,
# PowerShell works with structured objects. This allows us to directly
# access properties like Status, Name, CPU instead of parsing strings.
# In DevOps, this object-based pipeline makes automation much more reliable.


# ============================================================
# 2. What is the PowerShell Pipeline?
# ============================================================
# The pipeline passes full .NET objects from one command to another.
# Each command processes objects rather than raw text.
# This allows filtering, sorting, and transforming data efficiently.
#
Get-Service | Where-Object Status -eq "Running"


# ============================================================
# 3. What does $_ represent?
# ============================================================
# $_ represents the current object being processed in the pipeline.
# It is mainly used inside script blocks like Where-Object and ForEach-Object
# to reference each item.
#
Get-Process | Where-Object { $_.CPU -gt 100 }


# ============================================================
# 4. Difference between foreach and ForEach-Object
# ============================================================
# foreach is a language construct used when the data is already loaded
# into memory. It is generally faster and preferred for large datasets
# and complex logic.
#
# ForEach-Object works in the pipeline and processes objects as they
# stream through the pipeline. It is useful for inline operations.
#
$vms = Get-Process
foreach ($vm in $vms) {
    Write-Output $vm.Name
}


# ============================================================
# 5. What is Execution Policy?
# ============================================================
# Execution Policy controls how PowerShell handles script execution.
# It is a safety mechanism to prevent accidental execution of malicious scripts.
# It is not a full security boundary but a preventive control.


# ============================================================
# 6. Explain RemoteSigned -Scope CurrentUser
# ============================================================
# RemoteSigned allows locally created scripts to run freely,
# but requires scripts downloaded from the internet to be digitally signed.
# Scope CurrentUser applies this rule only to the logged-in user,
# which avoids needing administrative privileges.


# ============================================================
# 7. What does -WhatIf do?
# ============================================================
# The -WhatIf parameter simulates execution of a command
# without making any changes. It is extremely useful when performing
# destructive operations like deleting files or stopping services.
# In production DevOps environments, I use -WhatIf before applying changes.


# ============================================================
# 8. How do you handle errors in PowerShell?
# ============================================================
# I use structured error handling with Try/Catch/Finally blocks.
# This ensures the script does not fail silently and logs meaningful errors.
#
try {
    Get-Item "C:\InvalidPath" -ErrorAction Stop
}
catch {
    Write-Error "An error occurred: $_"
}


# ============================================================
# 9. What is Idempotency?
# ============================================================
# Idempotency means running the script multiple times
# produces the same result without causing side effects.
# I always check the current state before applying changes.
#
if ((Get-Service Spooler).Status -ne "Running") {
    Start-Service Spooler
}


# ============================================================
# 10. How do you securely manage credentials?
# ============================================================
# In enterprise environments, I avoid storing passwords in scripts.
# I use Azure Key Vault or managed identities.
# SecureString is used only for in-memory encryption,
# but Key Vault is the recommended production approach.


# ============================================================
# 11. What is SecureString?
# ============================================================
# SecureString stores sensitive information in encrypted format in memory.
# It prevents exposure of plain-text passwords.
#
$password = Read-Host "Enter Password" -AsSecureString


# ============================================================
# 12. What is PowerShell Remoting?
# ============================================================
# PowerShell Remoting allows executing commands on remote machines.
# It uses WinRM protocol and is essential in server automation.
#
Invoke-Command -ComputerName Server1 -ScriptBlock { Get-Service }


# ============================================================
# 13. Difference between -eq and -like
# ============================================================
# -eq checks exact equality.
# -like supports wildcard matching.
#
"VM01" -eq "VM01"
"VM01" -like "VM*"


# ============================================================
# 14. How do you schedule a script?
# ============================================================
# I use Task Scheduler or Register-ScheduledTask in automation scenarios.
# In Azure, I use Azure Automation Runbooks or pipeline scheduled triggers.


# ============================================================
# 15. What is a PowerShell Module?
# ============================================================
# A module is a collection of reusable functions packaged together.
# It improves code organization, reusability, and maintainability.
# In DevOps, I create internal modules for common automation tasks.


# ============================================================
# 16. How do you debug complex scripts?
# ============================================================
# I enable verbose logging, use breakpoints in VS Code,
# implement detailed logs, and test in lower environments before production.
#
$VerbosePreference = "Continue"
Write-Verbose "Debugging enabled"


# ============================================================
# 17. Azure CLI vs Azure PowerShell
# ============================================================
# Azure CLI is cross-platform and returns JSON.
# Azure PowerShell returns structured objects and integrates
# better with PowerShell scripting.


# ============================================================
# 18. Write-Output vs Write-Host
# ============================================================
# Write-Output sends data to pipeline.
# Write-Host writes directly to console and cannot be piped.
# In production scripts, I prefer Write-Output.


# ============================================================
# 19. What is PowerShell DSC?
# ============================================================
# Desired State Configuration ensures systems remain
# in a defined configuration state.
# It is declarative and helps enforce idempotency.


# ============================================================
# 20. How do you import CSV data?
# ============================================================
# Import-Csv converts CSV rows into PowerShell objects,
# making automation easier when processing bulk data.


# ============================================================
# 21. What is Custom Script Extension in Azure VMSS?
# ============================================================
# It allows running scripts during VM provisioning.
# It is commonly used for bootstrapping servers
# in auto-scaling environments.


# ============================================================
# 22. What is a Process?
# ============================================================
# A process is a running instance of a program in memory.
# It has a Process ID and consumes system resources.


# ============================================================
# 23. What is a Service?
# ============================================================
# A service runs in the background and provides
# system-level functionality without user interaction.


# ============================================================
# 24. What is a Scheduled Task?
# ============================================================
# A scheduled task executes programs based on triggers
# like time, startup, or events.


# ============================================================
# 25. How do you pass parameters to scripts?
# ============================================================
param(
    [string]$VMName
)
# Parameterization improves reusability and flexibility.


# ============================================================
# 26. What is the difference between Write-Verbose and Write-Debug?
# ============================================================
# Write-Verbose provides detailed informational messages.
# Write-Debug provides debugging-specific messages and requires -Debug flag.


# ============================================================
# 27. How do you ensure scripts are production-ready?
# ============================================================
# I ensure modular design, logging, error handling,
# idempotency, secure credentials, and version control.


# ============================================================
# 28. How do you version control scripts?
# ============================================================
# All scripts are stored in Git repositories.
# I use branching strategy, pull requests, and tagging for releases.


# ============================================================
# 29. How do you use PowerShell in Azure DevOps?
# ============================================================
# PowerShell is used in pipelines for infrastructure provisioning,
# application deployment, configuration management, and validation.


# ============================================================
# 30. What is the biggest advantage of PowerShell in DevOps?
# ============================================================
# The biggest advantage is object-based automation,
# deep Windows and Azure integration,
# and the ability to combine scripting with cloud operations
# in a structured and maintainable way.

# ============================================================
# QUESTION 31:
# Explain the PowerShell pipeline and why it is powerful.
# ============================================================

# Answer:
# The PowerShell pipeline passes structured .NET objects between commands
# rather than plain text. This allows direct access to properties like Status,
# Name, or CPU without parsing output manually. Because it works with objects,
# automation becomes more reliable, readable, and maintainable. Compared to
# traditional shells that rely on text processing, PowerShell reduces errors
# and improves script clarity.


# ============================================================
# QUESTION 32:
# What is idempotency and why is it important in DevOps?
# ============================================================

# Answer:
# Idempotency means that running a script multiple times results in the same
# system state without causing unintended side effects. In DevOps, this prevents
# configuration drift and ensures predictable deployments. I implement
# idempotency by checking the current state before applying any changes.


# ============================================================
# QUESTION 33:
# Difference between foreach and ForEach-Object?
# ============================================================

# Answer:
# 'foreach' is a language construct used when the collection is already loaded
# into memory and is generally faster. It is ideal for large datasets and
# complex logic. 'ForEach-Object' works within the pipeline and processes
# objects as they stream through. I choose between them based on performance
# requirements and script structure.


# ============================================================
# QUESTION 34:
# How do you securely manage credentials in automation?
# ============================================================

# Answer:
# I never hardcode credentials inside scripts. In Azure environments,
# I use Managed Identity or Azure Key Vault for secure secret management.
# If credentials must be handled within PowerShell, I use PSCredential
# objects and SecureString to avoid exposing sensitive information.


# ============================================================
# QUESTION 35:
# Explain Execution Policy and its scopes.
# ============================================================

# Answer:
# Execution Policy controls how PowerShell runs scripts. It is a safety
# mechanism to prevent accidental execution of untrusted scripts and
# should not be considered a security boundary. Scopes include Process,
# CurrentUser, and LocalMachine. In development environments, I commonly
# use RemoteSigned at the CurrentUser scope.


# ============================================================
# QUESTION 36:
# How do you debug complex PowerShell scripts?
# ============================================================

# Answer:
# I implement structured logging using Write-Verbose and proper log files.
# I use Try/Catch blocks to capture meaningful error information.
# During development, I use breakpoints and debugging tools in VS Code.
# In production, I validate changes in staging before deployment.


# ============================================================
# QUESTION 37:
# What does -WhatIf do and why is it important?
# ============================================================

# Answer:
# The -WhatIf parameter simulates command execution without applying changes.
# It is especially important for destructive operations such as deleting
# files, modifying infrastructure, or stopping services. In production,
# I use -WhatIf to validate the impact before executing changes.


# ============================================================
# QUESTION 38:
# How do you structure long PowerShell scripts for maintainability?
# ============================================================

# Answer:
# I structure long scripts using modular design with reusable functions
# and custom modules. I separate configuration, business logic, and execution
# layers. I also implement parameter validation, logging, and consistent
# naming conventions. All scripts are version-controlled using Git.


# ============================================================
# QUESTION 39:
# What is PowerShell Remoting and when would you use it?
# ============================================================

# Answer:
# PowerShell Remoting allows executing commands on remote machines using
# the WinRM protocol. It is essential for managing multiple servers,
# performing bulk updates, and automating infrastructure in hybrid cloud
# environments. I frequently use Invoke-Command for remote operations.


# ============================================================
# QUESTION 40:
# How do you use PowerShell in Azure DevOps pipelines?
# ============================================================

# Answer:
# In Azure DevOps pipelines, PowerShell is used for infrastructure
# provisioning, application deployment, configuration management,
# and validation tasks. I typically use AzurePowerShell tasks with
# secure service connections. Scripts are parameterized to support
# multiple environments such as Dev, QA, and Production.


# End of File


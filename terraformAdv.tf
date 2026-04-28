
# 1. What is Terraform and why is it used?
# Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp.
# It allows you to define, provision, and manage cloud infrastructure declaratively using configuration files.
# Terraform supports multiple providers (AWS, Azure, GCP, etc.), enabling consistent deployments across clouds and environments.

# 2. How do you install Terraform?
# Terraform can be installed by downloading the appropriate binary from the official HashiCorp website,
# or using a package manager like chocolatey for Windows (choco install terraform) or brew for macOS (brew install terraform).
# After installation, verify with terraform version.

# 3. What is Terraform backend and why is it used?
# A backend in Terraform defines where the state file is stored and how it is managed.
# Remote backends like S3 with DynamoDB lock or Azure Storage allow collaboration, state locking, and versioning.
# Using a backend ensures multiple team members don’t overwrite each other’s state during concurrent runs.

# 4. What is Terraform drift and how do you handle it?
# Drift occurs when infrastructure changes outside Terraform (manual changes in cloud console) diverge from the Terraform state.
# To handle drift:
# - Run terraform plan to detect differences between actual infrastructure and state.
# - Update the Terraform configuration to reflect desired state or use terraform import to bring existing resources under management.
# - Reapply terraform apply to reconcile the drift.

# 5. How do you define and use variables in Terraform?
# Variables are defined using the variable block. They allow parameterization instead of hardcoding values.
# Example:
# variable "region" {
#   description = "AWS region to deploy resources"
#   type        = string
#   default     = "us-east-1"
# }
# provider "aws" {
#   region = var.region
# }
# Variables can also be passed via CLI or terraform.tfvars files.

# 6. How do you import existing resources into Terraform?
# If a resource already exists in the cloud, you can import it using terraform import to bring it under Terraform management.
# Example: terraform import aws_instance.my_instance i-0abcd1234efgh5678
# After import, you need to write the corresponding Terraform configuration for that resource.
# Import only adds the state, not the config.

# 7. Explain conditional operators in Terraform with an example.
# Terraform supports the ternary conditional operator: condition ? true_value : false_value.
# Example:
# variable "create_s3" {
#   type    = bool
#   default = true
# }
# resource "aws_s3_bucket" "example" {
#   count = var.create_s3 ? 1 : 0
#   bucket = "my-example-bucket"
# }
# This allows creating resources conditionally without duplicating code.

# 8. What are Terraform provisioners and when are they used?
# Provisioners allow running scripts or commands on a resource after creation.
# Example:
# resource "aws_instance" "web" {
#   ami           = "ami-123456"
#   instance_type = "t2.micro"
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update",
#       "sudo apt-get install -y nginx"
#     ]
#   }
# }
# Provisioners are often used for bootstrapping or configuration tasks, but should be a last resort.

# 9. How do you manage multi-region and multi-cloud deployments?
# Define multiple providers with aliases for different regions or clouds.
# Example:
# provider "aws" {
#   alias  = "us_east"
#   region = "us-east-1"
# }
# provider "aws" {
#   alias  = "us_west"
#   region = "us-west-2"
# }
# resource "aws_s3_bucket" "east" {
#   provider = aws.us_east
#   bucket   = "east-bucket"
# }
# resource "aws_s3_bucket" "west" {
#   provider = aws.us_west
#   bucket   = "west-bucket"
# }

# 10. How do you implement state file locking in Terraform?
# When using remote backends like S3 + DynamoDB or Azure Storage, Terraform can automatically lock the state file.
# Locking ensures that only one terraform apply runs at a time to prevent concurrent modifications.

# 11. What are Terraform workspaces and their use cases?
# Workspaces allow managing multiple environments (dev, staging, prod) using the same Terraform configuration.
# Each workspace has its own state file, which is useful for environment isolation without duplicating code.
# Example:
# terraform workspace new dev
# terraform workspace select dev

# 12. Real-time scenario questions

# Q: You have an existing cloud resource manually created in AWS. How do you bring it under Terraform management without destroying it?
# A: Use terraform import to bring the resource into state, then define the resource in configuration with the same attributes.
# After this, Terraform can manage it safely.

# Q: How do you handle sensitive values like passwords or API keys?
# A: Store them as variables marked sensitive = true, use Terraform Cloud/Enterprise secrets, or integrate with Key Vault/Secrets Manager.
# Avoid hardcoding sensitive information.

# Q: How would you manage infrastructure across multiple regions for high availability?
# A: Use multiple provider aliases for each region, create replicated resources per region, and optionally use modules for reusable multi-region deployments.

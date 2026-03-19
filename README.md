**Azure SRE Infrastructure Pipeline**
Project Overview:
This project demonstrates a production-ready Site Reliability Engineering (SRE) workflow using Terraform and GitHub Actions. It automates the deployment of a hardened Linux web server (Nginx) on Azure, featuring a fully modular architecture, remote state management, and proactive monitoring.

Architecture:
The infrastructure is decomposed into three distinct functional modules to ensure scalability and separation of concerns:

Networking: Virtual Network (VNet), Subnet, Network Security Group (NSG), and Static Public IP.

Compute: ARM64 Ubuntu Linux VM and Network Interface (NIC).

Monitoring: Azure Monitor Metric Alerts and Action Groups for incident notification.

**SRE Skill Highlights**
Zero-Downtime Refactoring: Successfully migrated a monolithic HashiCorp Configuration Language (HCL) configuration into a modular structure using moved blocks. This ensured state reconciliation without resource destruction or service interruption.

Observability and Alerting: Implemented Azure Monitor alerts for CPU saturation (>80%) and VM Availability. Validated the monitoring stack via synthetic "Chaos" testing using the stress utility to confirm incident response triggers.

CI/CD Automation: Integrated GitHub Actions for automated terraform plan on pull requests and manual terraform destroy triggers via workflow_dispatch to manage cloud costs and resource lifecycles.

Security and State Management: Managed remote state via Azure Blob Storage with state locking to prevent concurrency conflicts. Secured the environment using OpenSSH key pairs and restricted NSG rules for Port 80 (HTTP) and Port 22 (SSH).

Getting Started
Prerequisites: Azure CLI, Terraform CLI, and a GitHub Repository.

Infrastructure Secrets: Add the following to GitHub Actions Secrets:

AZURE_CLIENT_ID
AZURE_CLIENT_SECRET
AZURE_SUBSCRIPTION_ID
AZURE_TENANT_ID
AZURE_SSH_PUBLIC_KEY

Local Deployment:

```PowerShell
terraform init
terraform plan
terraform apply
```
**Lessons Learned** (The SRE Perspective)
State Reconciliation (Conflict 409 / Not Found 404):
Encountered synchronization issues between the Azure Portal and the local Terraform state. I resolved these by utilizing terraform import to bring existing resources under management without triggering destructive recreation. This reinforced the importance of the State File as the single source of truth for Infrastructure as Code (IaC).

API Namespace Casing Sensitivity:
The Azure Monitor API returned 400 Bad Request errors due to strict casing requirements. I identified that while some Azure Resource Providers are flexible, the Insights provider requires exact PascalCase mapping (e.g., Microsoft.Compute/virtualMachines). This highlighted the need for rigorous API documentation verification during monitoring implementation.

Concurrency and State Locking:
Experienced a "Lease Conflict" when a Terraform process was interrupted, causing Azure Blob Storage to maintain a lock on the state file. I performed a manual "Break Lease" operation within the Storage Account to restore access. This demonstrated the critical role of state locking in preventing "split-brain" infrastructure corruption in team environments.

Resource Immutability (Force Replacement):
Discovered that renaming core resources (such as the Network Interface or Public IP) triggers a "Force Replacement" in the Azure fabric. To preserve uptime, I implemented moved blocks and lifecycle { ignore_changes } arguments. This allowed for a successful modular refactor while maintaining the integrity of the live environment.

Automated Secret Protection:
Validated GitHub’s Push Protection and Secret Scanning capabilities by attempting to commit sensitive data. I migrated all credentials and SSH keys to GitHub Secrets and implemented a strict .gitignore policy for *.tfvars. This ensured that the project adheres to Security+ standards and industry best practices for credential hygiene.


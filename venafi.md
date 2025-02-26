# Terraform Venafi Certificate Automation Module

## Overview
This Terraform module automates the process of requesting, creating, and managing certificates using **Venafi** via an integrated Python script. It provisions a Venafi certificate by executing a local Python script (`cert_util.py`) using Terraform's `null_resource` and `local-exec` provisioner.

## Features
- Automates Venafi certificate provisioning using Terraform.
- Supports authentication via OAuth for secure API access.
- Dynamically generates certificates based on provided environment variables.
- Provides an option to verify SSL certificates during API requests.
- Venafi stores and pushes the generated certificate into AWS ACM.

## Use Cases
This module can be used for:
- **Automated Certificate Provisioning**: Automates the request and issuance of certificates via Venafi.
- **Secure Infrastructure Deployments**: Ensures secure communications by dynamically provisioning SSL certificates.
- **Integration with Cloud Services**: Facilitates secure access to AWS services requiring TLS/SSL.
- **Compliance and Security Automation**: Enforces security policies for certificate management within enterprise environments.

## Prerequisites
- Terraform installed on your system.
- Python 3 installed with necessary dependencies.
- A Venafi account with API access.
- AWS credentials configured if used in a cloud-based environment.

## Terraform Variables

| Variable Name       | Description                                             | Type    | Default |
|---------------------|---------------------------------------------------------|---------|---------|
| `hostname`         | The hostname for the certificate                        | string  | `test101` |
| `environment`      | Deployment environment (e.g., prod, non-prod)          | string  | `nonprod` |
| `region`           | AWS region where the certificate is used               | string  | `us-east-1` |
| `account_id`       | AWS account ID                                          | string  | `147058048292` |
| `log_level`        | Logging level (e.g., INFO, DEBUG)                      | string  | `INFO` |
| `verify_ssl`       | Whether to verify SSL certificates in API requests     | bool    | `false` |
| `username`         | Venafi username for authentication                     | string  | `masked` |
| `password`         | Venafi password for authentication                     | string  | `masked` |

## Sample Module Usage
```
module "venafi_cert" {
  source        = "./modules/venafi_cert"  # Update with the correct module path
  hostname      = var.hostname
  environment   = var.environment
  region        = var.region
  account_id    = var.account_id
  log_level     = var.log_level
  verify_ssl    = var.verify_ssl
  username      = var.username
  password      = var.password
}

```
## Sample terraform.tfvars File
```
hostname      = "test101"
environment   = "nonprod"
region        = "us-east-1"
account_id    = "147058048292"
log_level     = "INFO"
verify_ssl    = false
username      = "masked"  # Replace with the actual username or use a secrets manager
password      = "masked"  # Replace with the actual password or use a secrets manager
```

## How It Works
1. **OAuth Authentication**: The `cert_util.py` script authenticates with Venafi using OAuth, obtaining an access token for API requests.
2. **AWS Folder Path Validation**:
   - Checks if the AWS account folder exists under `\\VED\\Policy\\Internal Certificates\\Amazon Web Services Accounts\\Subscriptions\\AWS-{account_id}`.
   - If not found, it creates the folder for AWS certificate management.
3. **Certificate Folder Validation**:
   - Checks if the certificate storage folder exists at `\\VED\\Policy\\Internal Certificates\\Amazon Web Services Accounts\\Subscriptions\\AWS-{account_id}\\Certificates`.
   - If missing, it creates the folder to store issued certificates.
4. **Certificate Request Validation**:
   - Ensures that the certificate object exists for the specified hostname.
   - If the certificate object is missing, it creates a new entry.
5. **Certificate Request Submission**:
   - Sends a certificate request to Venafi for approval.
6. **Certificate Retrieval**:
   - Once the request is approved, retrieves the issued certificate from Venafi.
7. **Storage and Logging**:
   - Stores the retrieved certificate in a local file for further use.
   - Logs each step for audit and debugging purposes.


## Notes
- Ensure that the `cert_util.py` script has the correct permissions to execute.
- The `verify_ssl` variable should be enabled in production environments for security.
- Logs are available based on the `log_level` variable setting.

---
This module simplifies Venafi certificate management and enhances security automation for your infrastructure.


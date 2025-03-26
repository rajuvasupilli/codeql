# Using the Venafi Terraform Module

This guide provides instructions on how to utilize the Venafi Terraform module to automate the provisioning and management of SSL/TLS certificates within your AWS environment.

## Prerequisites

Before using the Venafi Terraform module, ensure you have the following:

- **Venafi API Access:** Obtain OAuth credentials for authentication with the Venafi platform.
- **AWS Credentials:** Configure AWS credentials with permissions to interact with AWS Certificate Manager (ACM).

## Module Variables:

Configure the following variables when using the module:
 - instance_count: Number of instances requiring certificates.
 - hostname: The hostname for the certificate.
 - environment: Deployment environment (e.g., nonprod, prod).
 - region: AWS region (e.g., us-east-1).
 - account_id: AWS account ID.
 - cert_sans: Subject Alternative Name (SAN) for the certificate.


## Module Usage:

The Venafi Terraform module can be used as below:

```hcl
module "venafi" {
  source      = "git::https://gitlab.us.bank-dns.com/USBCLOUDPLATFORM/aws/computing/tf_modules/module-venafi-cert.git/?ref=feature/CPEAWS-2362"
  count       = var.instance_count
  hostname    = module.scm_registration[count.index].scm_name
  environment = var.environment
  region      = var.region
  account_id  = 147058048292 # data.aws_caller_identity.current.account_id
  cert_sans   = "${module.scm_registration[count.index].scm_name}.nonprod.aws.prv"
}






## Security Considerations:

**Authentication:** Ensure that OAuth credentials for Venafi are securely stored and managed.
**Access Control:** Limit AWS IAM permissions to only those necessary for certificate management.
**Logging and Monitoring:** Implement logging and monitoring to track certificate issuance and usage.
  





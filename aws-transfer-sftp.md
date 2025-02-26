# Terraform SFTP Module

## Overview
This Terraform module provisions an AWS SFTP Transfer Family server with configurable options for storage backend, security settings, and user management.

## Features
- Supports both **S3** and **EFS** as storage backends
- Configurable **endpoint type** (public or private within a VPC)
- Supports both **service-managed authentication** and **AWS Directory Service**
- Option to use **existing IAM roles, S3 buckets, and SSH keys**
- **CloudWatch logging** and **HIPAA compliance** support
- Multi-user support with specific roles and home directory configurations

## Use Cases
1. Provisioning AWS SFTP Servers
   -  Automates the deployment of AWS Transfer Family SFTP servers with configurable options for identity provider type, endpoint type, and security policies.

2. Secure File Transfers
   -  Enables organizations to transfer files securely using AWS SFTP with FIPS-compliant security policies and IAM role-based access control.

3. Multi-User Management
   - Supports multiple users with individual roles and permissions, ensuring controlled access to home directories based on logical or path-based configurations.

4. Custom Domain Integration with Route 53
   - Allows the use of custom hostnames for SFTP servers by provisioning Route 53 CNAME records dynamically.

5. AWS Directory Service Authentication
   - Supports integration with AWS Directory Service for centralized user authentication and access control.

6. Automated Key Management for SSH Authentication
   - Provides options for enabling SSH key-based authentication, including automatic key generation or using existing SSH keys.

7. Custom Home Directory Mapping
   - Supports logical directory mapping for different SFTP users, ensuring better organization of file transfers.

8. Secure Logging and Compliance
   - Automatically configures logging to AWS CloudWatch, enabling audit trails for security and compliance requirements (e.g., HIPAA, PCI-DSS).

9. Flexible Network Deployment
   - Supports deployment in a private VPC with custom subnet and security group configurations to enhance security and isolation.

## Prerequisites
- An AWS account with necessary permissions to create and manage Transfer Family resources
- Terraform installed
- An existing VPC and subnets (if using VPC-based endpoints)

## Variables
The following variables can be customized:

| Name                         | Description                              | Type           | Default Value                         |
|------------------------------|------------------------------------------|----------------|---------------------------------------|
| `sftp_server_name`           | Name of the SFTP server                  | `string`       | `SFTP_TEST`                           |
| `domain`                     | Storage domain type (S3 or EFS)          | `string`       | `S3`                                  |
| `existing_s3_bucket`         | Use an existing S3 bucket                | `string`       | `""`                                  |
| `existing_iam_role`          | Use an existing IAM role                 | `string`       | `""`                                  |
| `vpc_id`                     | VPC ID for the SFTP server               | `string`       | `vpc-0fb01c3637f1fd29e`               |
| `security_policy_name`       | Security policy for the SFTP server      | `string`       | `TransferSecurityPolicy-FIPS-2020-06` |
| `enable_logging`             | Enable CloudWatch logging                | `bool`         | `true`                                |
| `enable_hipaa_compliance`    | Enable HIPAA compliance features         | `bool`         | `true`                                |
| `endpoint_type`              | Endpoint type (public or private)        | `string`       | `public`                              |
| `subnet_ids`                 | List of subnet IDs                       | `list(string)` | `["subnet-062d74184c30c8ef8"]`        |
| `security_group_ids`         | Security group IDs                       | `list(string)` | `["sg-0b6496757bf80ee2b"]`            |
| `efs_file_system_id`         | EFS File System ID (if domain is EFS)    | `string`       | `fs-12345678`                         |
| `directory_id`               | AWS Directory Service ID                 | `string`       | `""`                                  |
| `use_logical`                | Use logical home directory mappings      | `string`       | `true`                                |
| `enable_ssh_key`             | Enable SSH key authentication            | `bool`         | `false`                               |
| `use_existing_ssh_keys`      | Use existing SSH keys                    | `bool`         | `false`                               |
| `existing_private_ssh_keys`  | Existing private SSH keys                | `string`       | `""`                                  |

## Sample Module Configuration

```
module "sftp" {
  source = "./modules/sftp"
  sftp_server_name          = var.sftp_server_name
  domain                    = var.domain
  existing_s3_bucket        = var.existing_s3_bucket
  existing_iam_role         = var.existing_iam_role
  vpc_id                    = var.vpc_id
  subnet_ids                = var.subnet_ids
  security_group_ids        = var.security_group_ids
  security_policy_name      = var.security_policy_name
  enable_logging            = var.enable_logging
  enable_hipaa_compliance   = var.enable_hipaa_compliance
  endpoint_type             = var.endpoint_type
  efs_file_system_id        = var.efs_file_system_id
  directory_id              = var.directory_id
  sftp_servers              = var.sftp_servers
  use_logical               = var.use_logical
  enable_ssh_key            = var.enable_ssh_key
  existing_private_ssh_keys = var.existing_private_ssh_keys
  use_existing_ssh_keys     = var.use_existing_ssh_keys
}
```


## Sample terraform.tfvars content
```
sftp_servers = [
  {
    name                    = "sftp-service-managed-private-sm-efs-fips"
    endpoint_type           = "VPC"
    domain                  = "EFS"
    identity_provider_type  = "SERVICE_MANAGED"
    logging_role            = "arn:aws:iam::463470957847:role/AOBPowerRoleTest"
    enable_custom_hostname  = true
    custom_hostname         = "sftptest"
    route53_zone_id         = "Z019879527OUFX2T6D4A1"
    directory_id            = ""
    enable_ssh_key          = true
    use_existing_ssh_keys   = false
    existing_private_ssh_keys = ""
    users                   = [
      {
        username       = "service-managed-user"
        role_arn       = "arn:aws:iam::463470957847:role/AOBPowerRoleTest"
        home_directory = "/service-managed-home"
        use_logical    = true
      }
    ]
  },
  {
    name                    = "sftp-directory-service-private-efs-fips-dir"
    endpoint_type           = "VPC"
    domain                  = "EFS"
    identity_provider_type  = "AWS_DIRECTORY_SERVICE"
    directory_id            = "d-9067c71152"
    logging_role            = "arn:aws:iam::807527756019:role/AOBPowerRoleTest"
    enable_custom_hostname  = false
    custom_hostname         = ""
    route53_zone_id         = ""
    enable_ssh_key          = false
    use_existing_ssh_keys   = false
    existing_private_ssh_keys = ""
    users                   = [
      {
        username       = "directory-service-user"
        role_arn       = "arn:aws:iam::807527756019:role/AOBPowerRoleTest"
        home_directory = "/directory-service-home"
        use_logical    = false
      }
    ]
  }
]

vpc_id             = "vpc-0fb01c3637f1fd29e"
subnet_ids         = ["subnet-062d74184c30c8ef8"]
security_group_ids = ["sg-05a564255438b8f5f"]
security_policy_name = "TransferSecurityPolicy-FIPS-2020-06"
```


## Notes
- If using **existing IAM roles or S3 buckets**, specify them in `existing_iam_role` and `existing_s3_bucket`.
- SSH authentication requires `enable_ssh_key = true` and optional `use_existing_ssh_keys` setup.

---
This module simplifies deploying a scalable and secure AWS SFTP solution tailored to your needs.


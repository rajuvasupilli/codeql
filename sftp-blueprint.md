# Visit http://"<TBD>.us.bank-dns.com/sd3 for the detailed yml specification

sd3-type: blueprint
# Specify the SD3 type with one of 'application', 'component' or 'blueprint'

template-version : 1.1
# Specify template version, this should not be changed by Blueprint owner

cloud-service-provider : AWS
# Specify cloud provider. Ex Azure

system-name : AWS SFTP Transfer Family
# Specify the name of the system, application or component

system-data-classification : Internal
# Specify the data classification with one of 'Public', 'Confidential', 'Internal', 'NoData' or 'Personal' - application data classifications that can consume this blueprint

system-owner : awsadmin # AWS Admin
# Specify the intranet ID of the blueprint product owner (who acts as a CEO for the blueprint and manages the product backlog for the blueprint)

engineering-owner : cloudeng # Cloud Engineering Team
# Specify the intranet ID of the blueprint engineering owner (Who builds and maintains the code for the blueprint)

operational-status: Operational
# Specify operational status with one of 'Operational', 'Under Development', 'Plan'

architecture-type : Infrastructure as a Service (IaaS)
# Specify architecture type with one of software-as-a-service, platform-as-a-service, infrastructure-as-a-service or other

lifecycle-status : Adopt
# Specify Lifecycle status of the blueprint with one of 'Assess, Trial, Adopt, Hold'
# Adopt: Enterprise should adopt these Blueprints. We use them when appropriate in our projects.

inheriting-blueprints:
  - shield-platform                           # all blueprints should have this one
  - shield-scm                                # all blueprints should have this one
  - shield-pipeline-iac                       # all IaC blueprints should have this one
  - usb-aws-foundation                        # all AWS blueprints should have this one

implementing-controls:
  - 3005 # Resource Tagging (CLAWS-82)
  - 3052 # Data In Motion Encryption (CLAWS-115)
  - 3053 # KMS Key Encryption (CLAWS-116)
  - 3115 # Public Access Policy (CLAWS-160)
  - 3237 # Security Logging (CLAWS-202)
  - 3045 # Backup Configuration Tag (CLAWS-110)

# Description
# This blueprint defines the AWS SFTP Transfer Family module, enabling secure and managed SFTP server deployments.

# Features
# - Supports authentication using AWS Directory Service or service-managed credentials.
# - Implements endpoint security with public and VPC options.
# - Enables role-based access control for users.
# - Provides secure file transfers with FIPS compliance.
# - Integrates with AWS Route 53 for custom domain mapping.
# - Supports home directory mappings and logical directory structures.
# - Enforces secure access with IAM roles and security policies.
# - Logs all user activities to CloudWatch for audit and compliance.
# - Ensures encryption for data in transit and at rest using AWS KMS.


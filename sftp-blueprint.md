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

# Overview

This blueprint outlines the implementation of an **AWS SFTP Transfer Family** module to create a secure, scalable, and managed SFTP solution based on best practices and specific requirements.

**AWS Transfer Family** enables fully managed file transfers over **SFTP, FTPS, and FTP** directly into and out of **Amazon S3 or Amazon EFS**, without the need for traditional file transfer infrastructure. It provides seamless integration with existing authentication systems, robust access controls, and high availability, making it ideal for **secure file exchange, compliance-driven workflows, and automated data processing**.

Organizations across various industries use AWS SFTP Transfer Family to securely transfer files for **financial transactions, healthcare data exchange (HIPAA compliance), media workflows, and enterprise data integrations**. The service supports both **service-managed authentication and AWS Directory Service**, offering flexibility in identity management.

With built-in **logging, encryption, and integration with AWS IAM and CloudWatch**, this solution helps meet strict **security and compliance requirements**, ensuring **reliable and secure** file transfers in cloud environments.

**Ref:** [AWS Transfer Family Documentation](https://docs.aws.amazon.com/transfer/latest/userguide/what-is.html)

# Business Function or Purpose

The primary purpose of this module is to provision a secure and highly configurable AWS SFTP Transfer Family server for managed file transfers within an AWS environment. It ensures that file transfers are encrypted, access-controlled, and logged for compliance and auditing.

This module supports **custom authentication methods**, including **AWS Directory Service and service-managed authentication**, allowing seamless integration with existing identity providers. It also enables **fine-grained access controls** using IAM roles and policies, ensuring that users can only access designated files and directories.

Additionally, this module provides a **scalable, highly available, and cost-effective** solution for organizations that need to transfer files securely without maintaining traditional file transfer infrastructure. It supports **custom domains via Route 53**, **automated logging to CloudWatch**, and **FIPS-compliant security policies**, making it ideal for regulated industries and high-security environments.

**Ref:** [AWS Transfer Family Documentation](https://docs.aws.amazon.com/transfer/latest/userguide/what-is.html)

# Assumptions

Given below are the assumptions for the SD3:

- The configuration assumes an existing AWS environment where the Terraform AWS provider is configured with the necessary permissions to create and manage SFTP Servers and their configurations.  
- It is assumed that the **identity_provider_type** is correctly specified in the `terraform.tfvars` file to avoid any confusion.  
- Additionally, it is expected that predefined **tags** will be used to facilitate easy identification and categorization of resources.

# Prerequisites
This module supports two kinds of identity provider types:
 - SERVICE_MANAGED
 - AWS_DIRECTORY_SERVICE
   
To create an SFTP Transfer Family service server integrated with AWS Directory Service, you need to meet the following prerequisites:
 - AWS Directory Service Setup
 - You must have an AWS Managed Microsoft AD or Simple AD already configured.
 - The AWS Directory Service should be in the same AWS region where you want to deploy the AWS Transfer Family server.
 - Ensure that the directory is configured with users and groups that will authenticate via SFTP.

# Limitations
Below are a few limitations that users should be aware of when creating and managing an SFTP Transfer Family service server:

- AWS Directory Service Integration
  The AWS Transfer Family service server can only be integrated with AWS Directory Service. You cannot use other identity providers for authentication unless you're using the SERVICE_MANAGED identity provider type.

- Region-Specific Service
  The AWS Transfer Family service server must be created in the same AWS region as your AWS Directory Service. It cannot be moved to another region after creation.

- User and Group Management
  The users and groups in your AWS Directory Service must be pre-configured for use in the SFTP Transfer Family service. You cannot modify the user group configuration from the AWS Transfer Family console once the server is set up.

- Limited Number of Servers per Account
  There is no hard limit on the number of AWS Transfer Family servers that can be created per AWS account, but you may run into service limits if your account exceeds other AWS service quotas.

- Server Deletion and Name Reuse
  Once an SFTP Transfer Family server is deleted, the name may not be immediately available for reuse. There may be a delay before the server name can be reassigned.

- SFTP Endpoint Configuration
  Once an endpoint is created for the server, you cannot change the endpoint type (public or VPC) after the creation. You must create a new server if you need a different endpoint type.

- Permissions Management
  AWS Transfer Family servers require the configuration of IAM roles for users to access and perform file operations. It is important to assign appropriate IAM policies for users to ensure proper access control.

- Server Performance
  The performance of the AWS Transfer Family service is primarily impacted by the underlying network and AWS Directory Service configurations. The service does not impose any specific limits on the number of simultaneous connections, but performance may degrade if the network or Directory Service is not optimally configured.

- Audit and Monitoring
  AWS Transfer Family supports logging and monitoring via CloudWatch and AWS CloudTrail. However, the level of detail for file operations might vary, and some advanced auditing features may require additional configuration.

Quotas:
The following are the service quotas for AWS Transfer Family service servers:

Name	Default	Adjustable	Description
Transfer Servers	Each supported Region: 100	Yes	The maximum number of AWS Transfer Family service servers you can create per region.
Users per Server	Each supported Server: 1000	Yes	The maximum number of users that can be associated with a single Transfer Family server.
Home Directories per User	Each supported Region: 10	Yes	The maximum number of home directories a user can have in an SFTP server.
Access Control Rules	Each supported Region: 1000	No	The maximum number of access control rules per SFTP server.
Active Transfers per User	Each supported Region: 20	No	The maximum number of concurrent file transfers allowed per user.
Public IPs per Server	Each supported Server: 1	Yes	The maximum number of public IPs that can be associated with a Transfer Family server.
VPC Endpoint per Server	Each supported Server: 1	Yes	The maximum number of VPC endpoints that can be associated with a Transfer Family server.
CloudWatch Logs Streams	Each supported Server: 5	Yes	The maximum number of CloudWatch Logs streams that can be configured per server.
Server Endpoint Types	Each supported Server: 2	No	The maximum number of endpoint types (public and VPC) supported by a Transfer Family server.
Tags per Server	Each supported Server: 50	No	The maximum number of tags that can be assigned to an AWS Transfer Family server.
Server Logging per Region	Each supported Region: 100	No	The maximum number of logging configurations per region for Transfer Family servers.
Server and User API Requests	Each supported Region: 1,000 requests per second	No	The maximum rate of API requests that can be made to a Transfer Family server.
File Size Limit	Each supported Region: 100 GB	No	The maximum size of a file that can be transferred through the SFTP service.
Transfer Speed Limit	Each supported Region: 10 Gbps	No	The maximum transfer speed for a server, limited by network conditions.
Active Sessions	Each supported Region: 1,000	Yes	The maximum number of active SFTP sessions allowed per region.
Notification Destinations	Each supported Server: 10	Yes	The maximum number of destinations for notifications per server.

For more details, you can refer to the official AWS documentation:
https://docs.aws.amazon.com/transfer/latest/userguide/limits.html





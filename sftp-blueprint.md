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

## Quotas:
The following are the service quotas for AWS Transfer Family service servers:

| **Name**                          | **Default**              | **Adjustable** | **Description**                                                                 |
|-----------------------------------|--------------------------|----------------|---------------------------------------------------------------------------------|
| **Transfer Servers**              | Each supported Region: 100 | Yes            | The maximum number of AWS Transfer Family service servers you can create per region. |
| **Users per Server**              | Each supported Server: 1000 | Yes            | The maximum number of users that can be associated with a single Transfer Family server. |
| **Home Directories per User**     | Each supported Region: 10  | Yes            | The maximum number of home directories a user can have in an SFTP server. |
| **Access Control Rules**          | Each supported Region: 1000 | No             | The maximum number of access control rules per SFTP server.                      |
| **Active Transfers per User**     | Each supported Region: 20   | No             | The maximum number of concurrent file transfers allowed per user.                |
| **Public IPs per Server**         | Each supported Server: 1    | Yes            | The maximum number of public IPs that can be associated with a Transfer Family server. |
| **VPC Endpoint per Server**       | Each supported Server: 1    | Yes            | The maximum number of VPC endpoints that can be associated with a Transfer Family server. |
| **CloudWatch Logs Streams**       | Each supported Server: 5    | Yes            | The maximum number of CloudWatch Logs streams that can be configured per server. |
| **Server Endpoint Types**         | Each supported Server: 2    | No             | The maximum number of endpoint types (public and VPC) supported by a Transfer Family server. |
| **Tags per Server**               | Each supported Server: 50   | No             | The maximum number of tags that can be assigned to an AWS Transfer Family server. |
| **Server Logging per Region**     | Each supported Region: 100  | No             | The maximum number of logging configurations per region for Transfer Family servers. |
| **Server and User API Requests**  | Each supported Region: 1,000 requests per second | No | The maximum rate of API requests that can be made to a Transfer Family server. |
| **File Size Limit**               | Each supported Region: 100 GB | No             | The maximum size of a file that can be transferred through the SFTP service. |
| **Transfer Speed Limit**          | Each supported Region: 10 Gbps | No             | The maximum transfer speed for a server, limited by network conditions. |
| **Active Sessions**               | Each supported Region: 1,000 | Yes            | The maximum number of active SFTP sessions allowed per region. |
| **Notification Destinations**     | Each supported Server: 10   | Yes            | The maximum number of destinations for notifications per server. |

---

For more details, you can refer to the official AWS documentation:

- [AWS Transfer Family Service Quotas](https://docs.aws.amazon.com/transfer/latest/userguide/limits.html)

# SFTP Transfer Service Servers

## 6.3.1 Infrastructure as a Service

### Technology Architecture

Amazon SFTP Transfer Service provides the following features.

The AWS Transfer Family allows you to transfer files directly into and out of Amazon S3 using the SFTP, FTP, and FTPS protocols. The service supports securely transferring data between an on-premises environment or an application and Amazon S3. It simplifies the migration process, providing full integration with Amazon S3, and allows users to use AWS Identity and Access Management (IAM) for access control.

### SFTP Transfer Service provides various features, some of which are mentioned below:

#### Managed SFTP Service
Amazon SFTP Transfer Service offers a fully managed SFTP solution where AWS takes care of all infrastructure, maintenance, and scaling. You don't need to provision and manage servers for handling file transfers.

#### Protocol Support
The service supports the following protocols:
- **SFTP (Secure File Transfer Protocol)**: Standard file transfer protocol over SSH, providing secure encryption of the data in transit.
- **FTP (File Transfer Protocol)**: Standard file transfer protocol, though it is not secure and should be used in trusted environments.
- **FTPS (FTP Secure)**: FTP protocol wrapped with TLS/SSL encryption.

#### Integration with Amazon S3
Files transferred via SFTP can be directly stored in an Amazon S3 bucket. This integration simplifies the process of storing files securely and with high availability, offering several features that can be used with S3 buckets, such as lifecycle management, encryption, and versioning.

#### Authentication and Access Control
- **AWS Identity and Access Management (IAM)**: You can manage and control access to your SFTP servers using IAM policies. You can create roles and assign specific access rights to users.
- **Directory Integration**: The service supports integrating with AWS Directory Service or an existing Active Directory, allowing you to manage users from a central location.
- **Public Key Authentication**: You can set up SSH keys for secure, passwordless login.

#### High Availability and Scaling
AWS SFTP Transfer Service is designed for high availability. It scales automatically based on the number of users and requests. The service ensures that you have a reliable solution for handling file transfers in a scalable and cost-effective manner.

### Access Management and Security
- **Data Encryption**: The service provides end-to-end encryption both in transit and at rest. Data is encrypted during transfer using SFTP, and at rest, it is encrypted using AWS S3's encryption options (e.g., AES-256, SSE-KMS).
- **Server Authentication**: The servers themselves can be authenticated using keys or password-based authentication, and client connections can also be secured using certificates.
- **Logging**: Detailed logs for user actions are generated for auditing purposes. You can monitor activities, such as file uploads, downloads, and authentication events, using AWS CloudTrail or AWS CloudWatch.

### Data Processing
- **Event Notifications**: You can trigger Amazon SNS, Amazon SQS, or AWS Lambda functions whenever a file is uploaded or downloaded, enabling automated workflows based on file events.
- **Lambda Integration**: You can run AWS Lambda functions when files are transferred to Amazon S3, enabling custom processing tasks such as data transformation, validation, or triggering downstream processes.

### Storage Logging and Monitoring
- **Amazon CloudWatch**: You can monitor and visualize file transfer operations using Amazon CloudWatch metrics and logs.
- **AWS CloudTrail**: CloudTrail records the API calls made to the SFTP service for auditing and monitoring purposes.
- **Server Logs**: SFTP logs are available to track file access, authentication, and transfer activities.

### Analytics and Insights
- **Amazon S3 Inventory**: You can use S3 Inventory reports to track the file metadata stored in your SFTP server’s destination S3 bucket, helping you track usage and organize data efficiently.
- **S3 Analytics**: Use S3 Analytics to gain insights into your storage access patterns, helping you decide when to move data to more cost-effective storage classes.

### Strong Consistency
Amazon SFTP Transfer Service guarantees strong consistency for all file upload and download operations, ensuring that once a file is uploaded, it is immediately available for access. This behavior applies to both new files and updates to existing files.

For more information, refer to the [AWS SFTP Transfer Service Documentation](https://aws.amazon.com/sftp/).

# Deployment Architecture

Link to the module described here can be found in the Modules and Automation section, below.
The module `module-transfer-sftp` can create AWS SFTP Transfer Service instances.
The resource SFTP Transfer Service will be created in the specified AWS region and will have the following features depending on the inputs provided to the module.

### Features:

- **Access Controls**: Utilize IAM roles and policies to restrict access to the SFTP service, ensuring that only authorized users and services can interact with the SFTP servers.
- **Encryption**: Leverage AWS KMS for server-side encryption of data at rest. Data transferred via SFTP will also be encrypted in transit.
- **Logging**: Enable logging of user activity and file transfer operations via CloudTrail and CloudWatch for auditing and monitoring purposes.
- **Directory Integration**: Integrate the service with AWS Directory Service or an existing Active Directory for centralized user authentication and management.
- **Key Management**: Use SSH keys for secure, passwordless login for SFTP users.

### Recommendations:

- **Cost Optimization**: Regularly review and adjust the SFTP Transfer Service configuration to optimize costs, considering factors such as the number of active users, transfer volume, and storage used in Amazon S3.
- **Security Best Practices**: Use IAM policies to enforce the principle of least privilege and manage user access securely. Periodically rotate SSH keys and enforce strong authentication methods for users.

For more information, refer to the [AWS Transfer Family Documentation](https://docs.aws.amazon.com/transfer/latest/userguide/Welcome.html).

# Connectivity Architecture

## SFTP Transfer Service
The SFTP Transfer Service allows secure file transfer over the network using the SFTP (Secure File Transfer Protocol) protocol. This service ensures the confidentiality and integrity of your data during transmission by encrypting data over the network. The service can be accessed programmatically using SFTP client libraries or through automated scripts.

### Key Notes:
- **Encryption:** All file transfers over the SFTP server are encrypted to ensure data security.
- **Unique Server Name:** Each SFTP server must have a unique name to avoid conflicts and ensure smooth operation.
- **Public Access:** By default, public access to the SFTP server is restricted. This ensures that only authorized users can connect to the server.
- **Access Control:** The SFTP server uses ACLs (Access Control Lists) to define and control permissions for the files and directories.

## Endpoints for SFTP
To connect programmatically to an SFTP service, you can use SFTP client tools that provide an endpoint to the server. The endpoint structure typically follows the `hostname:port` format, where `hostname` is the SFTP server's address, and `port` is the communication port (usually port 22 for SFTP).

### Note:
- The SFTP server supports the standard SFTP protocol and can be configured to use different authentication methods like password-based or key-based authentication.

## Failover and DR Architecture (Business Continuity & Disaster Recovery)

The SFTP Transfer Service utilizes a highly available architecture to ensure continuous operation. It can be deployed across multiple availability zones to provide fault tolerance and automatic failover capabilities.

- **SFTP Redundancy:** The system is designed to handle automatic failover in case of a server failure. Data transfer is redirected to a backup SFTP server.
- **Cross-region Replication:** Data can be replicated across geographically separated locations for enhanced resilience.
- **Backup & Recovery:** Regular backups of transferred files and configuration settings are stored to provide a reliable disaster recovery mechanism in case of failures.

### Note:
- The disaster recovery (DR) setup ensures that even in case of a regional outage, the files can be recovered from replicated SFTP servers.

## Observability

### Monitoring and Logging
To maintain the reliability, availability, and performance of the SFTP Transfer Service, it's essential to monitor the system continuously. Various monitoring tools can be used to collect and analyze logs.

1. **Automated Monitoring Tools:**
   - **SFTP Health Checks:** The system provides health check endpoints that can be monitored using tools like **Amazon CloudWatch** to ensure SFTP service uptime.
   - **Error Logging:** All errors during file transfer, authentication failures, and other issues are logged for troubleshooting and auditing purposes.

2. **Logging Options:**
   - **SFTP Logs:** The system logs all SFTP operations, including file uploads, downloads, authentication attempts, and errors.
   - **Audit Trails:** Detailed logs are maintained for auditing file access and transfers. These logs are stored securely and can be queried using built-in tools.

### Logging Options:
- **Access Logs:** Logs of all SFTP connections and file operations.
- **Error Logs:** Logs of failed file transfers, authentication issues, and service downtime.
- **Audit Logs:** Detailed records of file transfer operations for compliance and auditing purposes.

### Logging and Monitoring for Compliance:
- **Compliance Logging:** The service provides the ability to configure logging to meet specific compliance requirements, such as GDPR or HIPAA.
- **Log Storage:** Logs are stored securely, and you can configure retention policies for data compliance.

## Performance and Cost

### Performance Considerations:
- The SFTP server is designed to handle high volumes of data transfers with low latency.
- **Throughput:** The service supports high-throughput file transfers, making it suitable for both small and large-scale operations.

### Cost Considerations:
- **Data Transfer Costs:** Transferred data is subject to network charges depending on the region and data volume.
- **Storage Costs:** Transferred files may incur storage costs depending on how long they are retained on the server.

## Security Best Practices

### Key Security Measures:
- **SSH Key Authentication:** Strong SSH key-based authentication should be used for all SFTP connections to enhance security.
- **Encryption:** All files transferred are encrypted using strong encryption standards like AES-256.
- **Access Control:** Use granular access control settings to restrict access to files based on user roles.
- **Auditing:** Regular audits of access logs and transfer logs to ensure compliance with security policies.

### Additional Features:
- **Two-Factor Authentication:** Optional two-factor authentication for added security when accessing the SFTP service.
- **IP Whitelisting:** Restrict access to the SFTP server by allowing only specific IP addresses to connect.

# SFTP Transfer Service Server

## System Components and Boundaries

The **SFTP Transfer Service** allows the secure transfer of files over the network using the SFTP protocol. It involves a server, typically a dedicated machine or service, that manages file transfers. The SFTP server is configured to ensure secure and encrypted connections for transferring files between clients and the server.

### Key Notes:
- **SFTP Server:** The server that accepts SFTP connections from clients for file uploads or downloads.
- **File Integrity:** SFTP ensures the confidentiality and integrity of files during transmission.
- **Access Control:** Access to the SFTP server is controlled using authentication mechanisms like SSH keys or passwords.

---

## SFTP Server

The **SFTP server** acts as the core component in the SFTP Transfer Service. It provides a centralized location for secure file transfers. Files are stored in directories within the server, and access to them is managed by the server’s authentication system.

### Key Components:
- **Directory Structure:** SFTP servers organize files into directories. Each directory can have different permissions for users to read, write, or execute files.
- **Authentication Methods:** Users can authenticate to the SFTP server using methods such as **SSH keys**, **passwords**, or **multi-factor authentication (MFA)**.
- **Logging and Monitoring:** The server logs all access attempts, file transfers, and errors to provide insights into the system's usage and health.

### Access Control

The SFTP server provides various access control mechanisms to define who can access specific directories or files. These include:

- **User Permissions:** Control over what users can do within their directories, such as reading, writing, or executing files.
- **Group Permissions:** Files can be shared between users within the same group, with permissions defined at the group level.
- **ACLs (Access Control Lists):** Fine-grained access control can be implemented using ACLs to specify which users or groups have access to specific files or directories.

---

## Files

Files are the primary objects within the SFTP server and can be transferred securely over the network using the SFTP protocol. Each file in the server is stored within a specific directory and can be identified by its unique path in the directory tree.

### Key Attributes:
- **File Path:** The unique path (including the file name) used to locate a file on the SFTP server.
- **File Permissions:** Files have read, write, and execute permissions that define what actions users can take on the file.

---

## Encryption and Security

The **SFTP protocol** inherently encrypts data during transfer to ensure that sensitive data remains secure. The SFTP server can also be configured with additional security measures:

- **SSH Key-based Authentication:** Provides a more secure authentication method than passwords.
- **File Integrity Checks:** Ensures that files transferred to and from the server are not altered during transmission.
- **Encrypted Storage:** Files may be stored in encrypted format to ensure data protection while at rest.

---

## SFTP Versioning (Optional)

Some SFTP servers may offer versioning capabilities, which allow maintaining multiple versions of a file within the same directory. This feature is useful for recovering older versions of files that may have been accidentally overwritten or deleted.

- **Versioning Enabled:** The server stores different versions of a file and assigns a unique identifier to each version.
- **Version ID:** A version ID is associated with each file to uniquely identify it among other versions.

---

## Server Policies

Server policies are used to enforce security and operational best practices. Policies can be set to control aspects like authentication methods, access controls, and file retention. Policies are defined by the server administrator and applied at the server or directory level.

- **File Retention Policies:** Define how long files are kept on the server before they are automatically archived or deleted.
- **Access Control Policies:** Define what type of access is granted to users or groups and for which directories or files.

---

## Directory Structure

The directory structure on the SFTP server organizes the files and defines access control boundaries. Each user is typically granted access to a specific directory or set of directories.

- **Home Directory:** Each user has a home directory where they can upload or download files.
- **Shared Directories:** Directories can be shared among users or groups, with different levels of permissions (read, write, execute).

---

## Access Control Lists (ACLs)

The SFTP server may support **Access Control Lists (ACLs)** to grant fine-grained control over file and directory access.

- **ACL for Files:** ACLs are used to specify which users or groups can access a particular file and what actions they can perform (e.g., read, write, or execute).
- **Default ACLs:** Default ACLs can be applied to new files and directories, ensuring consistent access control for all items.

---

## Regions (Geographic Location)

The SFTP server can be hosted in different geographical locations depending on the provider or on-premises infrastructure. Choosing the right region can optimize latency, ensure compliance with data residency regulations, and meet performance requirements.

- **Regional Hosting:** Select a region to host your SFTP server to optimize file transfer speeds and meet regulatory compliance for data storage.
- **Data Residency:** Ensure that files stored in the SFTP server remain within the region of choice, ensuring compliance with data protection laws.

---

# Application Architecture

Create a base Terraform module to deploy an **SFTP Transfer Service Server** with configurable options for server access, authentication methods, file storage, logging, encryption, and network access controls. This module includes advanced security measures such as enforcing encryption for file transfers, restricting public access, enabling key-based SSH authentication, and supporting automated tagging for resource identification.

## Application Dependencies

- **SSH Key Pair:** Required for secure SSH-based authentication to the SFTP server.
- **Encryption Key:** Required for server-side encryption of files stored on the server.

---

# Data Flow Diagram

Refer to the following diagram for this description.
An **SFTP Transfer Service Server** stores data as files within directories. A directory is a container for files, and files are identified by their unique path and file name. To transfer data securely, clients connect to the SFTP server using the SFTP protocol, which operates over an encrypted SSH channel.

The data flow includes:

1. **Client Upload:** Clients upload files securely to the SFTP server. The file is stored in a designated directory on the server.
2. **File Access:** Files are accessed by clients or administrators based on the access controls configured for the specific directory.
3. **Encryption:** Files are encrypted at rest on the SFTP server using an encryption key. This ensures that files remain secure even when stored.
4. **Access Control:** Access to files is controlled using SSH key-based authentication, user-specific directories, and defined permissions (read, write, execute).

The SFTP service provides features that can be configured to suit your specific needs. For example, access control is managed by configuring user-specific access rights for directories. Additionally, encryption ensures that file transfers and stored data are always protected.

---

# Ports, Protocols, and Service

The **SFTP Transfer Service Server** operates using the SSH protocol for secure file transfers. The communication occurs over an encrypted channel, ensuring data security.

- **Protocol:** SFTP (Secure File Transfer Protocol) over SSH.
- **Port:** The default port used by SFTP servers is **22**, which is the standard port for SSH connections.
- **Encryption:** Files are encrypted during transfer using SSH encryption mechanisms. Additionally, the files can be encrypted at rest on the server using an encryption key.

### Communication Flow:
- **Port 22:** For SFTP and SSH-based communication
- **Protocol:** SFTP over SSH (uses standard SSH encryption)
- **Encryption:** Data encryption during transmission, optional encryption for data at rest

Ref: [SFTP Protocol Overview](https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol)



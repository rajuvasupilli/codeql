Overview

This blueprint outlines the implementation of an Amazon S3 bucket module to create highly scalable and durable storage solutions based on best practices and specific requirements.
Amazon Simple Storage Service (Amazon S3) is an object storage service that offers industry-leading scalability, data availability, security, and performance. Customers of all sizes and industries can use Amazon S3 to store and protect any amount of data for a range of use cases, such as data lakes, websites, mobile applications, backup and restore, archive, enterprise applications, IoT devices, and big data analytics. Amazon S3 provides management features so that you can optimize, organize, and configure access to your data to meet your specific business, organizational, and compliance requirements.
Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html

Business Function or Purpose



The primary purpose of this module is to create a secure and configurable S3 bucket that can be used for various data storage and retrieval operations with an AWS environment. It ensures that the bucket and its contents are private.


It supports dynamic naming and tagging coventions, leveraging AWS account ID, region, and user-defined suffixes to generate unique bucket names.


This module provides a comprehensive solution for creating and managing an AWS S3 bucket with robust security and data management features. It supports server-side encryption, access logging, versioning, lifecycle rules, and access control, making it a powerful tool for maintaining S3 buckets in compliance with and organizational policies.


Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html

Assumptions

Given below are the assumptions for the SD3:

The configuration assumes an exsisting AWS environment where the Terraform AWS provider is configured with the neccessary permissions to create and manage S3 buckets and their configurations.
It is assumed that the bucket names provided will be unique to avoid naming conflicts. Additionally, it is expected that predefined tags will be used to facilitate easy identification and categorization of resources.


Pre-requisites

Following are the minimum pre-requisites for provisioning S3 Bucket:

Bucket Logging:

This Module supports two kinds of storing of the logs.

Store logs in a Centralized Bucket: The server access logs will be stored within the centralized bucket if the value of the variable enable_server_access_logs is set to true, so the centralized bucket should be already present.
Store logs in the Same Bucket: The server access logs will be stored within the same bucket that is being created if the value of the variable enable_server_access_logs is set to false. No Pre-requisites are required for this configuration.


KMS Encryption:


The "S3" KMS key should have been created at the onboarding time and its ARN should be in "s3_encryption_key_arn" SSM parameter in the region. (This key will be used for encryption of the S3 bucket).

Ref: https://confluence.us.bank-dns.com/pages/viewpage.action?spaceKey=CLOUDSEC&title=User+Guide+-+Key+Management+Automation

Limitations

Below are few limitations that users should be aware of:


An Amazon S3 bucket is owned by the AWS account that created it. Bucket ownership is not transferable to another account.


When you create a bucket, you choose its name and the AWS Region to create it in. After you create a bucket, you can't change its name or Region.


When naming a bucket, choose a name that is relevant to you or your business. Avoid using names associated with others. For example, you should avoid using AWS or Amazon in your bucket name.


By default, you can create up to 100 buckets in each of your AWS accounts. If you need additional buckets, you can increase your account bucket quota to a maximum of 1,000 (hard limit) buckets by submitting a quota increase request. There is no difference in performance whether you use many buckets or just a few.


If a bucket is empty, you can delete it. After a bucket is deleted, the name becomes available for reuse. However, after you delete the bucket, you might not be able to reuse the name for various reasons.


There is no max bucket size or limit to the number of objects that you can store in a bucket. You can store all of your objects in a single bucket, or you can organize them across several buckets. However, you can't create a bucket from within another bucket.


The high availability engineering of Amazon S3 is focused on get, put, list, and delete operations. Because bucket operations work against a centralized, global resource space, it is not recommended to create, delete, or configure buckets on the high availability code path of your application. It's better to create, delete, or configure buckets in a separate initialization or setup routine that you run less often.


If your application automatically creates buckets, choose a bucket naming scheme that is unlikely to cause naming conflicts. Ensure that your application logic will choose a different bucket name if a bucket name is already taken.


Quotas:
The following are the service quotas for Amazon S3:



Name
Default
Adjustable
Description




Access Points
Each supported Region: 10,000
Yes
The number of Amazon S3 Access Points that you can create per region in an account


Bucket policy
Each supported Region: 20 Kilobytes
No
The maximum size (in KB) of a bucket policy for an Amazon S3 bucket


Bucket tags
Each supported Region: 50
No
The maximum number of tags you can assign to an Amazon S3 bucket


Directory buckets
Each supported Region: 10
Yes
The number of Amazon S3 directory buckets that you can create in an account


Event notifications
Each supported Region: 100
No
The maximum number of event notifications per Amazon S3 bucket


General purpose buckets
Each supported Region: 100
Yes
The number of Amazon S3 general purpose buckets that you can create in an account


Lifecycle rules
Each supported Region: 1,000
No
The maximum number of rules you can specify for an Amazon S3 lifecycle configuration


Maximum part size
Each supported Region: 5 Gigabytes
No
The maximum size (in GB) of an Amazon S3 object part in a Multipart upload using the API


Minimum part size
Each supported Region: 5 Megabytes
No
The minimum size (in MB) of an Amazon S3 object part in a Multipart upload using the API. The last part uploaded can be less than the stated minimum


Multi-Region Access Point Regions
Each supported Region: 20
No
Maximum Regions per Multi-Region Access Point.


Multi-Region Access Points
Each supported Region: 100
No
Multi-Region Access Points per Account.


Object size
Each supported Region: 5 Terabytes
No
The maximum size (in TB) of an Amazon S3 object


Object size (Console upload)
Each supported Region: 160 Gigabytes
No
The maximum size (in GB) of an Amazon S3 object that you can upload using the console


Object tags
Each supported Region: 10
No
The maximum number of tags you can assign to an Amazon S3 object


Parts
Each supported Region: 10,000
Yes
The maximum number of Amazon S3 object parts per Multipart upload


Replication Destinations
Each supported Region: 28
Yes
The number of destination S3 buckets you can add for each source S3 bucket across all replication rules.


Replication rules
Each supported Region: 10,000
No
The maximum number of rules you can specify in an Amazon S3 Replication configuration


Replication transfer rate
Each supported Region: 1 Gigabits per second
Yes
The maximum Replication Time Control transfer rate that you can replicate from the source region in this account.


S3 Glacier: Number of random restore requests
Each supported Region: 35
No
The number of random restore requests from S3 Glacier storage class per PiB stored per day.


S3 Glacier: Provisioned capacity units
Each supported Region: 2
No
The maximum number of S3 Glacier storage class provisioned capacity units available to purchase per account.


S3 Glacier: Retrieval request rate per second.
Each supported Region: 1,000
No
The maximum number of retrieval requests per second allowed per account.



Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/BucketRestrictions.html,
https://docs.aws.amazon.com/general/latest/gr/s3.html

High Level Description of Capabilities
Listed below are the capabilities of S3 Bucket:


S3 features include capabilities to append metadata tags to objects, move and store data across the S3 Storage Classes, configure and enforce data access controls, secure data against unauthorized users, run big data analytics, and monitor data at the object and bucket levels.


Amazon S3 provides the most durable storage in the cloud. Based on its unique architecture, S3 is designed to exceed 99.999999999% (11 nines) data durability (depending upon the storage class).


S3 includes lifecycle management, enabling automatic transition of objects between storage classes or deletion after a specified period. S3 also supports versioning to keep multiple versions of an object in the same bucket, protecting against accidental deletion and providing a history of changes.


Security features in S3 includes server-side encryption using AWS Key Management Service (SSE-KMS), and customer-provided keys/S3-managed keys (SSE-C), along with client-side encryption.


It offers fine-grained access control through bucket policies, AWS Identity and Access Management (IAM) policies, and Access Control Lists (ACLs).


S3 Integrates seamlessly with other AWS services, offering event notifications to AWS Lambda, Amazon SQS, Amazon SNS or AWS Code Pipelines when objects are created, updated, or deleted.


Ref: https://aws.amazon.com/s3/features/#Product_comparisons,
https://aws.amazon.com/s3/storage-classes/



Ref. ID
Capability Name




6.3.1
Infrastructure as a Service




Technology Architecture

Amazon S3 provides the following features.
Amazon Simple Storage Service (Amazon S3) is an object storage service that offers industry-leading scalability, data availability, security, and performance.
Customers of all sizes and industries can use Amazon S3 to store and protect any amount of data for a range of use cases, such as data lakes, websites, mobile applications, backup and restore, archive, enterprise applications, IoT devices, and big data analytics. Amazon S3 provides management features so that you can optimize, organize, and configure access to your data to meet your specific business, organizational, and compliance requirements.


S3 provides various features, some of which are mentioned below:


Storage classes
Amazon S3 offers a range of storage classes designed for different use cases. For example, you can store mission-critical production data in S3 Standard or S3 Express One Zone for frequent access, save costs by storing infrequently accessed data in S3 Standard-IA or S3 One Zone-IA, and archive data at the lowest costs in S3 Glacier Instant Retrieval, S3 Glacier Flexible Retrieval, and S3 Glacier Deep Archive.
Amazon S3 Express One Zone is a high-performance, single-zone Amazon S3 storage class that is purpose-built to deliver consistent, single-digit millisecond data access for your most latency-sensitive applications. S3 Express One Zone is the lowest latency cloud object storage class available today, with data access speeds up to 10x faster and with request costs 50 percent lower than S3 Standard. S3 Express One Zone is the first S3 storage class where you can select a single Availability Zone with the option to co-locate your object storage with your compute resources, which provides the highest possible access speed. Additionally, to further increase access speed and support hundreds of thousands of requests per second, data is stored in a new bucket type: an Amazon S3 directory bucket.
You can store data with changing or unknown access patterns in S3 Intelligent-Tiering, which optimizes storage costs by automatically moving your data between four access tiers when your access patterns change. These four access tiers include two low-latency access tiers optimized for frequent and infrequent access, and two opt-in archive access tiers designed for asynchronous access for rarely accessed data.


Storage management
Amazon S3 has storage management features that you can use to manage costs, meet regulatory requirements, reduce latency, and save multiple distinct copies of your data for compliance requirements.
S3 Lifecycle – Configure a lifecycle configuration to manage your objects and store them cost effectively throughout their lifecycle. You can transition objects to other S3 storage classes or expire objects that reach the end of their lifetimes. In life cycle you can constraint in how many days the objects needs to be transferred to which storage class like STANDARD_IA or GLACIER and you can create it required based on the input variables.
S3 Object Lock – Prevent Amazon S3 objects from being deleted or overwritten for a fixed amount of time or indefinitely. You can use Object Lock to help meet regulatory requirements that require write-once-read-many (WORM) storage or to simply add another layer of protection against object changes and deletions.
S3 Replication – Replicate objects and their respective metadata and object tags to one or more destination buckets in the same or different AWS Regions for reduced latency, compliance, security, and other use cases.
S3 Batch Operations – Manage billions of objects at scale with a single S3 API request or a few clicks in the Amazon S3 console. You can use Batch Operations to perform operations such as Copy, Invoke AWS Lambda function, and Restore on millions or billions of objects.


Access management and security
Amazon S3 provides features for auditing and managing access to your buckets and objects. By default, S3 buckets and the objects in them are private. You have access only to the S3 resources that you create. To grant granular resource permissions that support your specific use case or to audit the permissions of your Amazon S3 resources, you can use the following features.
S3 Block Public Access – Block public access to S3 buckets and objects. By default, Block Public Access settings are turned on at the bucket level. We recommend that you keep all Block Public Access settings enabled unless you know that you need to turn off one or more of them for your specific use case.
AWS Identity and Access Management (IAM) – IAM is a web service that helps you securely control access to AWS resources, including your Amazon S3 resources. With IAM, you can centrally manage permissions that control which AWS resources users can access. You use IAM to control who is authenticated (signed in) and authorized (has permissions) to use resources.
Bucket policies – Use IAM-based policy language to configure resource-based permissions for your S3 buckets and the objects in them.
Amazon S3 access points – Configure named network endpoints with dedicated access policies to manage data access at scale for shared datasets in Amazon S3.
Access control lists (ACLs) – Grant read and write permissions for individual buckets and objects to authorized users. As a general rule, we recommend using S3 resource-based policies (bucket policies and access point policies) or IAM user policies for access control instead of ACLs. Policies are a simplified and more flexible access control option. With bucket policies and access point policies, you can define rules that apply broadly across all requests to your Amazon S3 resources.
S3 Object Ownership – Take ownership of every object in your bucket, simplifying access management for data stored in Amazon S3. S3 Object Ownership is an Amazon S3 bucket-level setting that you can use to disable or enable ACLs. By default, ACLs are disabled. With ACLs disabled, the bucket owner owns all the objects in the bucket and manages access to data exclusively by using access-management policies.
IAM Access Analyzer for S3 – Evaluate and monitor your S3 bucket access policies, ensuring that the policies provide only the intended access to your S3 resources.


Data processing
To transform data and trigger workflows to automate a variety of other processing activities at scale, you can use the following features.
S3 Object Lambda – Add your own code to S3 GET, HEAD, and LIST requests to modify and process data as it is returned to an application. Filter rows, dynamically resize images, redact confidential data, and much more.
Event notifications – Trigger workflows that use Amazon Simple Notification Service (Amazon SNS), Amazon Simple Queue Service (Amazon SQS), and AWS Lambda when a change is made to your S3 resources.


Storage logging and monitoring
Amazon S3 provides logging and monitoring tools that you can use to monitor and control how your Amazon S3 resources are being used. For more information, see Monitoring tools.
Automated monitoring tools:
Amazon CloudWatch metrics for Amazon S3 – Track the operational health of your S3 resources and configure billing alerts when estimated charges reach a user-defined threshold.
AWS CloudTrail – Record actions taken by a user, a role, or an AWS service in Amazon S3. CloudTrail logs provide you with detailed API tracking for S3 bucket-level and object-level operations.
Manual monitoring tools:
Server access logging – Get detailed records for the requests that are made to a bucket. You can use server access logs for many use cases, such as conducting security and access audits, learning about your customer base, and understanding your Amazon S3 bill.
AWS Trusted Advisor – Evaluate your account by using AWS best practice checks to identify ways to optimize your AWS infrastructure, improve security and performance, reduce costs, and monitor service quotas. You can then follow the recommendations to optimize your services and resources.


Analytics and insights
Amazon S3 offers features to help you gain visibility into your storage usage, which empowers you to better understand, analyze, and optimize your storage at scale.
Amazon S3 Storage Lens – Understand, analyze, and optimize your storage. S3 Storage Lens provides 60+ usage and activity metrics and interactive dashboards to aggregate data for your entire organization, specific accounts, AWS Regions, buckets, or prefixes.
Storage Class Analysis – Analyze storage access patterns to decide when it's time to move data to a more cost-effective storage class.
S3 Inventory with Inventory reports – Audit and report on objects and their corresponding metadata and configure other Amazon S3 features to take action in Inventory reports. For example, you can report on the replication and encryption status of your objects. For a list of all the metadata available for each object in Inventory reports, see Amazon S3 Inventory list.


Strong consistency
Amazon S3 provides strong read-after-write consistency for PUT and DELETE requests of objects in your Amazon S3 bucket in all AWS Regions. This behavior applies to both writes of new objects as well as PUT requests that overwrite existing objects and DELETE requests. In addition, read operations on Amazon S3 Select, Amazon S3 access control lists (ACLs), Amazon S3 Object Tags, and object metadata (for example, the HEAD object) are strongly consistent.




Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html#S3Features

Deployment Architecture

Link to the module described here can be found in the Modules and Automation section, below.
Module module-storage-s3bucket can create S3 Buckets.
The resource S3 bucket will be created in the given AWS region and the S3 bucket will have the following features depending upon the inputs provided to the module.

Access Controls: Utilize IAM roles and policies to restrict access to the S3 bucket, ensuring only authorized users and services can interact with it.
Encryption: Leverage AWS KMS for server-side encryption to protect data at rest.
Logging: Enable Server access logging.
Lifecycle Management: Configure lifecycle policies to automatically delete expired objects, reducing storage costs and maintaining clean buckets.

Recommendation:


Cost Optimization: Regularly review and adjust the S3 bucket configuration to optimize costs, considering factors like storage classes, transfer acceleration, and cross-region replication.



Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html

Connectivity Architecture
Amazon S3 REST API You can use the Amazon S3 REST API to write your own programs and access buckets programatically. Amazon S3 supports an API architecture in which your buckets and objects are resources, each with a resource URI that uniquely identifies the resource.
Note:


S3 encryption is mandatory in the USBank, so for reading the bucket content, you need read and de-encrypt access to the key.


Bucket name must be unique within the global namespace and follow the bucket naming rules.


Public access is disabled and which is configured in this module.


This module uses the ACLs(access control lists) in S3 to manage and control access permissions for the specified bucket.


Endpoints of S3
To connect programatically to an AWS service, you use an endpoint. AWS provides s3 regular endpoints. In the design of the Shared VPC module, S3 Gateway endpoint and S3 Interface endpoint has been deployed for avoiding leaving of traffic from the vpc and hitting the regular endpoints:
Ref: https://docs.aws.amazon.com/general/latest/gr/s3.html

Failover and DR Architecture (Business Continuity & Disaster Recovery)
The AWS global infrastructure is built around Regions and Availability Zones. AWS Regions provide multiple, physically separated and isolated Availability Zones that are connected with low latency, high throughput, and highly redundant networking. These Availability Zones offer you an effective way to design and operate applications and databases. They are more highly available, fault tolerant, and scalable than traditional single data center infrastructures or multi-data center infrastructures. If you specifically need to replicate your data over greater geographic distances, you can use Replicating objects, which enables automatic, asynchronous copying of objects across buckets in different AWS Regions.
Each AWS Region has multiple Availability Zones. You can deploy your applications across multiple Availability Zones in the same Region for fault tolerance and low latency. Availability Zones are connected to each other with fast, private fiber-optic networking, enabling you to easily architect applications that automatically fail over between Availability Zones without interruption.
In addition to the AWS global infrastructure, Amazon S3 offers several features to help support your data resiliency and backup needs.
Lifecycle configuration
A lifecycle configuration is a set of rules that define actions that Amazon S3 applies to a group of objects. With lifecycle configuration rules, you can tell Amazon S3 to transition objects to less expensive storage classes, archive them, or delete them. In transition you can make the objects to move to other storage classes like STANDARD_IA or GLACIER based on the days of objects stored in S3.
Note: This module supports the above mentioned feature.
Versioning
Versioning is a means of keeping multiple variants of an object in the same bucket. You can use versioning to preserve, retrieve, and restore every version of every object stored in your Amazon S3 bucket. With versioning, you can easily recover from both unintended user actions and application failures.
Note: This module supports the above mentioned feature.
S3 Object Lock
You can use S3 Object Lock to store objects using a write once, read many (WORM) model. Using S3 Object Lock, you can prevent an object from being deleted or overwritten for a fixed amount of time or indefinitely. S3 Object Lock enables you to meet regulatory requirements that require WORM storage or simply to add an additional layer of protection against object changes and deletion.
Note: This module supports the above mentioned feature.
Storage classes
Amazon S3 offers a range of storage classes to choose from depending on the requirements of your workload. The S3 Standard-IA and S3 One Zone-IA storage classes are designed for data you access about once a month and need milliseconds access. The S3 Glacier Instant Retrieval storage class is designed for long-lived archive data accessed with milliseconds access that you access about once a quarter. For archive data that does not require immediate access, such as backups, you can use the S3 Glacier Flexible Retrieval or S3 Glacier Deep Archive storage classes. Our S3 module specifically supports transitioning objects to S3 Standard-IA and S3 Glacier based on the specified lifecycle rules.
Note: This module supports the above mentioned feature.
The following security best practices also address resilience:

Enable versioning
Consider Amazon S3 cross-region replication
Identify and audit all your Amazon S3 buckets

Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/disaster-recovery-resiliency.html,
https://disaster-recovery.workshop.aws/en/services/storage/s3.html

Observability

Monitoring is an important part of maintaining the reliability, availability, and performance of Amazon S3 and your AWS solutions. We recommend collecting monitoring data from all of the parts of your AWS solution so that you can more easily debug a multipoint failure if one occurs.
The following features can be used to logging and monitoring in Amazon S3.
1. Monitoring tools:
AWS provides various tools that you can use to monitor Amazon S3. You can configure some of these tools to do the monitoring for you, while some of the tools require manual intervention. We recommend that you automate monitoring tasks as much as possible.

Automated monitoring tools:
You can use the following automated monitoring tools to watch Amazon S3 and report when something is wrong:


Amazon CloudWatch Alarms – Watch a single metric over a time period that you specify, and perform one or more actions based on the value of the metric relative to a given threshold over a number of time periods. The action is a notification sent to an Amazon Simple Notification Service (Amazon SNS) topic or Amazon EC2 Auto Scaling policy. CloudWatch alarms do not invoke actions simply because they are in a particular state. The state must have changed and been maintained for a specified number of periods.


AWS CloudTrail Log Monitoring – Share log files between accounts, monitor CloudTrail log files in real time by sending them to CloudWatch Logs, write log processing applications in Java, and validate that your log files have not changed after delivery by CloudTrail.


Note: Automated monitoring tools are not configured in this module.

2. Logging options for Amazon S3:
You can record the actions that are taken by users, roles, or AWS services on Amazon S3 resources and maintain log records for auditing and compliance purposes. To do this, you can use server-access logging, AWS CloudTrail logging, or a combination of both. We recommend that you use CloudTrail for logging bucket-level and object-level actions for your Amazon S3 resources.

Logging requests with server access logging
Logging Amazon S3 API calls using AWS CloudTrail

The following table lists the key properties of CloudTrail logs and Amazon S3 server-access logs. To make sure that CloudTrail meets your security requirements, review the table and notes.



Log properties
AWS CloudTrail
Amazon S3 server logs




Can be forwarded to other systems (Amazon CloudWatch Logs, Amazon CloudWatch Events)
Yes
No


Deliver logs to more than one destination (for example, send the same logs to two different buckets)
Yes
No


Turn on logs for a subset of objects (prefix)
Yes
No


Cross-account log delivery (target and source bucket owned by different accounts)
Yes
No


Integrity validation of log file by using digital signature or hashing
Yes
No


Default or choice of encryption for log files
Yes
No


Object operations (by using Amazon S3 APIs)
Yes
No


Bucket operations (by using Amazon S3 APIs)
Yes
No


Searchable UI for logs
Yes
No


Fields for Object Lock parameters, Amazon S3 Select properties for log records
Yes
No


Fields for Object Size, Total Time, Turn-Around Time, and HTTP Referer for log records
No
Yes


Lifecycle transitions, expirations, restores
No
Yes


Logging of keys in a batch delete operation
No
Yes


Authentication failures1
No
Yes


Accounts where logs get delivered
Bucket owner, and requester
Bucket owner only






Performance and Cost
AWS CloudTrail
Amazon S3 Server Logs




Price
Management events (first delivery) are free; data events incur a fee, in addition to storage of logs
No other cost in addition to storage of logs


Speed of log delivery
Data events every 5 minutes; management events every 15 minutes
Within a few hours


Log format
JSON
Log file with space-separated, newline-delimited records




Notes:


CloudTrail does not deliver logs for requests that fail authentication (in which the provided credentials are not valid). However, it does include logs for requests in which authorization fails (AccessDenied) and requests that are made by anonymous users.


S3 does not support delivery of CloudTrail logs or server access logs to the requester or the bucket owner for VPC endpoint requests when the VPC endpoint policy denies them or for requests that fail before the VPC policy is evaluated.





3. Logging requests with server access logging:
Server access logging provides detailed records for the requests that are made to a bucket. Server access logs are useful for many applications. For example, access log information can be useful in security and access audits. This information can also help you learn about your customer base and understand your Amazon S3 bill.
Note:
Server access logs don't record information about wrong-Region redirect errors for Regions that launched after March 20, 2019. Wrong-Region redirect errors occur when a request for an object or bucket is made outside the Region in which the bucket exists.
Logging request with server access logging supports this module.

Enable log delivery:
To enable log delivery, perform the following basic steps.


Provide the name of the destination bucket (also known as a target bucket). This bucket is where you want Amazon S3 to save the access logs as objects. Both the source and destination buckets must be in the same AWS Region and owned by the same account. The destination bucket must not have an S3 Object Lock default retention period configuration. The destination bucket must also not have Requester Pays enabled.

You can have logs delivered to any bucket that you own that is in the same Region as the source bucket, including the source bucket itself. But for simpler log management, we recommend that you save access logs in a different bucket.
When your source bucket and destination bucket are the same bucket, additional logs are created for the logs that are written to the bucket, which creates an infinite loop of logs. We do not recommend doing this because it could result in a small increase in your storage billing. In addition, the extra logs about logs might make it harder to find the log that you are looking for.
If you choose to save access logs in the source bucket, we recommend that you specify a destination prefix (also known as a target prefix) for all log object keys. When you specify a prefix, all the log object names begin with a common string, which makes the log objects easier to identify.


(Optional) Assign a destination prefix to all Amazon S3 log object keys. The destination prefix (also known as a target prefix) makes it simpler for you to locate the log objects. For example, if you specify the prefix value logs/, each log object that Amazon S3 creates begins with the logs/ prefix in its key, for example:

logs/2013-11-01-21-32-16-E568B2907131C0C0
If you specify the prefix value logs, the log object appears as follows:
logs2013-11-01-21-32-16-E568B2907131C0C0
Prefixes are also useful to distinguish between source buckets when multiple buckets log to the same destination bucket.
This prefix can also help when you delete the logs. For example, you can set a lifecycle configuration rule for Amazon S3 to delete objects with a specific prefix.


(Optional) Set permissions so that others can access the generated logs. By default, only the bucket owner always has full access to the log objects. If your destination bucket uses the Bucket owner enforced setting for S3 Object Ownership to disable access control lists (ACLs), you can't grant permissions in destination grants (also known as target grants) that use ACLs. However, you can update your bucket policy for the destination bucket to grant access to others.





Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/monitoring-overview.html

System Components and Boundaries

Amazon S3 is an object storage service that stores data as objects within buckets. An object is a file and any metadata that describes the file. A bucket is a container for objects.
To store your data in Amazon S3, you first create a bucket and specify a bucket name and AWS Region. Then, you upload your data to that bucket as objects in Amazon S3. Each object has a key (or key name), which is the unique identifier for the object within the bucket.
S3 provides features that you can configure to support your specific use case. For example, you can use S3 Versioning to keep multiple versions of an object in the same bucket, which allows you to restore objects that are accidentally deleted or overwritten.
Buckets and the objects in them are private and can be accessed only if you explicitly grant access permissions. You can use bucket policies, AWS Identity and Access Management (IAM) policies, access control lists (ACLs), and S3 Access Points to manage access.


Buckets
A bucket is a container for objects stored in Amazon S3. You can store any number of objects in a bucket and can have up to 100 buckets in your account. To request an increase, visit the Service Quotas console.
When you create a bucket, you enter a bucket name and choose the AWS Region where the bucket will reside. After you create a bucket, you cannot change the name of the bucket or its Region. Bucket names must follow the bucket naming rules. You can also configure a bucket to use S3 Versioning or other storage management features.
Buckets also:

Organize the Amazon S3 namespace at the highest level.
Identify the account responsible for storage and data transfer charges.
Provide access control options, such as bucket policies, access control lists (ACLs), and S3 Access Points, that you can use to manage access to your Amazon S3 resources.
Serve as the unit of aggregation for usage reporting.



Objects
Objects are the fundamental entities stored in Amazon S3. Objects consist of object data and metadata. The metadata is a set of name-value pairs that describe the object. These pairs include some default metadata, such as the date last modified, and standard HTTP metadata, such as Content-Type. You can also specify custom metadata at the time that the object is stored.
An object is uniquely identified within a bucket by a key (name) and a version ID (if S3 versioning is enabled on the bucket).


Keys
An object key (or key name) is the unique identifier for an object within a bucket. Every object in a bucket has exactly one key. The combination of a bucket, object key, and optionally, version ID (if S3 Versioning is enabled for the bucket) uniquely identify each object. So you can think of Amazon S3 as a basic data map between "bucket + key + version" and the object itself.
Every object in Amazon S3 can be uniquely addressed through the combination of the web service endpoint, bucket name, key, and optionally, a version.


S3 Versioning
You can use S3 Versioning to keep multiple variants of an object in the same bucket. With S3 Versioning, you can preserve, retrieve, and restore every version of every object stored in your buckets. You can easily recover from both unintended user actions and application failures.


Version ID
When you enable S3 Versioning in a bucket, Amazon S3 generates a unique version ID for each object added to the bucket. Objects that already existed in the bucket at the time that you enable versioning have a version ID of null. If you modify these (or any other) objects with other operations, such as CopyObject and PutObject, the new objects get a unique version ID.


Bucket policy
A bucket policy is a resource-based AWS Identity and Access Management (IAM) policy that you can use to grant access permissions to your bucket and the objects in it. Only the bucket owner can associate a policy with a bucket. The permissions attached to the bucket apply to all of the objects in the bucket that are owned by the bucket owner. Bucket policies are limited to 20 KB in size.
Bucket policies use JSON-based access policy language that is standard across AWS. You can use bucket policies to add or deny permissions for the objects in a bucket. Bucket policies allow or deny requests based on the elements in the policy, including the requester, S3 actions, resources, and aspects or conditions of the request (for example, the IP address used to make the request). For example, you can create a bucket policy that grants cross-account permissions to upload objects to an S3 bucket while ensuring that the bucket owner has full control of the uploaded objects. For more information, see Examples of Amazon S3 bucket policies.
In your bucket policy, you can use wildcard characters on Amazon Resource Names (ARNs) and other values to grant permissions to a subset of objects. For example, you can control access to groups of objects that begin with a common prefix or end with a given extension, such as .html.


S3 Access Points
Amazon S3 Access Points are named network endpoints with dedicated access policies that describe how data can be accessed using that endpoint. Access Points are attached to buckets that you can use to perform S3 object operations, such as GetObject and PutObject. Access Points simplify managing data access at scale for shared datasets in Amazon S3.
Each access point has its own access point policy. You can configure Block Public Access settings for each access point. To restrict Amazon S3 data access to a private network, you can also configure any access point to accept requests only from a virtual private cloud (VPC).


Access control Lists (ACLs)
You can use ACLs to grant read and write permissions to authorized users for individual buckets and objects. Each bucket and object has an ACL attached to it as a subresource. The ACL defines which AWS accounts or groups are granted access and the type of access. ACLs are an access control mechanism that predates IAM. For more information about ACLs, see Access control list (ACL) overview.
S3 Object Ownership is an Amazon S3 bucket-level setting that you can use to both control ownership of the objects that are uploaded to your bucket and to disable or enable ACLs. By default, Object Ownership is set to the Bucket owner enforced setting, and all ACLs are disabled. When ACLs are disabled, the bucket owner owns all the objects in the bucket and manages access to them exclusively by using access-management policies.
A majority of modern use cases in Amazon S3 no longer require the use of ACLs. We recommend that you keep ACLs disabled, except in unusual circumstances where you need to control access for each object individually. With ACLs disabled, you can use policies to control access to all objects in your bucket, regardless of who uploaded the objects to your bucket.


Regions
You can choose the geographical AWS Region where Amazon S3 stores the buckets that you create. You might choose a Region to optimize latency, minimize costs, or address regulatory requirements. Objects stored in an AWS Region never leave the Region unless you explicitly transfer or replicate them to another Region. For example, objects stored in the US East (N. Virginia) Region never leave it.
Note: You can access Amazon S3 and its features only in the AWS Regions that are enabled for your account.



Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html#CoreConcepts

Application Architecture
Create a base Terraform module to deploy an S3 bucket with configurable options for buckets versioning, server-side encryption, lifecycle policies, access control settings, and logging. This module also includes advanced policy management for enforcing TLS 1.2, restricting public and network access to a specific source VPC, enabling KMS key encryption retrieved from AWS Systems Manager Parameter Store, and supporting automated tagging for resource identification.

Application Dependencies
A "KMS key" is required for the bucket encryption.

Data Flow Diagram

Refer to the following diagram for this description.
Amazon S3 stores data as objects within buckets. An object is a file and any metadata that describes the file. A bucket is a container for objects. To store your data in Amazon S3, you first create a bucket and specify a bucket name and AWS Region. Then, you upload your data to that bucket as objects in Amazon S3. Each object has a key (or key name), which is the unique identifier for the object within the bucket.
S3 provides features that you can configure to support your specific use case. For example, you can use S3 Versioning to keep multiple versions of an object in the same bucket, which allows you to restore objects that are accidentally deleted or overwritten. Buckets and the objects in them are private and can only be accessed with explicitly granted access permissions. You can use bucket policies, AWS Identity and Access Management (IAM) policies, S3 Access Points, and access control lists (ACLs) to manage access.

Ref: https://aws.amazon.com/s3/

Ports, Protocols and Service

Amazon S3 itself does not inherently have ports or protocols specific to its operation, it uses common HTTP/HTTPS ports for access and interacts with a variety of AWS services and protocols for various functionalities.
S3 is RESTful web service, which means that clients communicate with it using standard HTTP methods (GET,PUT,POST,DELETE) and URLs that represent the S3 buckets and objects. The communication happens over the internet using the standard HTTP or HTTPS ports, without the need for any specific ports dedicated for S3.
By default it interacts with
Port 443: For HTTPS
Ref: https://docs.aws.amazon.com/general/latest/gr/s3.html

System Interconnections




In general, the traffic goes to the endpoint of the service (S3). Endpoints for S3 are provided here -> https://docs.aws.amazon.com/general/latest/gr/s3.html


In AWS Refresh design, in shared VPC, there is a dedicated subnet for VPC endpoints and all VPC endpoints have been created in that subnet including the S3 endpoint. So, there is no need to hit the public endpoints and hence traffic remains internally within the VPC.


The above diagram shows the flow of traffic from an EC2 instance towards S3 endpoint.





External Organization Name
External Point of Contact and Phone Number
Connection Security (IPSec VPN, SSL, Certificates, Secure File Transfer, etc.)
Data Direction (Incoming, outgoing, or both)
Information Being Transmitted




N/A
N/A
N/A
N/A
N/A




Modules and Automation




Module
Path




S3 bucket
https://gitlab.us.bank-dns.com/USBCLOUDPLATFORM/aws/storage/tf_modules/module-storage-s3bucket




Shield Pipeline Components
To deploy via pipeline:
There are two ways of deploying resources via pipeline using a 'Live' repo:

Using terraform files (main.tf, variables.tf and terraform.tfvars)
Using pure d-conf yaml (usbcloud-deploy.yaml)

For more information and examples, please read the following confluence page (deployment section):
Ref: https://confluence.us.bank-dns.com/display/CPE/Amazon+S3
Order of operations in a pipeline:

Download the artifact from the artifact feed
Terraform init (command)

Initializes working directory


Terraform plan (command)

Creates execution plan to preview changes


Bridgecrew scan of Terraform

Scan for security vulnerabilities and configurations


Terraform apply (command)

Executes actions




Non-Functional Considerations


Tags help to manage, identify, organize, search for, and filter resources. You can create tags to categorize resources by purpose, owner, environment, or other criteria. When you apply tags to S3, domains, and health checks, AWS generates a cost allocation report as a comma-separated value (CSV) file with your usage and costs aggregated by your tags.

Ref: https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html

Laws, Regulations, Standards and Guidance










Applicable Laws and Regulations
NA


Applicable Standards and Guidance
NA




TCO Considerations
You pay for storing objects in your S3 buckets. The rate you’re charged depends on your objects' size, how long you stored the objects during the month, and the storage class—S3 Standard, S3 Intelligent-Tiering, S3 Standard-Infrequent Access, S3 One Zone-Infrequent Access, S3 Express One Zone, S3 Glacier Instant Retrieval, S3 Glacier Flexible Retrieval (Formerly S3 Glacier), and S3 Glacier Deep Archive. You pay a monthly monitoring and automation charge per object stored in the S3 Intelligent-Tiering storage class to monitor access patterns and move objects between access tiers. In S3 Intelligent-Tiering there are no retrieval charges, and no additional tiering charges apply when objects are moved between access tiers.
There are per-request ingest charges when using PUT, COPY, or lifecycle rules to move data into any S3 storage class. Consider the ingest or transition cost before moving objects into any storage class.
Ref: https://aws.amazon.com/s3/pricing/

Minimum Security Controls (security/risk)

This blueprint SD3 meets the following minimum security baseline requirements. These are the bridgecrew general policies for S3 that are integrated with the pipeline and analyze the terraform code to detect any violation against them. US Bank specific controls will be added to this list in the near future.

Resource Tagging (3005)
AWS policy enforces tagging on deployment and is an on-demand execution. AWS policy denies deployment of resources if all required tags are not present.

Data In Motion Encryption (3052)
SecureTransport: This statement ensures that all interactions with the bucket are secured by allowing access only over HTTPS. Any requests made using unencrypted HTTP is denied, protecting data as it is transmitted. This enforcement aligns with security best practices by mandating a secure transport layer, requiring that connections to the S3 bucket meet a minimum protocol standard of TLS 1.2 or higher. This configuration helps ensure that sensitive data is not exposed in transit, supporting compliance with organizational security requirements for data protection.
Ref: TLS 1.2 Policy

KMS Key Encryption (3053)
The module mandates the use of KMS Key Id for encryption of the resource.

Public Access Policy (3115)
The Public Access policy configuration for the S3 bucket ensures that actions such as GetObject and PutObject are only allowed from authorized VPCs and IP addresses. This setup enhances security by restricting access to the S3 bucket, ensuring that only specific internal or trusted networks can upload or retrieve objects. By enforcing these conditions, interactions with the S3 bucket are limited to secure, authorized environments, significantly improving data protection and reducing the risk of unauthorized access. Refer the data.tf

Security Logging (3237) - NONPUBLISHED
By default, S3 is configured to log activities in CloudTrail under event history.


LM-02 - Monitor Security Events: Create monitoring rules and alert on security events of interest. CloudTrail logs must be enabled in all regions to log S3 service API events. Integrate S3 logs with SIEM system for centralized analyses and correlation with other security events.

LM-03 - Monitor User Activities: Monitor identities and access patterns to detect anomalies and unauthorized access attempts. Configure API activity captured by CloudTrail to help create alarms for monitoring specific API activity and receive email notifications when the respective API security occurs. Als Enable S3 Object level logging in CloudTrail.

A CloudTrail is created in the OU root account (854027572707 / US Bank) in each region and is configured to send to an S3 bucket in the 697593180759 account, as shown:

The S3 bucket is owned by the 697593180759 account and has very strict permissions for access.  This is the Log Archive account, showing that the account-wide public access block is enabled in the account, so it is not possible to make the Cloudtrail bucket public.

This is the entire policy on the bucket.


Create a Trail: For an ongoing record of events in your AWS account, including events for Amazon S3, create a trail. The Trail created at the OU level is a multi-region trail that is applied to the entire organization, as shown below:



LM-02 - Monitor Security Events: Create monitoring rules and alert on security events of interest. This work is performed by the ISS team.  You can log into Security Hub, using the ISS account (143954844616 / ISS), and view the findings from Guard Duty, etc.  The end-to-end process sends logs to the SIEM (Splunk) where Security Engineers in the GSOC can monitor the logs and alerts.  The process works as below.



Backup Configuration Tag (3045)
We will be creating a new preventive control for all AWS services.
The configuration tags the bucket for appropriate backup plan based on data classification. This tagging ensures the S3 buckets will be picked up by respective backup plan based on their classification (D1, D2, D3, D4 & D5).


This tag identifies the backup plan with the format s3-${var.data_clasification} to indicate backup plan.


The data_classification variable restricts values to D1 through D5, ensuring that buckets are correctly labeled based on data sensitivity.


This is how the Backup Configuration Tag looks like


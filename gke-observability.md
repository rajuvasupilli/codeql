# Flavours of GKE

Google Kubernetes Engine (GKE) offers two modes of operation: **Standard** and **Autopilot**. Both modes provide managed Kubernetes services, but they differ in terms of control, flexibility, and operational overhead. Here's a breakdown of the key differences:

## 1. Cluster Management and Configuration

### GKE Standard
- Full control over cluster configuration, including node pools, machine types, and scaling settings.
- Responsible for managing infrastructure (node upgrades, scaling, security patches).
- Suitable for users needing fine-grained control over Kubernetes.

### GKE Autopilot
- Google fully manages the cluster infrastructure (node provisioning, scaling, maintenance).
- Users define workloads (Pods, Deployments, etc.), while Autopilot handles the rest.
- Ideal for a hands-off, fully managed Kubernetes experience.

**Pros and Cons**
```markdown
| Feature      | GKE Standard                                       | GKE Autopilot                               |
|--------------|----------------------------------------------------|---------------------------------------------|
| Pros         | Full control over infrastructure                   | Hands-off cluster management                |
| Cons         | Higher operational overhead                        | Less flexibility in customization           |
| Limitations  | Requires deep Kubernetes expertise, manual updates | Limited customization, no custom node pools |
```

## 2. Node Management

### GKE Standard
- Users manage node pools, machine types, and autoscaling.
- Custom machine types or preemptible VMs can be used for cost savings.

### GKE Autopilot
- Google provisions and manages nodes based on workload needs.
- Pre-configured resource allocations ensure optimized utilization.

**Pros and Cons**
```markdown
| Feature     | GKE Standard                            |  GKE Autopilot                                                             |
|-------------|-----------------------------------------|----------------------------------------------------------------------------|
| Pros        | Customizable node configurations        | Automated node provisioning                                                |
| Cons        | Manual effort required for node scaling | No control over node selection                                             |
| Limitations | Requires manual scaling and monitoring  | No direct control over node types, autoscaling behavior, or node placement |
```

## 3. Cost Model

### GKE Standard
- Pay for underlying node resources (CPU, memory, storage) regardless of utilization.
- Requires manual effort for cost optimization (e.g., smaller nodes, preemptible VMs).

### GKE Autopilot
- Pay only for the resources requested by Pods (CPU, memory, ephemeral storage).
- No charges for unused node capacity, but slightly higher per-resource costs.

**Pros and Cons**
```markdown
| Feature      | GKE Standard                                          | GKE Autopilot                                                   |
|--------------|-------------------------------------------------------|-----------------------------------------------------------------|
| Pros         | More cost-efficient for high workloads                | Pay-as-you-use pricing                                          |
| Cons         | Potential cost inefficiencies for underutilized nodes | Slightly higher per-resource costs                              |
| Limitations  | Requires constant cost optimization                   | Higher per-resource costs, limited ability to optimize spending |
```

## 4. Workload Flexibility

### GKE Standard
- Supports all workloads, including stateful applications, batch jobs, and custom configurations.
- Advanced Kubernetes features like node taints, tolerations, and custom resource limits available.

### GKE Autopilot
- Optimized for stateless workloads following Kubernetes best practices.
- Restrictions on advanced configurations (e.g., privileged Pods, custom node settings).

**Pros and Cons**
```markdown
| Feature     | GKE Standard                          | GKE Autopilot                                                                          |
|-------------|---------------------------------------|----------------------------------------------------------------------------------------|
| Pros        | Supports all Kubernetes features      | Optimized for simplicity                                                               |
| Cons        | Requires manual optimization          | Limited workload configurations                                                        |
| Limitations | Requires expertise for best practices | No privileged workloads, limited ability to customize networking and security policies |
```

## 5. Operational Overhead

### GKE Standard
- Requires more effort (node management, scaling, upgrades).
- Suitable for teams with Kubernetes expertise.

### GKE Autopilot
- Reduces operational overhead with automated cluster management.
- Ideal for teams focusing on application development.

**Pros and Cons**
```markdown
| Feature     | GKE Standard                            | GKE Autopilot                                       |
|-------------|-----------------------------------------|-----------------------------------------------------|
| Pros        | Full control over operations            | Reduced operational overhead                        |
| Cons        | Requires dedicated Kubernetes expertise | Less control over cluster operations                |
| Limitations | Requires continuous management efforts  | No ability to intervene in cluster-level operations |
```

## 6. Use Cases

### GKE Standard
- Complex workloads needing custom configurations.
- Cost-sensitive environments where manual optimization is feasible.

### GKE Autopilot
- Fully managed Kubernetes service with minimal operational overhead.
- Stateless workloads with predictable costs.

**Pros and Cons**
```markdown
| Feature     | GKE Standard                            | GKE Autopilot                                           |
|-------------|-----------------------------------------|---------------------------------------------------------|
| Pros        | Ideal for complex deployments           | Best for hands-off operations                           |
| Cons        | Requires ongoing maintenance            | Not ideal for highly customized workloads               |
| Limitations | High learning curve, resource-intensive | Limited flexibility, restricted advanced configurations |
```

## 7. Location Availability

Both **GKE Standard** and **GKE Autopilot** are available in most Google Cloud Platform (GCP) regions. However, some features may vary by region. 
We can check the below links for the latest availability of the GKE Flavors
[official GCP regions page](https://cloud.google.com/about/locations)
[GKE Autopilot documentation](https://cloud.google.com/kubernetes-engine/docs/concepts/autopilot-overview) 

## Summary Table

```markdown
| Feature                  | GKE Standard            | GKE Autopilot                     |
|--------------------------|-------------------------|-----------------------------------|
| **Cluster Management**   | User-managed            | Fully managed by Google           |
| **Node Management**      | Configurable node pools | Google-managed nodes              |
| **Cost Model**           | Pay for node resources  | Pay for Pod resources             |
| **Workload Flexibility** | Full control            | Optimized for stateless workloads |
| **Operational Overhead** | Higher                  | Lower                             |
| **Ideal For**            | Advanced users          | Hands-off management              |
```


### Conclusion: GKE Standard vs. Autopilot

Choosing between GKE Standard and GKE Autopilot depends on our use case:

- GKE Standard is better suited for organizations needing full control over infrastructure, including node management, custom configurations, and advanced networking.

- GKE Autopilot is ideal for teams seeking a hassle-free Kubernetes experience, with automated provisioning and management at the cost of flexibility and customization.

If our workloads require high customization, privileged access, or cost optimization, GKE Standard would be the better choice. 
However, if our primary focus is on reducing operational overhead and simplifying Kubernetes management, GKE Autopilot is the way to go.

### Observability in GKE

## How Does Observability Work?

Observability in Google Kubernetes Engine (GKE) Standard and GKE Autopilot involves monitoring, logging, and tracing the performance and health of your applications and infrastructure. Both provide tools and integrations to help achieve observability, but GKE Autopilot has some limitations due to its managed nature.

## Observability in GKE Standard

# Monitoring:

- Google Cloud Operations Suite (formerly Stackdriver) for collecting metrics, setting alerts, and creating dashboards.

- Prometheus: Deployable in-cluster or via Google Cloud Managed Service for Prometheus.

- Custom Metrics: Applications can expose custom metrics for Cloud Monitoring.

# Logging:

- Cloud Logging: Automatically collects control plane and application logs.

- Fluentd: Used as a logging agent to forward logs to Cloud Logging.

# Tracing:

- Cloud Trace for distributed tracing.

- OpenTelemetry for additional tracing capabilities.

## Observability in GKE Autopilot

- Similar tools as GKE Standard, but with fewer configuration options.

- Google manages logging agents, monitoring configurations, and ensures seamless log collection.

- Logs and metrics are automatically collected and sent to Google Cloud Logging.

## Key Differences

| Feature             | GKE Standard                        | GKE Autopilot                    |
|---------------------|-------------------------------------|----------------------------------|
| Node Management     | Customizable logging agents         | Google-managed agents            |
| Resource Allocation | Fully configurable                  | Automatically managed            |
| Cost                | Cost based on provisioned resources | Cost based on consumed resources |

## Best Practices

- Use Managed Services: Leverage Google Cloud Managed Service for Prometheus and Cloud Logging.

- Standardize Observability: Use consistent labels, metrics, and logging formats across clusters.

- Monitor Resource Usage: Optimize monitoring configurations to manage costs efficiently.

### Logs and Metrics Processed in GKE

## Logs

# Control Plane Logs:

- API Server Logs, Scheduler Logs, Controller Manager Logs, etcd Logs.

# Node Logs:

- Kubelet Logs, Container Runtime Logs.

# Application Logs:

- Stdout/Stderr Logs, Custom Log Files.

## Metrics

# Control Plane Metrics:

- API Server Metrics, Scheduler Metrics, Controller Manager Metrics.

# Node Metrics:

- Kubelet Metrics, Node Resource Metrics.

- Application Metrics:

- Custom Metrics collected via Prometheus or OpenTelemetry.

# Log Transfer Process and Agents in GKE

- Application Logs are captured via container runtimes (e.g., containerd) and forwarded by logging agents.

- Logs are aggregated and exported to Google Cloud Logging via the logging agent.


## GKE Logging Setup:

GKE workloads generate logs to stdout/stderr, and these logs are automatically collected by the GKE Logging Agent and sent to Google Cloud Logging, which is based on Fluent Bit, hence we do not need to install any agents inside the applications to collect the **stdout/stderr logs** in GKE. Kubernetes automatically captures these logs and stores them on the node.

## **Fluent Bit Agent for GKE Logs**

| **Category**               | **File Location**          | **Data Destination** | **Grouping**                        | **Destination Path** |
|----------------------------|----------------------------|----------------------|------------------------------------|----------------------|
| **Application - STDOUT Logs** | `/var/log/containers`       | Prometheus | Log groups by namespace name | `projects/${PROJECT_ID}/logs/${CLUSTER_NAME}/containers/${NAMESPACE_NAME}` |
| **Kubelet, CNI, and CoreDNS Logs** | `/var/log/kubelet.log` `/var/log/containers` | Prometheus | Log groups by component name | `projects/${PROJECT_ID}/logs/${CLUSTER_NAME}/system/kubelet` |
| **System Logs (Node Logs)** | `/var/log/syslog` `/var/log/messages` | Prometheus | Log groups by node name | `projects/${PROJECT_ID}/logs/${CLUSTER_NAME}/system/syslog` |
| **Control Plane Logs** | Google Cloud Logging (Managed) | Cloud Logging | Log groups by control plane component | `projects/${PROJECT_ID}/logs/${CLUSTER_NAME}/control-plane/${COMPONENT}` |

To **forward logs to Prometheus**, we use **Fluent Bit**, a lightweight and efficient log processor and forwarder that runs as a **DaemonSet** on GKE nodes.

## **Fluent Bit for Prometheus**
Fluent Bit reads logs from `/var/log/containers` and pushes them to Prometheus. Below are the key steps:

1. **Deploy Fluent Bit as a DaemonSet** to run on each node.
2. **Configure Fluent Bit to collect application logs** from `/var/log/containers`.
3. **Use the Prometheus Exporter plugin** to send logs as Prometheus metrics.

### **Fluent Bit Configuration for Prometheus**

#### **1. Install Fluent Bit on GKE**
Deploy Fluent Bit as a DaemonSet in the cluster:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluent-bit
  namespace: logging
spec:
  selector:
    matchLabels:
      name: fluent-bit
  template:
    metadata:
      labels:
        name: fluent-bit
    spec:
      containers:
      - name: fluent-bit
        image: fluent/fluent-bit:latest
        volumeMounts:
        - name: varlog
          mountPath: /var/log
        - name: varlibdockercontainers
          mountPath: /var/lib/docker/containers
          readOnly: true
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
      - name: varlibdockercontainers
        hostPath:
          path: /var/lib/docker/containers
```

#### **2. Configure Fluent Bit to Send Logs to Prometheus**
Create a ConfigMap for Fluent Bit with Prometheus exporter settings:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: fluent-bit-config
  namespace: logging
data:
  fluent-bit.conf: |
    [SERVICE]
        Flush         5
        Daemon        Off
        Log_Level     info
    [INPUT]
        Name         tail
        Path         /var/log/containers/*.log
        Parser       docker
    [OUTPUT]
        Name        prometheus_exporter
        Match       *
        Host        0.0.0.0
        Port        2020
```

#### **3. Expose Fluent Bit Metrics to Prometheus**
Once Fluent Bit is running, Prometheus can scrape metrics from it by adding this job to Prometheus' scrape configuration:

```yaml
scrape_configs:
  - job_name: 'fluent-bit'
    static_configs:
      - targets: ['fluent-bit.logging.svc.cluster.local:2020']
```

The same process can be followed to capture and push the data plane/node logs (such as system logs and kubelet logs) by configuring it to read from /var/log/syslog, /var/log/messages, and /var/log/kubelet.log.

## Send Control Plane logs to Prometheus:
The Control plane logs (API server, scheduler, controller manager, etc.) are managed by Google Cloud Logging and are not stored on the nodes themselves.

To capture control plane logs, we would need to:

### Enable Google Cloud Logging for GKE and use Google Cloud's Logging API to extract and forward logs to Prometheus.

1. Enable Cloud Logging and Export Control Plane Logs

Ensure that Cloud Logging is enabled for your GKE cluster:
```
gcloud container clusters update CLUSTER_NAME \
    --logging=SYSTEM,WORKLOAD
```
Then, create a log sink to export control plane logs:
```
gcloud logging sinks create control-plane-logs-sink \
    --destination=pubsub.googleapis.com/projects/${PROJECT_ID}/topics/control-plane-logs-topic \
    --log-filter='resource.type="k8s_cluster"'
```
2. Deploy a Pub/Sub Subscriber to Process Logs

### Create a Pub/Sub subscription to receive logs:
```
gcloud pubsub subscriptions create control-plane-logs-sub \
    --topic=control-plane-logs-topic
```
Then, deploy a Fluent Bit instance to subscribe and forward logs:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: fluent-bit-control-plane
  namespace: logging
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fluent-bit
  template:
    metadata:
      labels:
        app: fluent-bit
    spec:
      containers:
      - name: fluent-bit
        image: fluent/fluent-bit:latest
        env:
        - name: PUBSUB_SUBSCRIPTION
          value: "control-plane-logs-sub"
```
3. Forward Logs to Prometheus

Modify Fluent Bit's configuration to process Cloud Logging logs and expose them as Prometheus metrics:
```
[INPUT]
    Name        pubsub
    Subscription control-plane-logs-sub

[OUTPUT]
    Name        prometheus_exporter
    Match       *
    Host        0.0.0.0
    Port        2020
```
Finally, configure Prometheus to scrape logs from Fluent Bit:
```
scrape_configs:
  - job_name: 'fluent-bit-control-plane'
    static_configs:
      - targets: ['fluent-bit-control-plane.logging.svc.cluster.local:2020']
```
This setup ensures that the Control Plane logs from Google Cloud Logging are extracted, processed, and forwarded to Prometheus using Fluent Bit. 


---




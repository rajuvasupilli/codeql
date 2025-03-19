# Installing and Customizing Fluent Bit in GKE

## Objective

Deploy our own Fluent Bit DaemonSet on a Google Kubernetes Engine cluster, configured to log data to Cloud Logging.

## Prerequisites

- **GKE Cluster**: Ensure we have a running GKE cluster.
- **kubectl**: Installed and configured to interact with the GKE cluster.
- **Helm**: Installed for deploying Fluent Bit using Helm charts.

## Introduction

In this document, we learn how to host our own configurable Fluent Bit DaemonSet to send logs to Cloud Logging instead of selecting the Cloud Logging option when creating the Google Kubernetes Engine (GKE) cluster, which does not allow configuration of the Fluent Bit daemon.

## Step 1: Install Fluent Bit Using Helm

1. **Add the Fluent Helm Charts Repository**:
   ```sh
   helm repo add fluent https://fluent.github.io/helm-charts
   helm repo update
   ```

2. **Install Fluent Bit**:
   ```sh
   helm install fluent-bit fluent/fluent-bit --namespace kube-system
   ```
   This command deploys Fluent Bit as a DaemonSet, ensuring it runs on every node of your Kubernetes cluster. ([docs.fluentbit.io](https://docs.fluentbit.io/manual/installation/kubernetes?utm_source=chatgpt.com))

3. **Verify the Installation**:
   ```sh
   kubectl get pods -n kube-system | grep fluent-bit
   ```
   Ensure all Fluent Bit pods are in the `Running` state.

## Step 2: Customize Fluent Bit Configuration

Fluent Bit's behavior can be tailored by modifying its configuration.

1. **Access the Fluent Bit ConfigMap**:
   ```sh
   kubectl edit configmap fluent-bit-config -n kube-system
   ```

2. **Modify Input Configuration**:
   To collect logs from specific paths:
   ```ini
   [INPUT]
       Name              tail
       Path              /var/log/containers/*.log
       Parser            docker
       Tag               kube.*
       Mem_Buf_Limit     5MB
       Skip_Long_Lines   On
   ```

3. **Add Kubernetes Metadata**:
   Enrich logs with Kubernetes metadata:
   ```ini
   [FILTER]
       Name                kubernetes
       Match               kube.*
       Kube_URL            https://kubernetes.default.svc:443
       Merge_Log           On
       K8S-Logging.Parser  On
       K8S-Logging.Exclude On
   ```
   This filter fetches metadata such as pod name, namespace, labels, and annotations, enhancing log context. ([medium.com](https://medium.com/google-cloud/customizing-fluent-bit-for-google-kubernetes-engine-logs-a484b5d80072?utm_source=chatgpt.com))

4. **Set Output Destination**:
   Define where the logs should be sent. For example, to output logs to Google Cloud's Logging service:
   ```ini
   [OUTPUT]
       Name        stackdriver
       Match       *
   ```

5. **Apply Configuration Changes**:
   After editing the ConfigMap, restart the Fluent Bit pods to apply the new configuration:
   ```sh
   kubectl delete pod -n kube-system -l app.kubernetes.io/name=fluent-bit
   ```
6. **Verify that you’re seeing logs in Cloud Logging. In the console, on the left-hand side, select Logging > Logs Explorer, and then select Kubernetes Container as a resource type in the Resource list.**

7. **Click Run Query.**

8. **In the Logs field explorer, select test-logger for CONTAINER_NAME. After you add the log field to the summary line, you should see logs similar to the following:**


## Step 3: Monitor Fluent Bit

Monitoring ensures Fluent Bit operates as expected.

1. **Check Fluent Bit Logs**:
   ```sh
   kubectl logs -l app.kubernetes.io/name=fluent-bit -n kube-system
   ```
   Review these logs for any errors or warnings.

2. **Enable Metrics Endpoint**:
   To monitor performance metrics, ensure the metrics server is enabled in the Fluent Bit configuration:
   ```ini
   [SERVICE]
       ...
       HTTP_Server    On
       HTTP_Listen    0.0.0.0
       HTTP_Port      2020
   ```

3. **Access Metrics**:
   Forward the metrics port to our local machine:
   ```sh
   kubectl port-forward svc/fluent-bit 2020:2020 -n kube-system
   ```
   Then, access the metrics at `http://localhost:2020/api/v1/metrics`.

## Conclusion

By following these steps, we have installed and customized Fluent Bit in our GKE cluster. Regular monitoring and tailored configurations ensure efficient and effective log management.




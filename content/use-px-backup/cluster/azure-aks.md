---
title: AKS
description:
keywords:
weight: 3
hidesections: true
disableprevnext: true
---

## Prerequisites

* Your cluster must be running Stork 2.4 or higher. To install Stork on your Kubernetes cluster, copy and paste the command located under the **Kubernetes Service** radio group.

* On your cluster, create a secret from your Azure tenant ID, client ID, and client secret, and then set an environment variable for Stork:

    ```text
    kubectl create secret generic -n kube-system px-azure \
      --from-literal=AZURE_TENANT_ID=<tenant> \
      --from-literal=AZURE_CLIENT_ID=<appId> \
      --from-literal=AZURE_CLIENT_SECRET=<password>
    kubectl set env --from=secret/px-azure deploy/stork -n kube-system
    ```

## Add the cluster to PX-Backup

1. From the home page, select **Add Cluster**:

    ![Add cluster](/img/add-cluster.png)

2. On the **Add Kubernetes Cluster** page, enter the cluster details:
    * The name of the cluster
    * Retrieve the Kubeconfig from your cluster and paste it in the **Kubeconfig** text frame, or select the **Browse** button to upload it from a file.
    * Select the **Others** radio button from the **Kubernetes Service** radio group

    ![Enter the cluster details](/img/enter-aks-cluster-details.png)

3. Select the **Submit** button

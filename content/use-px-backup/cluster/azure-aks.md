---
title: AKS
description: 
keywords: 
weight: 3
hidesections: true
disableprevnext: true
---

1. add the cluster to PX-Backup
    1. In PX-Backup, Select **Add Cluster**
    2. From this page, enter the cluster details:
        1. Name the cluster
        2. Retrieve the Kubeconfig from your cluster and paste it in the **Kubeconfig** text frame
        3. Select the **Others** radio button from the **Kubernetes Service** 
        4. Select the **Submit** button

        ![](/img/azure-cluster-add.png)

2. On your cluster, set environment variables for Stork containing your Azure tenant ID, client ID, and client secret:

    ```text
    kubectl create secret generic -n kube-system px-azure --from-literal=AZURE_TENANT_ID=<tenant> \
                                                        --from-literal=AZURE_CLIENT_ID=<appId> \
                                                        --from-literal=AZURE_CLIENT_SECRET=<password>
    ```


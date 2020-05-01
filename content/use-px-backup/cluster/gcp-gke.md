---
title: GKE
description: 
keywords: 
weight: 3
hidesections: true
disableprevnext: true
---



3. Add the cluster to PX-Backup
    1. Now that you've added the cloud account to PX-Backup, it can authenticate with your cluster on GCP and perform the operations necessary for backup tasks. 
    2. In PX-Backup, Select **Add Cluster**
    3. From this page, enter the cluster details
        * Name the cluster
        * Retrieve the Kubeconfig from your cluster and paste it in the **Kubeconfig** text frame
        * Select the **GKE** radio button from the **Kubernetes Service** 
        * From the **Cloud Account** dropdown, select the cloud account you previously created.
        * Select the **Submit** button

    ![](/img/gcp-cluster-add.png)

{{<info>}}
**NOTE:** Your cluster must be running Stork 2.4 or higher. Copy and paste the command located under the **Cluster name** field if necessary.
{{</info>}}

<!-- Modify the node security settings, Create a cluster role with compute engine read/write access. 

When creating your cluster on GKE:

1. Under **NODE POOLS** > **Node security**, select a service account; the Compute Engine default service account is sufficient.
2. Under **Access scopes** within the **Node security** page, select the **Set access for each API** option. Under the **Compute Engine** dropdown, select **Read Write** 

Once the cluster has deployed: 
2. Get the service account key associated with your cluster:
    1. get this from GCP dashboard: **IAM & Admin** > **IAM** > **Service Accounts** > **Actions...** > **Create Key** > JSON key type
    download the JSON key
    -->

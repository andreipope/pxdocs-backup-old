---
title: EKS
description: 
keywords: 
weight: 3
hidesections: true
disableprevnext: true
---

Now that you've added the cloud account to PX-Backup, it can authenticate with your cluster on AWS and perform the operations necessary for backup tasks. 

1. In PX-Backup, Select **Add Cluster**
2. From this page, enter the cluster details
    
    * Name the cluster
    * Retrieve the Kubeconfig from your cluster and paste it in the **Kubeconfig** text frame
    * Select the **EKS** radio button from the **Kubernetes Service** 
    * From the **Cloud Account** dropdown, select the cloud account you previously created.
    * Select the **Submit** button

    ![](/img/aws-cluster-add.png)






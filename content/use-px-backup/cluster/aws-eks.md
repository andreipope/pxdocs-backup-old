---
title: EKS
description:
keywords:
weight: 3
hidesections: true
disableprevnext: true
---

## Prerequisites

* You've added your AWS cloud account to PX-Backup. See the [AWS/S3 compliant object store](/use-px-backup/credentials/aws/) page for more details about how you can add an AWS account to PX-Backup.

* Your cluster must be running Stork 2.4 or higher. To install Stork on your Kubernetes cluster, copy and paste the command located under the **Kubernetes Service** radio group.

## Add the cluster to PX-Backup

1. From the home page, select **Add Cluster**:

    ![Add cluster](/img/add-cluster.png)

2. Enter the cluster details:

    * The name of the cluster
    * Retrieve the Kubeconfig from your cluster and paste it in the **Kubeconfig** text frame, or select the **Browse** button to upload it from a file.
    * Select the **EKS** radio button from the **Kubernetes Service** radio group.
    * From the **Cloud Account** dropdown, select your AWS cloud account.

    ![Enter the cluster details](/img/enter-eks-cluster-details.png)

3. Select the **Submit** button



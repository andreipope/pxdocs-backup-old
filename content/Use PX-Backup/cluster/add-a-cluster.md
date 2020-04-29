---
title: Add a cluster
description: 
keywords: 
weight: 3
hidesections: true
disableprevnext: true
---

Once you’ve installed PX-Backup, you’re ready to add any clusters you’d like to back up and restore to. How you prepare your cluster differs on its environment. 



## my cluster is in AWS with EBS

## Azure with managed disks

## GCP with persistent disks


clouds | using cloud volumes | 

GCP | 

1. If you’re using EKS or GKE, create cloud credentials.
2. Add your kubeconfig to PX-Central. ssh into your cluster and run the following command:
    
    ```text
    kubectl config view --flatten --minify
    ```
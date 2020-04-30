---
title: Add a cluster
description: 
keywords: 
weight: 3
hidesections: true
disableprevnext: true
---

Once you’ve installed PX-Backup, you’re ready to add any clusters you’d like to back up and restore to. How you prepare your cluster differs on its environment. 

## AWS with EBS



## Azure with managed disks

## GCP with persistent disks

### enable permissions

1. Create a kubernetes cluster on GCP
2. go to the security tab, under access scope, set access for each api
3. give it read/write access for compute engine

### add the cloud account

GCP

enter the JSON key. get it from IAM in GCP dashboard.
IAM > service accounts > actions > create key > choose key type JSON from the service account. once you do this, it generates the JSON. Copy that json and paste it into the JSON key field in the cloud account section of PX central. 

next, go to add cluster, get the kubeconfig: GKE dash > clusters > connect > run the command line access command > paste the kubectl config output into the cluster input on px-backup. 

The cluster now shows up and you can view everything from the application dashboard. 

create the cloud credential associated with the service account associated with the GKE cluster. 


clouds | using cloud volumes | 

GCP | 

1. If you’re using EKS or GKE, create cloud credentials.
2. Add your kubeconfig to PX-Central. ssh into your cluster and run the following command:
    
    ```text
    kubectl config view --flatten --minify
    ```
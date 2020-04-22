---
title: Add a cluster
description: 
keywords: 
weight: 3
hidesections: true
disableprevnext: true
---

Once you’ve installed PX-Backup, you’re ready to add any clusters you’d like to back up and restore to.  

1. If you’re using EKS or GKE, create cloud credentials.
2. Add your kubeconfig to PX-Central. ssh into your cluster and run the following command:
    
    ```text
    kubectl config view --flatten --minify
    ```
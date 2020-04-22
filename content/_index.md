---
title: Portworx Documentation
description: Find out more about Portworx, the persistent storage solution for containers. Come check us out for step-by-step guides and tips!
keywords: portworx, kurbernetes, containers, storage
weight: 1
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---


PX-Backup is a Kubernetes backup solution that allows you to backup applications and data together and restore them at a later point. Using PX-Central as the multi-cluster management UI, one or more users within the organization can perform backup/restore operations for their namespaces/applications on-demand or in a scheduled manner. PX-Backup can also backup/restore applications that are deployed in managed (cloud) Kubernetes environments with cloud storage drives and does not require Portworx Enterprise Storage running on those clusters. PX-Backup is container granular, namespace aware and application consistent way of protecting applications and data in multi-cloud environments.

------

PX-Backup is a product by Portworx Inc. that allows you to backup applications and their data together from any Kubernetes cluster and restore them to any Kubernetes cluster. PX-Backup works through PX-Central, allowing you or any other approved users to manage multiple clusters and their backups from a single UI. 

What makes PX-Backup special is its granularity and flexibility. PX-Backup solves a number of problems with performing application backups manually:

* Scheduling: Rather than scheduling backups one-at-a-time, you can create a an independent schedule policy that defines when any associated backups run and how many rolling copies they keep.
* Granularity: Instead of backing up an entire VM or cluster, PX-Backup allows you to define which applications on your cluster to back up by allowing you to select labels and namespaces. Selecting namespaces also ensures that your applications are backed up in their entirety, so you can be confident they'll run correctly when you restore them. 
* Automation: Avoid tedious prep-work and minimize interruptions to your cluster associated with backup tasks by creating rules that run before and after backups are taken. As with schedule policies, you can associate rules with multiple backups. 
* Multi-tenant: Rather than relying on adminstrators to perform and manage backups, you can provide access to your organization with OIDC. From the PX-Backup UI, your users can perform backups on clusters and namespaces that they have permissions for. 

------

PX-Backup provides a way for you to backup Kubernetes applications and their data and restore them across multiple clusters.

-or- 

PX-Backup is a backup solution for Kubernetes that allows you to back up and restore applications and their data from within PX-Central. 


Users interact with PX-Backup through the PX-Central UI.

It supports multitenancy, allowing authorized users to connect through OIDC, create, and manage backups for clusters and apps which they have permissions without needing to go through an administrator.

You can use namespace and label selectors to create granular backups of the application you want. This selection method also helps preserve associated configuration and pod data, ensuring that your backups will work properly once restored. 

You can broadly backup an entire namespace, or you can use label selectors to select only certain resources to backup. 

By using selectors, backups maintain application integrity. For example, PX-backup would backup a mySQL deployment containing pods, PVCs, and volumes tagged with a `app = mysql` label. Given this system, PX-Backup can backup stateful apps as easily as stateless ones. (??? True? Better validate this step. ???)

You can use PX-Backup on any Kubernetes cluster, and PX-Enterprise does not need to be installed. 

PX-Backup integrates with major block storage providers:

* Amazon EBS
* Google Persistent Disk
* Azure Managed Disks
* Portworx PX-Store

You can backup from any connected Kubernetes cluster and restore to any connected cluster. You don't need to restore to the same cluster, and you can even restore to a different namespace. 

If you do restore to the same cluster and namespace, you choose to overwrite and replace the existing resources.

Additionally, if your backup includes multiple namespaces, you can choose to restore only some of the namespaces.

you can create an independent schedule policy that defines when backups run and how many rolling copies they keep. You can associate this schedule policy with as many backups as you want. 

PX-Backup stores backups on any compatible object storage:

* AWS S3 or compatible object stores
* Azure Blob Storage
* Google Cloud Storage

From a central application view, you can see all of the resources currently on your cluster, filter them by namespace and labels, and create a backup. 

Avoid tedious prep-work and minimize interruptions to your cluster associated with backup tasks by creating rules that run before and after backups are taken. As with schedule policies, you can associate rules with multiple backups. 
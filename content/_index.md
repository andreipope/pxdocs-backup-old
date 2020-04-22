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

PX-Backup is a Kubernetes backup solution that allows you to back up and restore applications and their data across multiple clusters. PX-Backup works through PX-Central, allowing you or any other approved users to manage multiple clusters and their backups from a single UI. 

PX-Backup solves a number of problems with performing application backups manually or at the system level:

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


---

PX-Backup is a Kubernetes backup solution that allows you to back up and restore applications and their data across multiple clusters. PX-Backup works through PX-Central, allowing you or any other approved users to manage multiple clusters and their backups from a single UI. Under this principle of multitenancy, authorized users connect through OIDC to create and manage backups for clusters and apps which they have permissions without needing to go through an administrator. 

PX-Backup is compatible with any Kubernetes cluster, including managed and cloud deployments, and does not require PX-Enterprise to be installed. 
PX-Backup integrates with major block storage providers:

* Amazon EBS
* Google Persistent Disk
* Azure Managed Disks
* Portworx PX-Store

PX-Backup stores backups on any compatible object storage:

* AWS S3 or compatible object stores
* Azure Blob Storage
* Google Cloud Storage

PX-Backup is capable of backing up the following Kubernetes resources:

* PV
* PVC
* Deployment
* StatefulSet
* ConfigMap
* Service
* Secret
* DaemonSet
* ServiceAccount
* Role
* RoleBinding
* ClusterRole
* ClusterRoleBinding
* Ingress


## Understand how PX-Backup works

PX-Backup provides namespace and label selectors, allowing you to create granular backups of the application you want. You can broadly backup an entire namespace, or you can use label selectors to select only certain resources to backup. This selection method also helps preserve associated configuration and pod data, ensuring that your backups will work properly once restored. For example, PX-backup can back up a mySQL deployment containing pods, PVCs, and volumes tagged with a `app = mysql` label. Given this system, PX-Backup can backup stateful apps as easily as stateless ones. 
<!-- <??? True? Better validate this step. ???> -->

You can schedule backups by creating an independent schedule policy that defines when backups run and how many rolling copies they keep, and you can associate this schedule policy with as many backups as you want. 

Avoid tedious prep-work and minimize interruptions to your cluster associated with backup tasks by creating rules that run before and after backups are taken. As with schedule policies, you can associate rules with multiple backups. 

## PX-Backup components

<!-- this section now just feels like a rehash of a lot of what was said above with some new information sprinkled in. It does make the components clear though. Perhaps some repetition wouldn't be too harmful in getting these new concepts across. -->
In order to use PX-Backup, it’s helpful to understand the components that make it up. You’ll use these components to perform backup and restore operations: 

### Clusters 

A cluster in PX-Backup is any Kubernetes cluster that PX-Backup makes backups from or restores backups to. PX-Backup supports pretty much any Kubernetes cluster that’s internet accessible <??? and some that aren’t ???>. With PX-Backup, you can monitor, backup, and restore across all of your Kubernetes clusters.

### Backups

Backups in PX-Backup contain backup images and configuration data. You can attach schedule policies to run them at designated times and keep a designated amount of rolling backups, and attach rules to perform commands before or after a backup runs. 

### Restores

Restore your backups to the original cluster or different clusters, replace applications on the original cluster or restore to a new namespace. Perform partial restores to selected namespaces from the backup. 

### Schedule Policies

Create schedule policies and attach them to backups to run them at designated times and keep a designated amount of rolling backups. 

### Rules 

Create commands which run before or after a backup operation is performed. Specify labels

### Application view

You interact with PX-Backup through a central application view. From here, you can see all of the resources currently on your cluster, filter them by namespace and labels, and create a backup. 

## Get Started

Perform the following tasks to quickly get started with PX-Backup and perform your first backup:

1. Install PX-Backup
2. Add a cluster
3. Configure backup locations
4. Perform a backup

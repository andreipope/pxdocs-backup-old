---
title: PX-Backup documentation
description: 
keywords: 
weight: 1
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

PX-Backup is a Kubernetes backup solution that allows you to back up and restore applications and their data across multiple clusters. PX-Backup works through PX-Central, allowing you or any other approved users to manage multiple clusters and their backups from a single UI. Under this principle of multitenancy, authorized users connect through OIDC to create and manage backups for clusters and apps which they have permissions without needing to go through an administrator. 

PX-Backup is compatible with any Kubernetes cluster, including managed and cloud deployments, and does not require PX-Enterprise to be installed. 
PX-Backup integrates with major block storage providers:

* Amazon EBS
* Google Persistent Disk
* Azure Managed Disks
* Portworx PX-Store

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

### Backup locations

Backup locations are object stores you've added to PX-Backup. PX-Backup stores backups on any compatible object storage:

* AWS S3 or compatible object stores
* Azure Blob Storage
* Google Cloud Storage

### Restores

Restore your backups to the original cluster or different clusters, replace applications on the original cluster or restore to a new namespace. Perform partial restores to selected namespaces from the backup. 

### Schedule Policies

Create schedule policies and attach them to backups to run them at designated times and keep a designated amount of rolling backups. 

### Rules 

Create commands which run before or after a backup operation is performed. Specify labels

### Application view

<!-- This doesn't really fit here, need to find a better place -->
You interact with PX-Backup through a central application view. From here, you can see all of the resources currently on your cluster, filter them by namespace and labels, and create a backup. 

## Get Started

Perform the following tasks to quickly get started with PX-Backup and perform your first backup:

1. [Install PX-Backup](/install)
2. [Add a cluster](/add-a-cluster)
3. [Configure backup locations](/configure-backup-locations)
4. [Perform a backup](/perform-backup)

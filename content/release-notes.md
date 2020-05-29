---
title: Release notes
description: See the latest changes associated with recent releases.
keywords: 
weight: 11
hidesections: true
disableprevnext: true
series: backup
---

## 1.0.1

June 1, 2020

### Improvements

Portworx, Inc. has upgraded or enhanced functionality in the following areas:

| **Improvement Number** | **Improvement Description** |
|----|----|
| PB-547 | PX-Backup now allows more than 12 backups to be retained while creating a schedule. |
| PB-515 | Users can now add and edit a cluster to Lighthouse independently from PX-Backup. <!-- need to confirm this. --> |


### Fixes

Portworx, Inc. has fixed the following issues:

|**Issue Number**|**Issue Description**|
|----|----|
| PB-534 | Clusters could be added to PX-Backup using credentials that did not have adequate permissions.<br/><br/>**User Impact:** PX-Backup would not be able to display data or perform operations properly.<br/><br/>**Resolution:** Cluster addition now fails if credentials do not have all of the required permissions. |
| PB-519 | It was possible to attempt to add a backup location before any adding a cloud account. **User Impact:** Despite seeing the **+ Add** option, users would not be able to add a backup location.<br/><br/>**Resolution:** Users must now add a cloud account before seeing the option to add a backup location. |
| PB-400 | When editing a backup schedule, the existing pre-exec and post-exec rules did not appear in the dialog box.<br/><br/>**User Impact:** Users would have to reselect their pre-exec and post-exec rules when they edited an existing backup schedule.<br/><br/>**Resolution:** PX-Backup now lists the existing pre-exec and post-exec rules when a user edits a backup schedule. |
| PB-307 | Restores from subsequent backups stored on different buckets from the original that both involve the same namespace failed. <!-- this is tough to explain and I'm not sure I got it right. -->  <br/><br/>**User Impact:** If users created multiple backups and buckets, restores from subsequent backups stored on different buckets from the original that both involve the same namespace failed.<br/><br/>**Resolution:** PX-Backup now properly takes the initial backup for incremental backups, even when they share a namespace with other backups using different buckets. |
| PB-499 | When PX-Backup failed to create a backup, the UI became stuck, showing only the creation failure message. <br/><br/>**User Impact:**  Due to the stuck message, users may have been unable to see the real reason for a backup deletion failure.<br/><br/>**Resolution:** Creation failure messages no longer stick, allowing users to see more recent messages. |
| PB-493 |The PX-Backup UI did not update to reflect invalid underlying backup object statuses.<br/><br/>**User Impact:** If a backup object was deleted, users may still have seen the backup appear as valid on the PX-Backup UI.<br/><br/>**Resolution:** PX-Backup now properly displays the invalid backup status. |
| PB-468 | Users could create more backups than their license allows.<br/><br/>**User Impact:** Users who created more backups than their license allows would experience backup failures and error messages.<br/><br/>**User Impact:** PX-Backup now stops users from creating excess backups before they exceed their license capacity. |


<!-- I don't think these need release notes
| PB-395 | UI: App view take a long time to load when multiple namespaces were seclected |
| PB-389 | UX: Application View: There should be a refresh button in the App View page |
| PB-486 | There should be a reason displayed when the backup is in deleting state |
| PB-485 | Need help/info icons explaining input fields in credential settings page |
| PB-480 | "Remove" should be disabled when there is no entry in the pod selector during Rule creation |
| PB-479 | When a backup is in Delete pending, we should not show restore option. |
| PB-477 | Enter key doesnt work in search box | 
| PB-455 | Improve error message when stork is not running on the application cluster |
| PB-453 | UI: Namespace selection list must be persistent when the user switches between tabs |
| PB-451 | UI: Goole credential creation: Give an option to upload the json file |
| PB-444 | UX: It should be made clear in the UI that that Kubeconfig can be pasted OR can be uploaded from a file |
| PB-435 | Warning message to user to indicate that backup that belongs to deleted backuplocation will also be deleted. |
| PB-507 | A cluster with a status of **Inactive** is now highlighted when the cluster is down for improved visibility. |
| PB-500 | The field labels in the **Add cloud account** page have been improved. |
| PB-467 | Backsync should avoid printing error while processing Backup location with out bucket. |
-->

## 1.0

April 30, 2020

### New features

Announcing PX-Backup, a Kubernetes backup solution that allows you to back up and restore applications and their data across multiple clusters.

PX-Backup includes:

* Point-and-click recovery for any Kubernetes app—stateless or stateful
* Fast recovery for applications, including restoring their configuration and data
* Pod, tag, and namespace granularity for any backup
* Policy-driven scheduled backups 
* Continuous backups across multiple clouds and global data centers
* Complete protection for applications, configurations, and data
* Application-consistent backup and restore
* Backup and recover cloud volumes from AWS, Azure, and GCP, even if you are not using PX-Store
* Built-in multi-tenancy for enterprises via industry-standard OIDC integration

<!-- 
## 1.0

Month day, 2020

### New features

 * 

### Improvements

Portworx, Inc. has upgraded or enhanced functionality in the following areas:

| **Improvement Number** | **Improvement Description** |
|----|----|


### Fixes

Portworx, Inc. has fixed the following issues:

|**Issue Number**|**Issue Description**|
|----|----|


### Known Issues
Portworx, Inc. is aware of the following issues, check future release notes for fixes:

|**Issue Number**|**Issue Description**|**Workaround**|
|----|----|----| -->





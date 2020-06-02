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
| PB-515 | Users can now add and edit a cluster to Lighthouse independently from PX-Backup. |
| PB-389 | The App View page now includes a refresh button, allowing you refresh the list. |
| PB-485 | The credential settings page now includes info icons explaining what should be entered into the input fields. |
| PB-480 | The **Remove** button no longer appears when there is no entry in the pod selector during Rule creation. |
| PB-479 | When a backup deletion is pending, PX-Backup no longer shows a restore option. |
| PB-455 | An improved error message now displays when Stork is not installed on the application cluster. |
| PB-453 | Selections on the namespace selection list now persist when you switch between tabs. |
| PB-451 | When adding a Google cloud account, you can now upload your json key using the file browser. |
| PB-444 | Improved clarity around options for pasting or uploading your kubeconfig on the **Add Cluster** page. |
| PB-435 | A new warning message now indicates that any backups that belong to a deleted backuplocation will also be deleted. |
| PB-507 | A cluster with a status of **Inactive** is now highlighted when the cluster is down for improved visibility. |
| PB-500 | The field labels in the **Add cloud account** page have been improved. |


### Fixes

Portworx, Inc. has fixed the following issues:

|**Issue Number**|**Issue Description**|
|----|----|
| PB-534 | Clusters could be added to PX-Backup using credentials that did not have adequate permissions.<br/><br/>**User Impact:** PX-Backup would not be able to display data or perform operations properly.<br/><br/>**Resolution:** Cluster addition now fails if credentials do not have all of the required permissions. |
| PB-519 | It was possible to attempt to add a backup location before adding a cloud account. <br/><br/>**User Impact:** Despite seeing the **+ Add** option, users would not be able to add a backup location.<br/><br/>**Resolution:** Users must now add a cloud account before seeing the option to add a backup location. |
| PB-400 | When editing a backup schedule, the existing pre-exec and post-exec rules did not appear in the dialog box.<br/><br/>**User Impact:** Users would have to reselect their pre-exec and post-exec rules when they edited an existing backup schedule.<br/><br/>**Resolution:** PX-Backup now lists the existing pre-exec and post-exec rules when a user edits a backup schedule. |
| PB-307 | Restores from subsequent backups stored on different buckets from the original that both involve the same namespace failed. <!-- this is tough to explain and I'm not sure I got it right. -->  <br/><br/>**User Impact:** If users created multiple backups and buckets, restores from subsequent backups stored on different buckets from the original that both involve the same namespace failed.<br/><br/>**Resolution:** PX-Backup now properly takes the initial backup for incremental backups, even when they share a namespace with other backups using different buckets. |
| PB-499 | When PX-Backup failed to create a backup, the reason for the failure did not propagate to the UI correctly, showing only the creation failure message. <br/><br/>**User Impact:**  Due to the stuck message, users may have been unable to see the real reason for a backup deletion failure.<br/><br/>**Resolution:** Creation failure messages no longer stick, allowing users to see more recent messages. |
| PB-493 |The PX-Backup UI did not update to reflect invalid underlying backup object statuses.<br/><br/>**User Impact:** If a backup object was deleted, users may still have seen the backup appear as valid on the PX-Backup UI.<br/><br/>**Resolution:** PX-Backup now properly displays the invalid backup status. |
| PB-468 | After the trial license expired, there was no way to let the user know that they had more clusters online on PX-Backup than the license supported until the backup failed.<br/><br/>**User Impact:** Users would not know they have more cluster than the license supports until their backup or restore failed. <br/><br/>**Resolution:** PX-Backup now displays a message on the home screen to let the users know that they need to remove some clusters if they have more clusters than their license supports. |
| PB-395 | The PX-Backup app view took a long time to load when multiple namespaces were selected. <br/><br/>**User Impact:** Users selecting a large number of namespaces in the app view would either not see, or have to wait a long time for resources to appear <br/><br/>**Resolution:** PX-Backup now loads resources for multiple namespaces faster. |
| PB-486 | When a user deleted a backup, PX-Backup did not update the reason.<br/><br/>**User Impact:** Users may have seen confusing information about their backup status during deletion<br/><br/>**Resolution:** PX-Backup now shows an appropriate message indicating volumes and resources are being deleted. |
| PB-477 | The `enter` key did not work in search box on the **All backups** page. <br/><br/> **User Impact:** Users couldn't filter their results on the **All backups** page using the search box. <br/><br/>**Resolution:** The search box now filters results when a user inputs a term and presses `enter`. | 

<!-- need more info
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





---
title: Release notes
description: See the latest changes associated with recent releases.
keywords: Release notes
weight: 11
hidesections: true
disableprevnext: true
series: backup
---


## 1.1.0

Sep 23, 2020


### New features

* If you add a new cluster using the CLI or API, PX-Backup now displays your cluster in the UI.
* Added a separate Lighthouse view. <!-- Shall we link out to the PX-Central page-->

### Improvements

| **Improvement Number** | **Improvement Description** |
|----|----|
| PB-783 | PX-Backup now validates the bucket name field in the **Add Backup Location** view. |
| PB-831 | PX-Backup now displays the resources in alphabetical order in the **Create Backup** view. |
| PB-762 | When a backup schedule is in the delete pending state, PX-Backup no longer displays the remove, suspend, or edit options. |
| PB-837 | When a backup location is in the delete pending state, PX-Backup no longer displays the remove option. |
| PB-640 | The **Backups** view now features a progress bar indicating the progress of your backup operations. |
| PB-682 | The **Backup Rules** page now includes a help message explaining pre and post backup rules. |
| PB-680 | Persistent volumes no longer appear in the **Restore Backup** view |
| PB-706 | Improved validation rules for the field that specifies the number of scheduled backups that PX-Backup retains. |
| PB-699 | The **Restores** view now features a progress bar indicating the progress of your restore operations. |
| PB-671 | PX-Backup now displays the backup size for each namespace in the **Restore Backup** view. |
| PB-478 | When a backup is in the delete or delete pending state, PX-Backup no longer displays the **View json** and **Show Details** options. |
| PB-302 | PX-Backup now automatically validates backup locations when the users add them. |
| PB-634 | Users can now filter resources by resource type. |
| PB-747 | Administrators can now share backup locations with other users without disclosing the credentials or the bucket name by setting a backup location as the default backup location. <!-- TODO: Revisit this -->|
| PB-768 | Users can now delete a resource without being prompted for the name of that resource. |
| PB-636 | Improved clarity around the `OrgID` field in the **Add License** view. |
| PB-645 | In the **Edit Backup Schedule View**,  you can now use a navigation link to go to the **Schedule Policy** view. |
| PB-710 | Added a tooltip showing whether a backup schedule is being deleted. |
| PB-509 | When your Keycloak token expires, PX-Backup now redirects you to the login page. |
| PB-664 | PX-Backup now displays the status of a cluster as `Inactive`, even if the cluster has been deleted or is not reachable. |
| PB-712 | Every time you update the cluster configuration, PX-Backup validates whether the cluster is accessible. |
| PB-637 | If your license expires, PX-Backup pauses all scheduled backups until you apply a new license. |
| PB-654 | PX-Backup now generates license files without prompting the user for the org name. <!-- Is this correct? --> |
| PB-775 | PX-Backup now validates bucket names. |

### Fixes

Portworx, Inc. has fixed the following issues:

|**Issue Number**|**Issue Description**|
|----|----|
| PB-629 | Users were unable to log out and log in as a different user. </br></br> **User impact:** They were seeing an error message saying "You are already authenticated as different user <username> in this session. Please log out first." </br></br> **Resolution:** Users can low log out and log in as a different user. |
| PB-686 | If you provide an HTTP endpoint in the backup location field, sync backup fails. <!-- I don't get this, what is is a "sync backup"? --></br></br> **User impact:** PX-Backup displays the following error: "Access Denied." </br> </br> **Resolution:** Sync backup now works, even if you provide an HTTP endpoint. |
| PB-608 | Middleware not able to establish a connection with backup because the grpc connection was not closed. <br/><br/> **User impact:** Because of this issue, PX backup was marked as offline. <br/><br/> **Resolution:** Users will no longer see PX-backup marked as `offline` due to the middleware not being able to establish a connection with PX-Backup. | <!-- We already release noted this JIRA in 1.0.2, but I don't really understand it... -->
| PB-664 | If a backup schedule is associated with an inactive cluster, users can not remove the cluster from PX-Backup. </br></br> **User impact:** PX-Backup displays an error message saying that the user can not delete the cluster. </br></br> **Resolution:**  The users can now select the inactive cluster and perform all operations except triggering a new backup. |
| PB-744 | Sometimes, the **All backups** view did not show any backups, even if the users created multiple backups. </br></br> **User impact:** They could not see their backups in the **All backups** views. <br/><br/> **Resolution:** PX-Backup now shows all backups in the **All backups** view. |


## 1.0.2

July 28, 2020

### Improvements

Portworx, Inc. has upgraded or enhanced functionality in the following areas:

| **Improvement Number** | **Improvement Description** |
|----|----|
| PB-621 |	Generic CRD support: PX-Backup now shows CRs in the application view. You must use Stork 2.4.3 or greater on the application cluster. |
| PB-574 | Added support for backing up namespace quotas |
| PB-573 | Added support for the kubectl oidc authenticator |
| PB-565 | Provided an option to copy the json output from the **Inspect Data** pane |
| PB-539 | PX-Backup now displays the orgID in the user's profile page |
| PB-464 | The scheduled backups settings now use a 12-hour clock |
| PB-609 | The tooltip now shows the reason for PX-Backup being marked offline when you hover over it |
| PB-584 |	The restore view now features a progress bar |
| PB-576 |	The backup view now features a progress bar |
| PB-575 |	Added a help message to explain the **Path / Bucket** field in the backup location screen |
| PB-572 |	PX-Backup now reads the OIDC admin secret into a user-provided namespace instead of the PX-Backup namespace.


### Fixes

Portworx, Inc. has fixed the following issues:

|**Issue Number**|**Issue Description**|
|----|----|
| PB-627 | Backup location, schedules, pre, and post rule dropdowns showed only 10 entries, even if there were more. <br/><br/> **User impact:** If they had more than 10 entries, users couldn't access them from the dropdowns. <br/><br/> **Resolution:** PX-Backup now shows all results in these dropdowns. |
| PB-623 |	Users were unable to delete restore jobs that were in the pending state. <br/><br/> **Resolution:** Users can now delete pending restore jobs. |
| PB-610 | Due to a race condition between the schedule delete and reconciler status updates, PX-Backup did not delete backup schedules when prompted to. <br/><br/> **Resolution:** PX-Backup now properly deletes backup schedules. |
| PB-608 | Middleware not able to establish a connection with backup because the grpc connection was not closed. <br/><br/> **User impact:** Because of this issue, PX backup was marked as offline. <br/><br/> **Resolution:** Users will no longer see PX-backup marked as `offline` due to the middleware not being able to establish a connection with PX-Backup. |
| PB-599 | Stork continuously retried to update the backup/restore resources when PX-Backup marked a job as failed. <br/><br/> **User impact:** In some cases, Stork would eventually mark the backup CR as successful, but PX-backup would continue to show it as failed. <br/><br/> **Resolution:** PX-backup now accurately reflects the backup CR's status. |
| PB-590 |	Cloud credential information was displayed in plain text in the logs and in the **View JSON** option. <br/><br/> **Resolution:** PX-Backup no longer displays credential information in these places. |
| PB-579 |	Restore jobs sometimes became stuck in the pending state. <br/><br/> **User impact:** Users would see these restore jobs sit in the `pending` state in the PX-Backup UI and never converge to a `failed` state. <br/><br/> **Resolution:** If the restore job is stuck in a `pending` state, it will eventually be marked as failed after the timeout period. |
| PB-578 |	Backup entries were not deleted from the PX-Backup UI when backup sync was in progress and the backup location was deleted <br/><br/> **User impact:** Users would see backup entries from a backup location that was removed from PX-backup UI. <br/><br/> **Resolution:** PX-Backup now deletes these backup entries. |
| PB-569 |	"Successfully" is no longer misspelled in the Restore status dialog. |
| PB-552 |	PX-Backup failed to indicate that users must have admin privileges when adding a Portworx cluster. <br/><br/> **User impact:** Users may not have known why they couldn't add a Portworx cluster. <br/><br/> **Resolution:** In the Portworx endpoint section, a message now indicates that admin account privileges are needed for to add a Portworx cluster for monitoring. |
| PB-541 |	Clusters with PX-Backup disabled were listed on the dropdown in the PX-Backup dashboard <br/><br/> **User impact:** Users may have been confused by these erroneous listings <br/><br/> **Resolution:** PX-Backup no longer lists clusters with PX-Backup disabled. |
| PB-384 |	PX-Backup picked up the existing token when users signed out and attempted to sign in <br/><br/> **User impact:** Users would be directly signed-in when they attempted to log back in and could not switch users if desired. <br/><br/> **Resolution:** PX-Backup now redirects users to the sign-in page after logging out. |
| PB-607 |	It was possible to enter decimal numbers into the schedule dialog. <br/><br/> **Resolution:** The schedule dialog no longer accepts decimal numbers as input. |

## 1.0.1

June 5, 2020

### Improvements

Portworx, Inc. has upgraded or enhanced functionality in the following areas:

| **Improvement Number** | **Improvement Description** |
|----|----|
| PB-547 | PX-Backup now allows more than 12 backups to be retained while creating a schedule. |
| PB-515 | Users can now add a cluster to Lighthouse and and edit it independently from PX-Backup. |
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





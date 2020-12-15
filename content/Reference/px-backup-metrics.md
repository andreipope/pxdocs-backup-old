---
title: PX-Backup metrics
description: PX-Backup metrics
keywords: monitoring, metrics
weight: 12
disableprevnext: true
scrollspy-container: false
---

Scraping endpoint : `http://px-backup-svc-endpoint:<rest_port (default:10001)>/metrics`.

| Name | Description | Type  | Labels | Value |
| --- | --- | --- | --- | --- |
| | | | | |
| pxbackup_backup_status | Status for backups in PX-Backup | Gauge | `name`=backup name</br> `namespaces`=comma separated backup namespaces </br> `user_id`=userid for backup </br> `schedule_name`= name of backup schedule associated with backup | `Invalid` = 0 </br> `Pending` = 1 </br> `InProgress` = 2 </br> `Aborted` = 3 </br> `Failed` = 4 </br> `Deleting` = 5 </br> `Success` = 6 </br> `Captured` = 7 </br> `PartialSuccess` = 8 </br> `DeletePending` = 9|
| pxbackup_backup_size_bytes | Size in bytes of backups in PX-Backup | Gauge | `name`=backup name </br> `namespaces`=comma separated backup namespaces </br> `cluster`=name of cluster on which backup is taken </br> `user_id`=userid for backup </br> `schedule_name`= name of backup schedule associated with backup | Size of backup in bytes |
| pxbackup_backup_duration_seconds | Completion duration in seconds for backups in PX-Backup backup schedules | Gauge | `name` = backup name </br> `namespaces` = comma separated backup namespaces </br> `cluster` = name of cluster on which backup is taken </br> `user_id` =userid for backup | `schedule_name` = name of backup schedule associated with backup | Duration of backup in seconds |
| pxbackup_backup_volume_count | Volume count for backups in PX-Backup | `name` = backup name </br> `namespaces` = comma separated backup namespaces </br> | `cluster` = name of cluster on which backup is taken </br> `user_id` = userid for backup | `schedule_name` = name of backup schedule associated with backup | Number of volume in backup |
| pxbackup_backup_resource_count | Resource count for backups in PX-Backup | Gauge | `name`= backup name </br> `namespaces` = comma separated backup namespaces </br> `cluster` = name of cluster on which backup is taken </br> `cluster` = name of cluster on which backup is taken </br> `schedule_name` = name of backup schedule associated with backup | Number of resources in backup |
| pxbackup_backup_schedule_status | Status of backup schedules in PX-Backuprestores created/initiated by user | Gauge | `name` = backup schedule </br> `namespaces` = comma separated backup schedule namespaces </br> `cluster` = name of cluster on which backup schedule is started </br> `user_id` = userid for backup schedule | `Active` = 0 </br> `Suspended/Deactive` = 1 |
| pxbackup_backuplocation_metrics | Count of backuplocations in PX-Backup | Gauge | `name` = name of backup location </br> `user_id` = userid for backup location | 1 |
| pxbackup_cloudcred_metrics | Count of cloudcredentials configured in PX-Backup | Gauge | `name` = name of Cloud Cred </br> `user_id` = userid for cloudCred | `Invalid` = 0 </br> `AWS` = 1 </br> `Azure` = 2 </br> `Google` = 3 |
| pxbackup_cluster_status | Count of clusters in PX-Backup | Gauge | `name` = name of cluster </br> `user_id` = userid for cluster | `Invalid` = 0 </br> `Online` = 1 </br> `Offline` = 2 </br> `DeletePending` = 3 |
| pxbackup_restore_status | Status for restores in PX-Backup | Gauge | `name` = restore name </br> `namespaces` = comma separated restore namespaces </br> `cluster` = name of cluster on which restore is started </br> `user_id` = userid for restore | `Pending` = 0 </br> `Pending` = 1 </br> `InProgress` = 2 </br> `Aborted` = 3 </br> `Failed` = 4 </br> `Deleting` = 5 </br> `Success` = 6 </br> `Retained` = 7 </br> `PartialSuccess` = 8 |
| pxbackup_restore_size_bytes | Size in bytes of restores in PX-Backup | Gauge | `name` = restore name </br>`namespaces` = comma separated restore namespaces </br> `cluster` = name of cluster on which restore is initiated </br> `user_id` = userid for restore | Size in bytes for restore |
| pxbackup_restore_duration_seconds | Completion duration in seconds for restore in PX-Backup | | `name` = restore name </br> `namespaces` = comma separated restore namespaces </br> `cluster` = name of cluster on which restore is initiated </br> `user_id` = userid for restore | Duration in seconds for restore |
| pxbackup_restore_volume_count | Volume count for restores in PX-Backup |  | `name` = restore name </br> `namespaces` = comma separated restore namespaces </br> `cluster` = name of cluster on which restore is initiated </br> `user_id` = userid for restore | Count of restored volumes |
| pxbackup_restore_resource_count | Resource count for restores in PX-Backup | | `name` = restore name </br> `namespaces` = comma separated restore namespaces </br> `cluster` = name of cluster on which restore is initiated </br> `user_id` = userid for restore | Count of restored application resources |
| pxbackup_schedpolicy_metrics | Count of schedule policies in PX-Backup | | `name` = restore name </br> `user_id` = userid for restore | 1 |
| pxbackup_rule_metrics | Count of rule objects in PX-Backup | | `name` = restore name </br> `user_id` = userid for restore | 1 |

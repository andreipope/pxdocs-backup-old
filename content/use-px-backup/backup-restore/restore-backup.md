---
title: Restore from a backup
keywords:
weight: 6
hidesections: true
disableprevnext: true
---

You can restore backups to the cluster you created it from, or to a new cluster.

{{<info>}}
**NOTE:** PX-Backup does not support restoring of backed up data stored in storage classes for archiving such as Amazon S3 Glacier or Google Nearline Storage.
{{</info>}}

1. From the home page, select your cluster:

    ![Select your cluster](/img/cluster-backups.png)

    <!-- ![](/img/backup-menu.png) -->

    <!-- The PX-Backup dashboard shows all of your backup operations divided into three categories: failed, in-progress, success.

    Alternatively, select the  **All backups** link now from which you can list all the backups available across your backup locations. You can restore from the enteries here as well. -->

    <!-- ![](/img/restore-all.png) -->

    <!-- Select the **Backup** button associated with your cluster: -->

    <!-- ![](/img/cluster-backups.png) -->

    <!-- Each cluster shows a list of all the backups created with an option to view the details and restore the backup -->

2. Select the **Backups** tab to view a list of all the backups:

    ![Show the backups tab](/img/show-the-backups-tab.png)

3. Select the vertical menu icon from the successful backup you wish to restore, followed by the **Restore** option.

    ![Select the backup](/img/select-backups.png)

4. From the dialog box, specify the following:

    * **Name**: name your restore object. You’ll use this to identify the restore operation in the PX-Central UI.
    * **Destination cluster**: select the cluster you want to restore your backup to. This can be a different cluster from where the backup occurred.
    * **Default restore**: PX-Backup restores backups to the same namespaces they were taken from.
    * **Custom restore**: You can deselect source namespaces using the checkbox on the left. If you deselect a namespace, content from that namespace will not be restored.
        * **Dest namespace**: specify a namespace on the target cluster you want to restore this backup to. If the namespace does not exist, PX-Backup will try to create it.
    * **Replace existing resources**: replaces any matching existing resources with the content from this backup.

    ![Custom restore](/img/restore-custom.png)

Once you've restored your backup, you can [monitor its status](/use-px-backup/backup-restore/monitor-status).

### Related Videos

  {{< youtube EU-WGNaH7p0 >}}

<!--
## Search for set of backups based on dates and restore from them

1. From the PX-Central home page, select the **Backup** button for the cluster you want to restore from:

    ![](/img/select-backup.png)

2. Select the **Backups** tab:

3. Select the calendar icon in the upper left portion of the page:

    ![](/img/select-date.png)

4. Define a range of backups you want to see. The list of available backups will filter on this date range:

5. Select the vertical menu icon from the successful backup you wish to restore, followed by the **Restore** option.

6. From the dialog box, specify the following:

    * **Name**: name your restore object. You’ll use this to identify the restore operation in the PX-Central UI.
    * **Destination cluster**: select the cluster you want to restore your backup to. This can be a different cluster from where the backup occurred.
    * **Default or Custom restore**:
        <!-- Custom restore allows the user to map the namespaces between their source and destination cluster. They can choose to restore it to a new namespace (different from the source cluster)
        * Under a default restore, PX-Backup restores backups to the same namespace they were taken from
        * You can deselect source namespaces using the checkbox on the left. If you deselect a namespace, content from that namespace will not be restored.
    * **Dest namespace**: specify a namespace on the target cluster you want to restore this backup to
    * **Replace existing resources**: replaces any matching existing resources with the content from this backup. Note that this does not replace any existing resources on other namespaces. -->

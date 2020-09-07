---
title: Create a backup
description:
keywords:
weight: 5
hidesections: true
disableprevnext: true
series2: get-started
---

Once you’ve created any backup rules and schedule policies you want, you can use them to create a backup.

1. From the home page, select the **Backup** the cluster you want to back up:

    ![Select cluster](/img/select-backup.png)

2. Select the namespaces and apply label selectors to filter the resources you want to back up:

    ![Select namespaces and labels](/img/select-namespace-labels.png)


    {{<info>}}
**NOTE:**

* To back up all namespaces, choose **Select All**
* To back up all namespaces and the namespaces created after you created this backup, choose **Select All** and then select **Include any new namespaces created**
    {{</info>}}

3. Select the **Backup** button:

    ![Select create backup](/img/select-create-backup.png)

4. From the dialog box, specify the following:

    * **Backup name**: the name of the backup you want displayed in the PX-Backup UI
    * **Backup location**: which bucket you want to store your backups onto
    * **Now** or **On a schedule**: run the backup immediately or choose a schedule policy to associate with this backup
    * **Pre-exec rule**: any rules you want to execute before the backup runs
    * **Post-exec rule**: any rules you want to execute after the backup runs
    * **Backup labels**: any labels you want to attach to the backup once it's created

    ![Populate backup fields](/img/populate-backup-fields.png)

Once you've created your backup, you can [monitor its status](/use-px-backup/backup-restore/monitor-status).

### Related Videos

  {{< youtube dhXwL9kOC0A >}}

  {{< youtube 0N5axHG_QBc >}}

<!--
## Perform a namespace-level backup



## Perform an app-level backup -->

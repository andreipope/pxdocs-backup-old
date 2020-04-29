---
title: Restore a backup
keywords: 
weight: 6
hidesections: true
disableprevnext: true
---

You can restore backups to the cluster you created it from, or to a new cluster. 

1. From the PX-Central home screen, select the PX-Backup icon on the left menu bar. The PX-Backup screen shows all of your backup operations divided into three categories: failed, in-progress, success.
    <!-- This is the dashboard view. Restores can also be triggered from the px-backup/<application cluster> screen as well. 
    Also there is an "All backups" link now from which you can list all the backups in the bucket mentioned in the backup location. You can restore from the enteries here as well. -->
2. Select the vertical menu icon from the successful backup you wish to restore, followed by the **Restore** option.
3. From the dialog box, specify the following:
    
    * **Name**: name your restore object. You’ll use this to identify the restore operation in the PX-Central UI.
    * **Destination cluster**: select the cluster you want to restore your backup to. This can be a different cluster from where the backup occurred.
    * **Default or Custom restore**: 
        <!-- Custom restore allows the user to map the namespaces between their source and destination cluster. They can choose to restore it to a new namespace (different from the source cluster) -->
        * Under a default restore, PX-Backup restores backups to the same namespace they were taken from
        * You can deselect source namespaces using the checkbox on the left. If you deselect a namespace, content from that namespace will not be restored. 
    * **Dest namespace**: specify a namespace on the target cluster you want to restore this backup to
    * **Replace existing resources**: replaces any matching existing resources with the content from this backup. Note that this does not replace any existing resources on other namespaces.

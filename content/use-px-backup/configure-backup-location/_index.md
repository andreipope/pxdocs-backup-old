---
title: Configure a backup location
description: 
keywords: 
weight: 3
hidesections: true
disableprevnext: true
series2: get-started
---

1. From the home page, select **Settings**, **Cloud Settings** to open the cloud settings page.

    ![cloud settings](/img/cloud-settings.png)

2. Under **Backup Locations**, select **Add New**.

    ![add new backup location](/img/add-new-backup-location.png)

3. Populate the fields:

    * **Name**: specify the name with which backup location will show in PX-Central
    * **Cloud Account**: choose the cloud account credentials that this backup location will use to create backups
    * **Path**: specify the path of the bucket that this backup location will place backups into
    * **Encryption key** _(Optional)_: enter the optional encryption key to encrypt your backups in-transit
    * **Endpoint**: with the URL of your cloud storage server or provider
    * **Disable SSL**: select this option if your on-prem S3-compliant object store does not support SSL/TLS

    ![configre backup location](/img/config-backup-location.png)


  
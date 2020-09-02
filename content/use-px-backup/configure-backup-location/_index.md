---
title: Configure a backup location
description:
keywords:
weight: 3
hidesections: true
disableprevnext: true
series2: get-started
---

1. From the home page, select **Settings**, **Cloud Settings** to open the cloud settings page:

    ![Cloud settings](/img/cloud-settings.png)

2. In the **Backup Locations** section, select **Add**:

    ![Add new backup location](/img/add-new-backup-location.png)

3. Populate the following fields:

    **AWS users**

    * **Name**: specify the name with which backup location will show in PX-Backup
    * **Cloud Account**: choose the cloud account credentials that this backup location will use to create backups. This example uses an AWS account.
    * **Path / Bucket**: specify the path of the bucket or the name of the bucket that this backup location will place backups into
    * **Encryption key** _(Optional)_: enter the optional encryption key to encrypt your backups in-transit
    * **Region**: with the name of your AWS region
    * **Endpoint**: with the URL of your cloud storage server or provider
    * **Disable SSL**: select this option if your on-prem S3-compliant object store does not support SSL/TLS
    * **Storage class**: choose the S3 storage class your cloud backups will use

    ![Configure a backup location](/img/config-backup-location-aws.png)

4. Select the **Add** button

<!-- What is the `default` storage class? -->

<!-- The cluster is down, I can't take screenshots
    **Azure Users**


    **Google Cloud Users**

-->

### Related Videos

  {{< youtube S4Y8_SrgFsA >}}
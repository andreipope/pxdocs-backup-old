---
title: GCP
description:
keywords:
weight: 1
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
series2: get-started
series2_weight: 2
---

## Prerequisites

In GCP, create a **Compute Engine default** service account for use with your cluster. Modify the service account, adding **Read Write** access for each API. Save the JSON key for this service account for future reference.

## Add a GCP cloud account to PX-Backup

Perform the following steps to add a GCP cloud account to PX-Backup:

1. From the home page, select **Settings**, **Cloud Settings** to open the cloud settings page.

    ![Cloud settings](/img/cloud-settings.png)

2. Select **Add New**.

    ![Add a new cloud account](/img/add-new-cloud-account.png)

3. Choose **Google Cloud** from the drop-down list:

    ![Choose Google cloud](/img/choose-google-cloud.png)

4. Populate the fields in the **Add Cloud Account** page:

    * Create a descriptive account name
    * Paste the content of your JSON key for the service account associated with your GKE cluster, or select the **Browse** button to upload it from a file.

    ![Add a Google cloud account](/img/gcp-account-add.png)

5. Select the **Add** button
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

Perform the following steps to add a GCP cloud account to PX-Backup:

1. In GCP, create a **Compute Engine default** service account for use with your cluster. Modify the service account, adding **Read Write** access for each API. Save the JSON key for this service account for future reference.


2. From the home page, select **Settings**, **Cloud Settings** to open the cloud settings page.

    ![cloud settings](/img/cloud-settings.png)

3. Under the **Cloud Accounts** section, select **Add New**.

    ![add new cloud account](/img/add-new.png)

3. Populate the fields in the **Add Cloud Account** page:

    * Choose **Google Cloud**
    * Create a descriptive account name
    * add the JSON key for the service account associated with your GKE cluster
    * Select the **Add** button

    ![](/img/gcp-account-add.png)
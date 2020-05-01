---
title: AWS/S3 compliant object store
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

Perform the following steps to add an AWS cloud account to PX-Backup:

1. In AWS, create an IAM role with the following permissions:

* `ec2:CreateSnapshot`
* `ec2:CreateSnapshots`
* `ec2:DeleteSnapshot`
* `ec2:DescribeSnapshots`

{{<info>}}
**NOTE:** When you try to create a backup using the specified cloud account, make sure either the bucket is already created, or the credentials include permission to create the bucket
{{</info>}}

2. From the home page, select **Settings**, **Cloud Settings** to open the cloud settings page.

    ![cloud settings](/img/cloud-settings.png)

3. Under the **Cloud Accounts** section, select **Add New**.

    ![add new cloud account](/img/add-new.png)


4. Populate the fields in the **Add Cloud Account** page:

    * Choose **AWS / S3 Compliant Object Store**
    * Enter a descriptive account name
    * In the **Public Key** field, add your S3 access key ID
    * In the **Secret Key** field, add your S3 secret access key
    * Select the **Add** button

    ![](/img/aws-credential.png)
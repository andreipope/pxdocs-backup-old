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

## Prerequisites

In AWS, create an IAM role with the following permissions:

  * `ec2:CreateSnapshot`
  * `ec2:CreateSnapshots`
  * `ec2:DeleteSnapshot`
  * `ec2:DescribeSnapshots`

<!-- Should we move the following note to the "Create and restore backups" section? --->

{{<info>}}
**NOTE:** When you try to create a backup using the specified cloud account, make sure either the bucket is already created, or the credentials include permission to create the bucket
{{</info>}}

## Add an AWS cloud account to PX-Backup

Perform the following steps to add an AWS cloud account to PX-Backup:

1. From the home page, select **Settings**, **Cloud Settings** to open the cloud settings page:

    ![Cloud settings](/img/cloud-settings.png)

2. Select **Add**:

    ![Add new cloud account](/img/add-new-cloud-account.png)

3. Choose **AWS / S3 Compliant Object Store** from the drop-down list:

    ![Select AWS](/img/choose-aws-s3-compliant-object-store.png)

4. Populate the fields in the **Add Cloud Account** page:

    * Enter a descriptive account name
    * In the **Public Key** field, add your S3 access key ID
    * In the **Secret Key** field, add your S3 secret access key

    ![Populate the fields](/img/aws-credential.png)

5. Select the **Add** button
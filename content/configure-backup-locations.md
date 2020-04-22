---
title: Configure backup locations
description: 
keywords: 
weight: 4
hidesections: true
disableprevnext: true
---

1. Generate a key with your GCP or AWS provider. PX-Central uses this key to authenticate with your cloud provider and store and retrieve backup images from your cloud storage buckets. 
2. From the home page, select settings -> Cloud Settings to open the cloud settings page. From this page you’ll both configure a cloud account using the key you generated on step 1 and backup locations.
3. Under the Cloud Accounts section, select Add More.
4. Choose the appropriate cloud provider, and populate the fields with your key information:

    * Account Name: specify the name with which this account will show in PX-Central
    * For AWS:

        * Public Key: the public key credentials you generated on AWS in step 1
        * Secret Key: the secret key credentials you generated in AWS in step 1

5. Under Backup Locations, select Add More.
6. Populate the fields:

    * Name: specify the name with which backup location will show in PX-Central
    * Cloud Account: choose the cloud account credentials that this backup location will use to create backups
    * Path: specify the path of the bucket that this backup location will place backups into
    * Encryption key: enter the optional encryption key to encrypt your backups in-transit
    * Endpoint: with the URL of your cloud storage server or provider.
    * Disable SSL: 

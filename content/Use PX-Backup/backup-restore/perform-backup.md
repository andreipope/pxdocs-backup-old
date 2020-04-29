---
title: Perform a backup
description: 
keywords: 
weight: 5
hidesections: true
disableprevnext: true
---

Before you perform a backup, you must determine your backup requirements:

* What you want to back up
* Where you want your backups to go
* When you want backups to occur
* How you want backups to occur

Once you’ve defined your backup requirements, use the following two screens to configure PX-Backup to meet them:

* Set up a backup rule
* Schedule when the backup rule runs

Backup rules determine what you want to back up and where you want to send those backups. Schedules determine when and how the backups are triggered. 

Backup rules:

* A single backup rule can contain multiple sub-rules, each of which can contain multiple pod selectors and multiple actions. 
* A pod selector allows you to specify any label for pods in your cluster. You can use these with operators to include or exclude pods from your sub-rule. 
* Actions allow you to specify commands you want to run… Depending on your selectors...





## Associate a backup rule and schedule

Once you’ve created a backup rule and schedule, you can use them to create a backup. 

1. From the PX-Central home page, select the **Backup** button for the cluster you want to back up.
2. Select the namespace and any labels you want to back up
3. Select the **Create Backup** button
4. From the dialog box, specify the following:
    
    * **Backup name**: the name of the backup you want displayed in the PX-Backup UI
    * **Destination location**: which bucket you want to store your backups onto
    * **Schedule**: Run the backup immediately or choose a schedule rule to associate with this backup
    * **Pre-exec rule**: any rules you want to execute before the backup runs
    * **Post-exec rule**: any rules you want to execture after the backup runs
    * **Backup labels**: any labels you want to attach to the backup once it's created


## Perform a namespace-level backup

## Perform an app-level backup

## Search for set of backups based on dates and restore from them
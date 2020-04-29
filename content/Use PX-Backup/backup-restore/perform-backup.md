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

## Create a backup rule

1. From the PX-Central dashboard, select **Settings**, **Rules**
2. Select the **+** icon in the upper right corner
3. Build your rule by populating the fields:
    
    * **Rule Name**: Enter a descriptive name for your rule
    * **Pod selector**: Enter any label selectors based on your pod’s labels. For example, `app = mysql` uses the app label to select pods running `mysql`. Use any of the equality-based selector operators. 
    * **Action**: Enter any commands you want to execute when the rule is triggered. 
    * **Background**: Enable this if you want the rule to run in the background.
    * **Run in single pod**: 

4. Select the **+ Add** icon to add more sub-rules
5. Select the **Add** button to create the rule

Once you’ve created a rule, you’re ready to associate it with a backup.

## Create a schedule

1. From the PX-Central dashboard, select **Settings**, **Schedules**
2. Select the **+** icon in the upper right corner
3. From the Add Policy dialogue box, name your policy and select a type:
    * **Periodic**: A periodic policy runs at fixed intervals defined in minutes and hours. 
    * **Daily**: Runs every day at a specified time. Provide the hours and minutes from midnight to define the time. 
    * **Weekly**: Runs once a week on the specified day and time.
    * **Monthly**: runs on a specified day of the month. If the day given is longer than the current month, it will roll over to the next month. 
    * **Retain**: Select the number of backups to retain concurrently

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

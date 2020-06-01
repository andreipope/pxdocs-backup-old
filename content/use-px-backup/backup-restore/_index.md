---
title: Create and restore backups
description: 
keywords: 
weight: 9
disableprevnext: true
scrollspy-container: false
type: common-landing
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
* Actions allow you to specify commands you want to run.

Follow the tasks in this section to create and restore backups. 
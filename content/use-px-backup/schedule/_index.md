---
title: Create schedule policies
description:
keywords:
weight: 4
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

1. From the home page, select **Settings**, **Schedule Policies**:

    ![Go to schedule page](/img/goto-schedule-page.png)

2. Select **Add new**:

    ![Add new schedule policy](/img/add-new-schedule.png)

3. From the **Add Policy** dialogue box, name your policy and select a type:

    * **Periodic**: A periodic policy runs at fixed intervals defined in minutes and hours.
    * **Daily**: Runs every day at a specified time. Provide the hours and minutes from midnight to define the time.
    * **Weekly**: Runs once a week on the specified day and time.
    * **Monthly**: Runs on a specified day of the month. If the day given is longer than the current month, it will roll over to the next month.
    * **Retain**: Select the number of backups to retain concurrently
    * **Incremental count**: Specify the number of incremental backups between two full backups. This applies only to Portworx volumes.

    ![Add schedule policy dialogue](/img/policy-dialogue.png)

    {{<info>}}
**NOTE:** All schedule policies are executed on the connected application cluster's local time zone.
    {{</info>}}

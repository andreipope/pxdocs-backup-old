---
title: Create a backup schedule
description: 
keywords: 
weight: 1
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

1. From the PX-Central dashboard, select **Settings**, **Schedules**:

    ![go to schedule page](/img/goto-schedule-page.png)

2. Select **Add new**:

    ![](/img/add-new-schedule.png)

3. From the Add Policy dialogue box, name your policy and select a type:

    * **Periodic**: A periodic policy runs at fixed intervals defined in minutes and hours. 
    * **Daily**: Runs every day at a specified time. Provide the hours and minutes from midnight to define the time. 
    * **Weekly**: Runs once a week on the specified day and time.
    * **Monthly**: runs on a specified day of the month. If the day given is longer than the current month, it will roll over to the next month. 
    * **Retain**: Select the number of backups to retain concurrently

    ![](/img/policy-dialogue.png)

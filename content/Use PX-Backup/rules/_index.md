---
title: Create a backup rule
description: 
keywords: 
weight: 1
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

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
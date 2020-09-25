---
title: Create a backup rule
description:
keywords:
weight: 3
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

1. From the home page, select **Settings**, **Rules** to open the cloud settings page::

    ![Rules](/img/settings-rules.png)

2. Select **Add new**:

    ![Add backup rule](/img/add-rule.png)

3. Build your rule by populating the following fields:

    * **Rule Name**: Enter a descriptive name for your rule
    * **Pod selector**: Enter any label selectors based on your pod’s labels. For example, `app = mysql` uses the app label to select pods running `mysql`. Use any of the equality-based selector operators.
    * **Container** _(Optional)_: Enter the optional name of the container to which PX-Backup will apply the rule.
    * **Action**: Enter any commands you want to execute when the rule is triggered.
    * **Background**: Enable this if you want the rule to run in the background.
    * **Run in single pod**: Run this rule in a single pod.

    ![Populate backup rule](/img/populate-rule.png)

4. _(Optional)_: Select the **+ Add** icon to add more sub-rules:

    ![Add more sub-rules](/img/subrule.png)

5. Select the **Add** button to create the rule:

    ![Create the rule](/img/rule-add-button.png)

Once you’ve created a rule, you’re ready to associate it with a backup.

<!-- TODO: we should add a link -->
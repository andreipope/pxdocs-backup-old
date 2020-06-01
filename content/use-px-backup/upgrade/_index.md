---
title: Upgrade PX-Backup
description: Upgrade your version of PX-Backup
keywords: upgrade, 
weight: 8
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

Upgrade PX-Backup downloading and running a script which upgrades PX-Central on-premises:

1. Download the PX-Central install script and make it executable:

    ```text
    curl -o install.sh 'https://raw.githubusercontent.com/portworx/px-central-onprem/1.0.1/upgrade.sh' && chmod +x install.sh
    ```

2. Run the script with any of [the options](/use-px-backup/upgrade/upgrade-script-reference) required to upgrade PX-Central according to your needs:

    ```text
    ./upgrade.sh
    ```
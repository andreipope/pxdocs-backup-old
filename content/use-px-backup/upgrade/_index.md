---
title: Upgrade PX-Backup
description: 
keywords: 
weight: 8
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

## Perform the upgrade

Upgrade PX-Backup by entering the following command:

```text
curl 
```

## Upgrade script reference

--kubeconfig <Kubeconfig file>
--pxcentral-namespace <PX-Central-Onprem cluster namespace>
--pxcentral-upgrade-version <Version to upgrade PX-Central-Onprem>
--pxcentral-image-repo <Image repo for air-gapped deployment>

### examples

In the Onprem central 1.0.2 release, we have added upgrade script for central.
We will add to public repo before releasing in 1.0.2 branch, so the location of the script will be like:
https://raw.githubusercontent.com/portworx/px-central-onprem/1.0.2/upgrade.sh
Along with this, we need to add command reference:
1. Upgrade current running central to latest release:
./upgrade.sh
2. Upgrade current running central to specific release:
./upgrade.sh --pxcentral-upgrade-version 1.0.2
Specify Kube-config if it is not in the default directory:
./upgrade.sh --kubeconfig /root/.kube/config
./upgrade.sh --pxcentral-upgrade-version 1.0.2 --kubeconfig /root/.kube/config
Specify onprem central namespace if it is not running into default(portworx) namespace:
./upgrade.sh --pxcentral-namespace kube-system
./upgrade.sh --pxcentral-upgrade-version 1.0.2 --pxcentral-namespace kube-system

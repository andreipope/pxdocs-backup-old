---
title: PX-Backup upgrade script reference
description: Reference information for the PX-Backup upgrade script
keywords: upgrade, reference,
weight: 8
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

<!-- I don't think this is specific to backup, is it? we should puth this in the PX-Central on-prem docs. -->

```text
./upgrade.sh [options] '[arguments...]'
```

{{<info>}}
**NOTE:**  The script name `upgrade.sh` reflects the default name specified in the installation instructions, but can be whatever you named the script file when you downloaded it.
{{</info>}}

## Options

|**Option**|**Description**|**Required?**|
|----|----|----|
| `--kubeconfig ` | Kubeconfig file | No |
| `--pxcentral-namespace` | The namespace in which your PX-Central on-prem cluster exists | No |
| `--pxcentral-upgrade-version` | The desired version of PX-Central you want to upgrade to | No |
| `--pxcentral-image-repo` | The image repository for air-gapped deployments | No |

## Examples

* Upgrade the current running PX-Central to the latest release:

    ```text
    ./upgrade.sh
    ```

* Upgrade the current running PX-Central verision to a specific release:

    ```text
    ./upgrade.sh --pxcentral-upgrade-version 1.0.2
    ```

* Specify the Kubeconfig if it is not in the default directory:

    ```text
    ./upgrade.sh --kubeconfig /root/.kube/config
    ```

* Specify the PX-Central on-prem namespace, if it is not running in the default `portworx` namespace:

    ```text
    ./upgrade.sh --pxcentral-namespace kube-system
    ```
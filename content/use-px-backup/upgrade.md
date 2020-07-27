---
title: Upgrade PX-Backup
description: Upgrade your version of PX-Backup
keywords: upgrade,
weight: 10
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

To upgrade PX-Backup from an operator-based install to the Helm-based install introduced with 1.0.3, you must download, modify, and apply the following specs:

## Download the create_new_pvc_from_snapshot script

1. Download the `create_new_pvc_from_snapshot.yaml` spec:

    ```text
    curl -o create_new_pvc_from_snapshot.yaml https://github.com/portworx/helm/blob/chart_upgrade_specs/pxcentral-operator-to-chart-upgrade/create_new_pvc_from_snapshot.yaml
    ```

2. Change the following labels, specifying a name for your PX-Backup Helm installation and your current <!-- desired? --> PX-Backup version:
<!-- What is the name here? is it helm specific? I assume it's not namespace -->

    ```text
    app.kubernetes.io/name: <your-PX-Backup-name>
    app.kubernetes.io/version: <your-current-PX-Backup-version>
    ```

3. Change the following annotations, specifying:

    <!-- * need a description for each of these -->

    ```text
    meta.helm.sh/release-name: px-backup
    meta.helm.sh/release-namespace: portworx 
    stork.libopenstorage.org/snapshot-source-namespace: portworx
    ```

## Download the create_volume_snapshot_from_pvc script

1. Download the `create_volume_snapshot_from_pvc.yaml` spec: 

    ```text
    curl -o create_volume_snapshot_from_pvc.yaml https://raw.githubusercontent.com/portworx/helm/chart_upgrade_specs/pxcentral-operator-to-chart-upgrade/create_volume_snapshot_from_pvc.yaml
    ```

2. Edit the spec, changing all occurrences of the `namespace: portworx` field to the namespace in which your current on-prem PX-Central deployment exists.

## Upgrade you operator-based on-prem PX-Central deployment to the Helm chart method

1. Create a volume snapshot from existing PX-Central on-prem PVCs in the same namespace:
<!-- I don't understand what this sentence is trying to say -->

    ```console
    $ kubectl apply -f create_volume_snapshot_from_pvc.yaml
    ```

2. Verify that the volume snapshot for all PVCs is available in the same namespace:
<!-- I don't understand what this sentence is trying to say -->

    ```console
    $ storkctl get snapshot --namespace portworx
    ```
    <!-- What's the expected output here? I assume users should see the upgrade snapshot -->

3. Cleanup the existing px-central-onprem deployment using the cleanup script.

    * If the current PX-Central on-prem deployment is using an existing Portworx cluster for persistent storage, use following commands for cleanup:

    ```console
    $ curl -o px-central-cleanup.sh 'https://raw.githubusercontent.com/portworx/px-central-onprem/1.0.4/cleanup.sh'
    $ bash px-central-cleanup.sh
    ```

    * If the current Portworx cluster deployment is part of a PX-Central on-prem cluster, use following commands for cleanup:

    ```console
    $ curl -o px-central-cleanup.sh 'https://raw.githubusercontent.com/portworx/px-central-onprem/1.0.4/pxcentral-components-cleanup.sh'
    $ bash px-central-cleanup.sh
    ```

4. Create new PVCs from the volume snapshots you created in step 1 in the same namespace where PX-Central on-prem was originally deployed:

    ```console
    $ kubectl apply -f create_new_pvc_from_snapshot.yaml
    ```

5. Install PX-Backup using the helm chart:

    ```console
    $ helm repo add portworx http://charts.portworx.io/
    $ helm repo update
    $ helm install px-backup portworx/px-backup --namespace portworx --create-namespace --set persistentStorage.enabled=true,persistentStorage.storageClassName=stork-snapshot-sc,operatorToChartUpgrade=true,pxbackup.orgName=test,pxcentralDBPassword=singapore
    ```
    
    {{<info>}}
**NOTE:** In the helm install command above, mention the same organization name which was used in previous operator based install.
    {{</info>}}
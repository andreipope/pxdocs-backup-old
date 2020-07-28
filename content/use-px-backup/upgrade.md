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

To upgrade PX-Backup from an operator-based install to the Helm-based install introduced with 1.0.2, you must download, modify, and apply the following specs:

## Prerequisites

* You must have `storkctl` [installed](https://docs.portworx.com/portworx-install-with-kubernetes/disaster-recovery/px-metro/1-install-px/#install-storkctl) on your Portworx cluster

## Download the create_new_pvc_from_snapshot script

1. Download the `create_new_pvc_from_snapshot.yaml` spec:

    ```text
    curl -o create_new_pvc_from_snapshot.yaml https://github.com/portworx/helm/blob/chart_upgrade_specs/pxcentral-operator-to-chart-upgrade/create_new_pvc_from_snapshot.yaml
    ```

2. Change the `meta.helm.sh/release-namespace` annotation, specifying the namespace you installed PX-Central and PX-Backup onto originally:

    ```text
    meta.helm.sh/release-namespace: <original-px-backup-namespace> 
    ```

## Upgrade your operator-based on-prem PX-Central deployment to the Helm chart method

1. Download the `create_volume_snapshot_from_pvc.yaml` spec: 

    ```text
    curl -o create_volume_snapshot_from_pvc.yaml https://raw.githubusercontent.com/portworx/helm/chart_upgrade_specs/pxcentral-operator-to-chart-upgrade/create_volume_snapshot_from_pvc.yaml
    ```

2. Edit the spec, changing all occurrences of the `namespace: portworx` field to the namespace in which your current on-prem PX-Central deployment exists.

3. Apply the spec, creating a volume snapshot from the existing PX-Central on-prem PVCs in the namespace you provided in the previous step:

    ```console
    kubectl apply -f create_volume_snapshot_from_pvc.yaml
    ```

4.  Verify that the snapshots you've taken in the step above are intact and ready to be restored. Provide the namespace in which your current on-prem PX-Central deployment exists:

    ```console
    storkctl get snapshot --namespace <px-central-namespace>
    ```
    ```output
        NAME                                       PVC                                           STATUS   CREATED               COMPLETED             TYPE
    px-etcd-data-px-backup-etcd-0-snapshot     pxc-etcd-data-pxc-backup-etcd-0               Ready    28 Jul 20 01:29 UTC   28 Jul 20 01:29 UTC   local
    px-etcd-data-px-backup-etcd-1-snapshot     pxc-etcd-data-pxc-backup-etcd-1               Ready    28 Jul 20 01:29 UTC   28 Jul 20 01:29 UTC   local
    px-etcd-data-px-backup-etcd-2-snapshot     pxc-etcd-data-pxc-backup-etcd-2               Ready    28 Jul 20 01:29 UTC   28 Jul 20 01:29 UTC   local
    pxcentral-keycloak-postgresql-0-snapshot   pxc-keycloak-data-pxc-keycloak-postgresql-0   Ready    28 Jul 20 01:29 UTC   28 Jul 20 01:29 UTC   local
    pxcentral-mysql-pvc-snapshot               pxc-mysql-pvc                                 Ready    28 Jul 20 01:29 UTC   28 Jul 20 01:29 UTC   local
    theme-pxcentral-keycloak-0-snapshot        theme-pxc-keycloak-0                          Ready    28 Jul 20 01:29 UTC   28 Jul 20 01:29 UTC   local
    ```

5. Cleanup the existing px-central-onprem deployment using the cleanup script.

    * If the current PX-Central on-prem deployment is using an existing Portworx cluster for persistent storage, use following commands for cleanup:

    ```console
    curl -o px-central-cleanup.sh 'https://raw.githubusercontent.com/portworx/px-central-onprem/1.0.4/cleanup.sh'
    bash px-central-cleanup.sh
    ```

    * If the current Portworx cluster deployment is part of a PX-Central on-prem cluster, use following commands for cleanup:

    ```console
    curl -o px-central-cleanup.sh 'https://raw.githubusercontent.com/portworx/px-central-onprem/1.0.4/pxcentral-components-cleanup.sh'
    bash px-central-cleanup.sh
    ```

6. Create new PVCs from the volume snapshots you created in step 1 in the same namespace where PX-Central on-prem was originally deployed:

    ```console
    kubectl apply -f create_new_pvc_from_snapshot.yaml
    ```

7. Fetch the org name from your cluster, specifying the namespace in which your current on-prem PX-Central deployment exists:

    ```text
    kubectl get cm pxc-central-ui-configmap -o yaml -n <px-central-namespace> | grep PX_BACKUP_ORGID
    ```

7. Install PX-Backup using the Helm chart, specifying your own values for the following:

    * The `--namespace` flag with the namespace in which your current on-prem PX-Central deployment exists
    * As part of the `--set` flag, the `pxbackup.orgName=` parameter with your own org name that you fetched in the step above
    * The `oidc.centralOIDC.defaultUsername=` parameter with your PX-Central login ID
    * The `oidc.centralOIDC.defaultPassword=` parameter with your PX-Central password

    ```console
    helm repo add portworx http://charts.portworx.io/
    helm repo update
    helm install px-backup portworx/px-backup --namespace <px-central-namespace> --create-namespace --set persistentStorage.enabled=true,persistentStorage.storageClassName=stork-snapshot-sc,operatorToChartUpgrade=true,pxbackup.orgName=<orgName>,pxcentralDBPassword=singapore,oidc.centralOIDC.defaultUsername=<px-central-login>,oidc.centralOIDC.defaultPassword=<px-central-password>
    ```
    
    {{<info>}}
**NOTE:** In the Helm install command above, mention the same organization name which was used in previous operator based install.
    {{</info>}}
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

Depending on which version of PX-Backup you're running, the upgrade method you use will differ. Prior to version 1.0.2, PX-Backup used operator-based installs; versions 1.0.2 and newer use Helm-based installs. Perform the upgrade procedures appropriate for your version.

## Upgrade PX-Backup using Helm

Once you've moved from an operator-based install to a Helm-based install, you can upgrade using Helm.

### Prerequisites

* You must have PX-Backup with a Helm-based install

### Upgrade PX-Backup

Follow the steps in this section to upgrade PX-Backup using Helm.

1. Update your Helm repos:

    ```text
    helm repo update
    ```

2. Retrieve all custom values you used during install. Enter the following `helm get values` command to generate a YAML file, adjusting the values of the `<namespace>` and `<release-name>` parameters to match your environment:

    ```text
    helm get values --namespace <docs-namespace> <release-name> -o yaml > values.yaml
    ```

    ```
    oidc:
        centralOIDC:
            defaultPassword: examplePassword
            defaultUsername: exampleUser
    operatorToChartUpgrade: true
    persistentStorage:
        enabled: true
        storageClassName: px-sc
    pxbackup:
        orgName: exampleOrg
    pxcentralDBPassword: exampleDbPassword
    ```

    Note the following about this example output:

    * The `persistentStorage.storageClassName` field displays the name of your storage class (`px-sc`).
    * The `persistentStorage.enabled: true` field indicates that persistent storage is enabled.
    * The `pxbackup.orgName` field displays the name of your organization (`my-organization`)

3. Delete the post install hook job:

    ```text
    kubectl delete job pxcentral-post-install-hook --namespace <namespace>
    ```

4. Run the `helm upgrade` command, using the `-f` flag to pass the custom `values.yaml` file you generated above and replacing `<namespace>` with your namespace:

    ```text
    helm upgrade px-backup portworx/px-backup --namespace <namespace>  -f values.yaml
    ```

## Upgrade PX-Backup from an operator-based install

To upgrade PX-Backup from an operator-based install to the Helm-based install introduced with 1.0.2, you must download, modify, and apply the following specs:

### Prerequisites

* You must have `storkctl` [installed](https://docs.portworx.com/portworx-install-with-kubernetes/disaster-recovery/px-metro/1-install-px/#install-storkctl) on your Portworx cluster

### Download the create_new_pvc_from_snapshot script

1. Download the `create_new_pvc_from_snapshot.yaml` spec:

    ```text
    curl -o create_new_pvc_from_snapshot.yaml https://raw.githubusercontent.com/portworx/helm/chart_upgrade_specs/pxcentral-operator-to-chart-upgrade/create_new_pvc_from_snapshot.yaml
    ```

2. Change the `meta.helm.sh/release-namespace` annotation, specifying the namespace you installed PX-Central and PX-Backup onto originally:

    ```text
    meta.helm.sh/release-namespace: <original-px-backup-namespace>
    ```

### Upgrade your operator-based on-prem PX-Central deployment to the Helm chart method

1. Fetch the org name from your cluster, specifying the namespace in which your current on-prem PX-Central deployment exists:

    ```text
    kubectl get cm pxc-central-ui-configmap -o yaml -n <px-central-namespace> | grep PX_BACKUP_ORGID
    ```

2. Download the `create_volume_snapshot_from_pvc.yaml` spec:

    ```text
    curl -o create_volume_snapshot_from_pvc.yaml https://raw.githubusercontent.com/portworx/helm/chart_upgrade_specs/pxcentral-operator-to-chart-upgrade/create_volume_snapshot_from_pvc.yaml
    ```

3. Edit the spec, changing all occurrences of the `namespace: portworx` field to the namespace in which your current on-prem PX-Central deployment exists.

4. Apply the spec, creating a volume snapshot from the existing PX-Central on-prem PVCs in the namespace you provided in the previous step:

    ```text
    kubectl apply -f create_volume_snapshot_from_pvc.yaml
    ```

5.  Verify that the snapshots you've taken in the step above are intact and ready to be restored. Provide the namespace in which your current on-prem PX-Central deployment exists:

    ```text
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

6. Cleanup the existing px-central-onprem deployment using the cleanup script.

    * If the current PX-Central on-prem deployment is using an existing Portworx cluster for persistent storage, use following commands for cleanup:

        ```text
        curl -o px-central-cleanup.sh 'https://raw.githubusercontent.com/portworx/px-central-onprem/1.0.4/cleanup.sh'
        bash px-central-cleanup.sh
        ```

    * If the current Portworx cluster deployment is part of a PX-Central on-prem cluster, use following commands for cleanup:

        ```text
        curl -o px-central-cleanup.sh 'https://raw.githubusercontent.com/portworx/px-central-onprem/1.0.4/pxcentral-components-cleanup.sh'
        bash px-central-cleanup.sh
        ```

7. Create new PVCs from the volume snapshots you created in step 1 in the same namespace where PX-Central on-prem was originally deployed:

    ```text
    kubectl apply -f create_new_pvc_from_snapshot.yaml
    ```

8. Install PX-Backup using the Helm chart, specifying your own values for the following:

    * The `--namespace` flag with the namespace in which your current on-prem PX-Central deployment exists
    * As part of the `--set` flag, the `pxbackup.orgName=` parameter with your own org name that you fetched in the step above
    * The `oidc.centralOIDC.defaultUsername=` parameter with your PX-Central login ID
    * The `oidc.centralOIDC.defaultPassword=` parameter with your PX-Central password

    ```text
    helm repo add portworx http://charts.portworx.io/
    helm repo update
    helm install px-backup portworx/px-backup --namespace <px-central-namespace> --create-namespace --set persistentStorage.enabled=true,persistentStorage.storageClassName=stork-snapshot-sc,operatorToChartUpgrade=true,pxbackup.orgName=<orgName>,pxcentralDBPassword=singapore,oidc.centralOIDC.defaultUsername=<px-central-login>,oidc.centralOIDC.defaultPassword=<px-central-password>
    ```

    {{<info>}}
**NOTE:** In the Helm install command above, mention the same organization name which was used in previous operator based install.
    {{</info>}}


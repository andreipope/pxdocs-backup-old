---
title: Install PX-Backup
description: Get started with PX-Backup by installing it.
keywords:
weight: 2
hidesections: true
disableprevnext: true
series: backup
---

PX-Backup can be installed on any Kubernetes cluster using Helm charts as long as the pre-requisites are met. This can be one of your application clusters or a dedicated cluster. Since it's a multi-cluster backup solution, PX-Backup does not need to be installed on every cluster that will be backed-up. Instead, other clusters are simply added through the PX-Backup user interface.

## Prerequisites

* Stork 2.5.0 or newer
* If you're using an external OIDC provider, you must use certificates signed by a trusted certificate authority
* [Helm](https://helm.sh/docs/intro/install/)
* If you want to install PX-Backup on OpenShift using the `restricted` SCC, then you must add the service accounts used by PX-Backup to the `restricted` SCC. Execute the following `oc adm policy add-scc-to-user` commands, replacing `<YOUR_NAMESPACE>` with your namespace:

    ```text
    oc adm policy add-scc-to-user restricted system:serviceaccount:<YOUR_NAMESPACE>:default
    oc adm policy add-scc-to-user restricted system:serviceaccount:<YOUR_NAMESPACE>:pxcentral-apiserver
    oc adm policy add-scc-to-user restricted system:serviceaccount:<YOUR_NAMESPACE>:px-keycloak-account
    oc adm policy add-scc-to-user restricted system:serviceaccount:<YOUR_NAMESPACE>:px-backup-account
    ```

{{<info>}}
**NOTE:** PX-Backup does not support the following Portworx features:

* PX-Security
* Portworx Essentials
{{</info>}}

## Prepare air-gapped environments

If your cluster is internet-connected, skip this section. If your cluster is air-gapped, you must pull the following Docker images to either your docker registry, or your server:

* docker.io/portworx/px-backup:1.1.1
* docker.io/portworx/pxcentral-onprem-api:1.1.0
* docker.io/portworx/pxcentral-onprem-ui-backend:1.1.4
* docker.io/portworx/pxcentral-onprem-ui-frontend:1.1.4
* docker.io/portworx/pxcentral-onprem-ui-lhbackend:1.1.4
* docker.io/bitnami/etcd:3.4.7-debian-10-r14
* docker.io/portworx/pxcentral-onprem-post-setup:1.1.2
* docker.io/bitnami/postgresql:11.7.0-debian-10-r9
* docker.io/jboss/keycloak:9.0.2
* docker.io/portworx/keycloak-login-theme:1.0.2
* docker.io/library/busybox:1.31
* docker.io/library/mysql:5.7.22

## Install PX-Backup

1. If you're installing PX-Backup alone -- without {{< pxEnterprise >}} -- skip this step. If you do want to install PX-Backup with {{< pxEnterprise >}}, you must first [install Portworx](https://docs.portworx.com/portworx-install-with-kubernetes/), then create the following storage class on your Kubernetes cluster:

    ```text
    kind: StorageClass
    apiVersion: storage.k8s.io/v1
    metadata:
        name: portworx-sc
    provisioner: kubernetes.io/portworx-volume
    parameters:
        repl: "3"
    ```

2. Generate the install spec through the **PX-Backup** [spec generator](https://central.portworx.com/specGen/wizard).

     If you're using Portworx for the PX-Backup installation, select the **Use storage class** checkbox under the **Storage** section of the **Spec Details** tab of the spec generator and enter the name of the storageclass you created in step 1 above.

2. Using Helm, add the {{< pxEnterprise >}} repo to your cluster and update it:
    <!-- I may instead just push these two steps together and refer users to the spec generator -->

    ```text
    helm repo add portworx http://charts.portworx.io/ && helm repo update
    ```

2. Install PX-Backup using either the `helm set` command or the `values.yml` file provided in the output of the **Complete** tab of the spec generator.

    You can find more information about the PX-Backup Helm chart in the [reference article](/reference/install-helm-chart/).

## Configure external OIDC endpoints

If you enabled an external OIDC during the PX-Backup installation, you must must manually configure the redirect URI in your OIDC provider.

Refer to the [Set up login redirects](https://docs.portworx.com/portworx-install-with-kubernetes/operate-and-maintain-on-kubernetes/pxcentral-onprem/set-up-login-redirects) section of the {{< pxEnterprise >}} documentation for instructions.


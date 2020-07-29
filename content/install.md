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

* Stork 2.4.0 or newer
* If you're using an external OIDC provider, you must use certificates signed by a trusted certificate authority
* If you're using PX-Backup with {{< pxEnterprise >}}, you must use {{< pxEnterprise >}} version 2.5.0 or newer
* Helm

{{<info>}}
**NOTE:** PX-Backup does not support the following Portworx features:

* PX-Security
* PX-Essentials
{{</info>}}

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


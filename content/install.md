---
title: Install PX-Backup
description: Get started with PX-Backup by installing it.
keywords:
weight: 2
hidesections: true
disableprevnext: true
series: backup
---

## Prerequisites

* Stork 2.4.0 or newer
<!--  I think we can remove this now:
* {{< pxEnterprise >}} 2.5.0 or newer 
* PX-Central. Refer to the [Install PX-Central on-premises](https://docs.portworx.com/portworx-install-with-kubernetes/operate-and-maintain-on-kubernetes/pxcentral-onprem/install-pxcentral/) page for details.
-->
* If you're using an external OIDC provider, you must use certificates signed by a trusted certificate authority.
* Helm

{{<info>}}
**NOTE:** PX-Backup does not support the following Portworx features:

* PX-Security
* PX-Essentials
{{</info>}}

## Save your cloud credentials in a Kubernetes secret (Optional)

<!-- is this still relevant? -->

As part of the installation process, the spec generator asks you to input your cloud credentials. If you don't want to specify your cloud credentials in the spec generator, you can create a Kubernetes secret and point the spec generator to that Kubernetes secret:

Create a Kubnernetes secret, save the name and namespace in which it's located for use in the installation steps. The contents of the secret you create depend on the cloud you're using:

* **AWS**:

    ```text
    kubectl --kubeconfig=$KC create secret generic $CLOUD_SECRET_NAME --from-literal=AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID --from-literal=AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY --namespace $PXCNAMESPACE
    ```

* **Azure**:

    ```text
    kubectl --kubeconfig=$KC create secret generic $CLOUD_SECRET_NAME --from-literal=AZURE_CLIENT_SECRET=$AZURE_CLIENT_SECRET --from-literal=AZURE_CLIENT_ID=$AZURE_CLIENT_ID --from-literal=AZURE_TENANT_ID=$AZURE_TENANT_ID --namespace $PXCNAMESPACE
    ```

* **vSphere**:

    ```text
    kubectl --kubeconfig=$KC create secret generic $CLOUD_SECRET_NAME --from-literal=VSPHERE_USER=$VSPHERE_USER --from-literal=VSPHERE_PASSWORD=$VSPHERE_PASSWORD --namespace $PXCNAMESPACE
    ```

## Install

1. To install PX-Backup, generate the install spec through the **PX-Backup** [spec generator](https://central.portworx.com/specGen/wizard). 
    <!-- if the step above is removed, remove this as well --> If you saved your cloud credentials as a Kubernetes secret ahead of time, enter the name and namespace of your secret.

<!-- I may instead just push these two steps together and refer users to the spec generator -->
2. Using helm, Add the {{< pxEnterprise >}} repo to your cluster and update it:

    ```text
    helm repo add portworx http://charts.portworx.io/ && helm repo update
    ```

2. Install {{< pxEnterprise >}} using either the `helm set` command or the `values.yml` file provided in the output of the **Complete** tab of the spec generator.

## Configure external OIDC endpoints

If you enabled an external OIDC during the PX-Backup installation, you must must manually configure the redirect URI in your OIDC provider.

Refer to the [Set up login redirects](https://docs.portworx.com/portworx-install-with-kubernetes/operate-and-maintain-on-kubernetes/pxcentral-onprem/set-up-login-redirects) section of the {{< pxEnterprise >}} documentation for instructions.


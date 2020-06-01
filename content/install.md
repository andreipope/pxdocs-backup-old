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
* PX-Enterprise 2.5.0 or newer
* PX-Central. Refer to the [Install PX-Central on-premises](https://docs.portworx.com/portworx-install-with-kubernetes/operate-and-maintain-on-kubernetes/pxcentral-onprem/install-pxcentral/) page for details.

{{<info>}}
**NOTE:** PX-Backup does not support the following Portworx features:

* PX-Security
* PX-Essentials
{{</info>}}

## Saving your cloud credentials in a Kubernetes secret

If you don't want to specify your cloud credentials in the spec generator, you can create a Kubernetes secret and point the spec generator to that Kubernetes secret. 



1. Create a secret, note the following:
    * the name of your secret (CLOUD_SECRET_NAME="px-disk-provision-secret")
    * the namespace of your secret (PXCNAMESPACE="portworx")

    The contents of the secret you create depend on the cloud you're using:

    * AWS:

    ```text
    kubectl --kubeconfig=$KC create secret generic $CLOUD_SECRET_NAME --from-literal=AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID --from-literal=AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY --namespace $PXCNAMESPACE
    ```

    * Azure:

    ```text
    kubectl --kubeconfig=$KC create secret generic $CLOUD_SECRET_NAME --from-literal=AZURE_CLIENT_SECRET=$AZURE_CLIENT_SECRET --from-literal=AZURE_CLIENT_ID=$AZURE_CLIENT_ID --from-literal=AZURE_TENANT_ID=$AZURE_TENANT_ID --namespace $PXCNAMESPACE
    ```

    * vSphere:

    ```text
    kubectl --kubeconfig=$KC create secret generic $CLOUD_SECRET_NAME --from-literal=VSPHERE_USER=$VSPHERE_USER --from-literal=VSPHERE_PASSWORD=$VSPHERE_PASSWORD --namespace $PXCNAMESPACE
    ```

## Install

1. To install PX-Backup, generate the install script through the the **PX-Backup using PX-Central** [spec generator](link_here). If you saved your cloud credentials as a Kubernetes secret ahead of time, enter the name and namespace of your secret.

2. Once you've generated the script, paste it into the command line of the Kubernetes master node in which you want to install PX-Backup and run it. The following example installs PX-Central with PX-Backup enabled:

    ```text
    bash <(curl -s https://raw.githubusercontent.com/portworx/px-central-onprem/<version>/install.sh) --px-store --px-backup --admin-password 'examplePassword' --oidc --pxcentral-namespace portworx --px-license-server --license-password 'examplePassword' --px-backup-organization backup --cluster-name px-central --admin-email admin@portworx.com --admin-user admin
    ```

## Post install

If you enabled an external OIDC during PX-Central with PX-Backup installation, you must configure the endpoint as the login redirect/callback URL in the External OIDC you provided. 

Refer to your external OIDC provider for more information:
    * link 1
    * link 2



+================================================+
SAVE THE FOLLOWING DETAILS FOR FUTURE REFERENCES
+================================================+
PX-Central User Interface Access URL : http://70.0.24.54:31234/pxcentral
PX-Central PX-Backup Organization ID: backup
Keycloak Endpoint: http://70.0.24.54:31241/auth
Keycloak admin user: admin
Keycloak admin password: P@$$w0rd!
OIDC CLIENT ID: pxcentral, OIDC CLIENT SECRET: "f33f3d5a-5ba4-45d1-943d-a78ce9ef0adc", OIDC ENDPOINT: 70.0.24.54:31241/auth
Configure following endpoint as login redirect/callback URL in External OIDC provider: http://70.0.24.54:31241/auth/realms/master/broker/oidc/endpoint
+================================================+
<!-- ### Manually install using the PX-Central on-prem install script 

Install PX-Backup through [PX-Central](https://docs.portworx.com/portworx-install-with-kubernetes/operate-and-maintain-on-kubernetes/pxcentral-onprem/install-pxcentral/). By default, PX-Central installations include PX-Backup. 
-->



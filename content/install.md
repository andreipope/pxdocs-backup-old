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

## Save your cloud credentials in a Kubernetes secret (Optional)

As part of the installation process, the spec generator asks you to input your cloud credentials. If you don't want to specify your cloud credentials in the spec generator, you can create a Kubernetes secret and point the spec generator to that Kubernetes secret:

Create a Kubnernetes secret, save the name and namespace in which it's located for use in the installation steps. The contents of the secret you create depend on the cloud you're using:

    * **AWS**:

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

1. To install PX-Backup, generate the install script through the **PX-Backup using PX-Central** [spec generator](link_here). If you saved your cloud credentials as a Kubernetes secret ahead of time, enter the name and namespace of your secret.

2. Once you've generated the script, paste it into the command line of the Kubernetes master node in which you want to install PX-Backup and run it. The following example installs PX-Central with PX-Backup enabled:

    ```text
    bash <(curl -s https://raw.githubusercontent.com/portworx/px-central-onprem/<version>/install.sh) --px-store --px-backup --admin-password 'examplePassword' --oidc --pxcentral-namespace portworx --px-license-server --license-password 'examplePassword' --px-backup-organization backup --cluster-name px-central --admin-email admin@portworx.com --admin-user admin
    ```

## Configure external OIDC endpoints

If you enabled an external OIDC during PX-Central with PX-Backup installation, you must you must manually configure the redirect URI in your OIDC provider.

Refer to the [Set up login redirects](https://docs.portworx.com/portworx-install-with-kubernetes/operate-and-maintain-on-kubernetes/pxcentral-onprem/set-up-login-redirects) section of the PX-Enterprise documentation for instructions.

<!-- 
1. Copy the OIDC endpoint output by the installation script:

    ```text
    +================================================+
    SAVE THE FOLLOWING DETAILS FOR FUTURE REFERENCES
    +================================================+
    
    ...
    
    Configure following endpoint as login redirect/callback URL in External OIDC provider: http://70.0.24.54:31241/auth/realms/master/broker/oidc/endpoint
    +================================================+
    ```

2. Follow the steps in the documentation provided by your external OIDC provider to create an application and add the login redirect URI:
    * [OKTA](https://developer.okta.com/docs/guides/sign-into-web-app/aspnet/create-okta-application/)
    * [Auth0]()
 -->
<!-- from the PX-Central article, these steps aren't well documented on Auth0, and minimally documented on OKTA, although they're complete for OKTA. 

## Configure a login redirect URI in Okta

 This section describes how you can configure a login redirect URI in Okta.

 1. Go to **Applications**, and then select **Add Application**:

     ![Okta - Add application](/img/okta-add-application.png)

 2. Choose **Web**, and then select **Next**:

     ![Okta - Select web application](/img/okta-select-web-application.png)

 3. In the **Login redirect URIs** box, enter your login redirect URI, and the select **Add URI**:

     ![Okta - Add login redirect URI](/img/okta-add-login-redirect-uri.png)


 ## Configure a login redirect URI in Auth0

 This section describes how you can configure a login redirect URI in Auth0.

 1. In  the left sidebar, select **Applications**, and then **CREATE APPLICATION**:

     ![Auth0 - Add application](/img/auth0-create-application.png)

 2. Enter the name of your application (this example uses `px-central`), choose **Regular Web Applications**, and then select **CREATE**

     ![Auth0 - Add application](/img/auth0-select-regular-web-application.png)

 3. Go to the **Settings** tab:


     ![Auth0 - Settings tab](/img/auth0-select-settings-tab.png)

 4. In the **Allowed Callback URLs** box, enter your login redirect URI:

     ![Auth0 - Allowed callback URL](/img/auth0-allowed-callback-url.png)
 -->

 


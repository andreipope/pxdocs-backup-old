---
title: Configure access to the PX-Backup UI
description: Configure access to the PX-Backup UI
keywords: configure,
weight: 10
hidesections: true
disableprevnext: true
scrollspy-container: false
type: common-landing
---

If the standard PX-Backup UI endpoint configuration doesn't meet your requirements, you can configure access using HTTPS, access it through the load balancer, or even navigate to one of your node IPs directly. 

## Expose the PX-Backup UI on ingress and configure access using HTTPS

You can configure access to PX-Backup through HTTPS by creating an ingress rule.

1. Modify and paste the following spec into your one of your PX-Backup nodes, entering your own values for the following:

    * **spec.rules.host:** specify the name of the host on which you've installed PX-Backup
    * **spec.tls.hosts** specify the name of the host on which you've installed PX-Backup
    * **spec.tls.hosts.secretName:** specify the name of the secret that holds your Kubernetes TLS certificates

            cat <<< ' 
            apiVersion: extensions/v1beta1
            kind: Ingress
            metadata:
            annotations:
                ingress.bluemix.net/redirect-to-https: "True"
                kubernetes.io/ingress.class: nginx
                nginx.ingress.kubernetes.io/x-forwarded-port: "443"
            name: px-backup-ui-ingress
            namespace: px-backup
            spec:
            rules:
            - host: <px-backup-host>
                http:
                paths:
                - backend:
                    serviceName: px-backup-ui
                    servicePort: 80
                    path: /
                - backend:
                    serviceName: pxcentral-keycloak-http
                    servicePort: 80
                    path: /auth
            tls:
            - hosts:
                - <px-backup-host>
                secretName: <TLS-backup-secret>
            ' > /tmp/px-backup-ui-ingress.yaml

    {{<info>}}
**NOTE:** The `secretName` field is only required when you want to terminate TLS on the host/domain. Refer to your cloud provider for specific examples:

* [AKS](https://docs.microsoft.com/en-us/azure/aks/ingress-own-tls)
* [EKS](https://aws.amazon.com/blogs/opensource/network-load-balancer-nginx-ingress-controller-eks/)
    {{</info>}}

2. Apply the spec:

    ```text
    kubectl apply -f /tmp/px-backup-ui-ingress.yaml
    ```

3. Retrieve the `INGRESS_ENDPOINT` using the `kubectl get ingress` command:

    ```text
    kubectl get ingress px-backup-ui-ingress --namespace px-backup -o jsonpath="{.status.loadBalancer.ingress[0].hostname}"
    ```

Once you've retrieved the `INGRESS_ENDPOINT`, you can use it to access the PX-Backup UI with the HTTPS scheme. Use the default credentials (admin/admin) to log in:

```
https://INGRESS_ENDPOINT
```

Additionally, you can access the Keycloak UI at the `/auth` path: 

```
https://INGRESS_ENDPOINT/auth
```


## Access the PX-Backup UI using a node IP:

You can access PX-Backup by directly navigating to one of your node's IP addresses.

1. Find the public/external IP (NODE_IP) of  any node in your current Kubernetes cluster.

2. Find the node port (NODE_PORT) of the `px-backup-ui` service.

Once you've found the node IP and port, you can combine them to access the PX-Backup UI:

```
http://NODE_IP:NODE_PORT
```

Additionally, you can access the Keycloak UI at the `/auth` path:

```
http://NODE_IP:NODE_PORT/auth
```


## Access the PX-Backup UI using the load balancer endpoint:

You can also the access PX-Backup UI by navigating to the load balancer using either its host name or IP address.

1. Get the loadbalancer endpoint (LB_ENDPOINT) using one of the following commands:

   - Host:

        ```text
        kubectl get ingress --namespace {{ .Release.Namespace }} px-backup-ui -o jsonpath="{.status.loadBalancer.ingress[0].hostname}"`
        ```

   - IP:

        ```text
        kubectl get ingress --namespace {{ .Release.Namespace }} px-backup-ui -o jsonpath="{.status.loadBalancer.ingress[0].ip}"`
        ```
  
Once you've retrieved the load balancer endpoint, you can use it to access the PX-Backup UI:

```
http://LB_ENDPOINT
```

You can access the Keycloak UI at the `/auth` path:

```
http://LB_ENDPOINT/auth
```

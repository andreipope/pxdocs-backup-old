---
title: Monitoring PX-Backup with Prometheus and Grafana
description: Monitoring PX-Backup with Prometheus and Grafana
keywords: Monitoring, Grafana, Prometheus
weight: 4
disableprevnext: true
scrollspy-container: false
---

This document shows how you can monitor your PX-Backup cluster with Prometheus and Grafana.

## Prerequisites

* A PX-Backup cluster
* You have `kubectl` access to your PX-Backup cluster
## Install and configure Prometheus

1\. Enter the following combined spec and `kubectl` command to install Prometheus:

```text
kubectl apply -f - <<'_EOF'
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: prometheus-operator
  namespace: px-backup
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: prometheus-operator
subjects:
  - kind: ServiceAccount
    name: prometheus-operator
    namespace: px-backup
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: prometheus-operator
  namespace: px-backup
rules:
  - apiGroups:
      - extensions
    resources:
      - thirdpartyresources
    verbs: ["*"]
  - apiGroups:
      - apiextensions.k8s.io
    resources:
      - customresourcedefinitions
    verbs: ["*"]
  - apiGroups:
      - monitoring.coreos.com
    resources:
      - alertmanagers
      - prometheuses
      - prometheuses/finalizers
      - servicemonitors
      - prometheusrules
      - podmonitors
      - thanosrulers
    verbs: ["*"]
  - apiGroups:
      - apps
    resources:
      - statefulsets
    verbs: ["*"]
  - apiGroups: [""]
    resources:
      - configmaps
      - secrets
    verbs: ["*"]
  - apiGroups: [""]
    resources:
      - pods
    verbs: ["list", "delete"]
  - apiGroups: [""]
    resources:
      - services
      - endpoints
    verbs: ["get", "create", "update"]
  - apiGroups: [""]
    resources:
      - nodes
    verbs: ["list", "watch"]
  - apiGroups: [""]
    resources:
      - namespaces
    verbs: ["list", "watch"]
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: prometheus-operator
  namespace: px-backup
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    k8s-app: prometheus-operator
  name: prometheus-operator
  namespace: px-backup
spec:
  selector:
    matchLabels:
      k8s-app: prometheus-operator
  replicas: 1
  template:
    metadata:
      labels:
        k8s-app: prometheus-operator
    spec:
      containers:
        - args:
            - --kubelet-service=kube-system/kubelet
            - --config-reloader-image=quay.io/coreos/configmap-reload:v0.0.1
          image: quay.io/coreos/prometheus-operator:v0.36.0
          name: prometheus-operator
          ports:
            - containerPort: 8080
              name: http
          resources:
            limits:
              cpu: 200m
              memory: 100Mi
            requests:
              cpu: 100m
              memory: 50Mi
      securityContext:
        runAsNonRoot: true
        runAsUser: 65534
      serviceAccountName: prometheus-operator
---
_EOF
```

```output
clusterrolebinding.rbac.authorization.k8s.io/prometheus-operator configured
clusterrole.rbac.authorization.k8s.io/prometheus-operator unchanged
serviceaccount/prometheus-operator created
deployment.apps/prometheus-operator created
```

2\. To grant Prometheus access to the metrics API, you must create a `ClusterRole` and a `ServiceAccount` by entering the following combined spec and `kubectl` command:


```text
kubectl apply -f - <<'_EOF'
---
 apiVersion: rbac.authorization.k8s.io/v1
 kind: ClusterRole
 metadata:
   annotations:
     kubectl.kubernetes.io/last-applied-configuration: |
       {"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRole","metadata":{"annotations":{},"name":"px-backup-prometheus"},"rules":[{"apiGroups":[""],"resources":["nodes","services","endpoints","pods"],"verbs":["get","list","watch"]},{"apiGroups":[""],"resources":["configmaps"],"verbs":["get"]},{"nonResourceURLs":["/metrics","/federate"],"verbs":["get"]}]}
   creationTimestamp: "2020-11-11T17:26:55Z"
   name: px-backup-prometheus
   resourceVersion: "36972102"
   selfLink: /apis/rbac.authorization.k8s.io/v1/clusterroles/px-backup-prometheus
   uid: 183b04ab-2443-11eb-adaf-000c2990a7af
 rules:
 - apiGroups:
   - ""
   resources:
   - nodes
   - services
   - endpoints
   - pods
   verbs:
   - get
   - list
   - watch
 - apiGroups:
   - ""
   resources:
   - configmaps
   verbs:
   - get
 - nonResourceURLs:
   - /metrics
   - /federate
   verbs:
   - get
 ---
 apiVersion: rbac.authorization.k8s.io/v1
 kind: ClusterRoleBinding
 metadata:
   annotations:
     kubectl.kubernetes.io/last-applied-configuration: |
       {"apiVersion":"rbac.authorization.k8s.io/v1","kind":"ClusterRoleBinding","metadata":{"annotations":{},"name":"px-backup-prometheus"},"roleRef":{"apiGroup":"rbac.authorization.k8s.io","kind":"ClusterRole","name":"px-backup-prometheus"},"subjects":[{"kind":"ServiceAccount","name":"px-backup-prometheus","namespace":"px-backup"}]}
   name: px-backup-prometheus
 roleRef:
   apiGroup: rbac.authorization.k8s.io
   kind: ClusterRole
   name: px-backup-prometheus
 subjects:
 - kind: ServiceAccount
   name: px-backup-prometheus
   namespace: px-backup
 ---
 apiVersion: v1
 kind: Service
 metadata:
   name: px-backup-prometheus
   namespace: px-backup
 spec:
   type: ClusterIP
   ports:
     - name: web
       port: 9090
       protocol: TCP
       targetPort: 9090
   selector:
     prometheus: px-backup-prometheus
 ---
 apiVersion: v1
 kind: ServiceAccount
 metadata:
   name: px-backup-prometheus
   namespace: px-backup
 ---
 _EOF
 ```

```output
 clusterrole.rbac.authorization.k8s.io/px-backup-prometheus created
clusterrolebinding.rbac.authorization.k8s.io/px-backup-prometheus created
service/px-backup-prometheus created
serviceaccount/px-backup-prometheus created
```

3\. Apply secrets with Prometheus configuration settings <!-- I don't understand this step -->:

```text
kubectl apply -f - <<'_EOF'
---
apiVersion: v1
data:
  prometheus.yaml.gz: H4sICCwRrl8AA29yaWdpbgCFkT1PxDAMhvf+Cg8MgBRSiS0bEoxwtyMUuanbC+cmUZKi8u9JI47ycRKb7dd+Yr8Z2XfIqgGgN+QZs/VOW5cpllTBbZuKlEzEQH/KtJTcIWvGjjitEIAQ/UT5QHNSEBbRoTnOQX5FYtN/tetIga1BBReX+929frp7fLhq4sykB8tU8AIkZSO3Ebmq6VtBnHtHrF0VIVp5ffOOEzefFxnvBjtW9KvvtMOJ/ttapEm2ZfWDdz6eLocBOVGpHueuWEKZkk79hgcQED0XOLk++GJkapApZuvGVa1xMaDifo6hWb9EQZX66EO1LdJIizrj3gk2ocORYlnt+aX5AG3eAynlAQAA
kind: Secret
metadata:
  annotations:
    generated: "true"
  labels:
    managed-by: prometheus-operator
  name: prometheus-px-backup-prometheus
  namespace: px-backup
type: Opaque
---
_EOF
```

```output
secret/prometheus-px-backup-prometheus created
```

4\. To specify the monitoring rules for PX-Backup, create a `ServiceMonitor` object by entering the following combined spec and `kubectl` command:

```text
kubectl apply -f - <<'_EOF'
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
   namespace: px-backup
   name: px-backup-prometheus-sm
   labels:
     name: px-backup-prometheus-sm
spec:
   selector:
     matchLabels:
       app.kubernetes.io/name: px-backup
   namespaceSelector:
     any: true
   endpoints:
     - port: rest-api
       targetPort: 10001
---
_EOF
```

```output
servicemonitor.monitoring.coreos.com/px-backup-prometheus-sm created
```

5\. Apply Prometheus specs for PX-Backup metrics <!-- I don't understand this step -->:

```text
kubectl apply -f - <<'_EOF'
---
prometheus:
  additionalServiceMonitors:
  - name: px-backup
    jobLabel: app
    selector:
      matchLabels:
        app: px-backup
    namespaceSelector:
      any: true
    endpoints:
    - port: rest-api
---
_EOF
```

```output
prometheus.monitoring.coreos.com/px-backup-prometheus created
```

## Install and configure Grafana

1\. Create a storage class for Grafana and persistent volumes with the following names:

- grafana-data
- grafana-dashboard
- grafana-source-config
- grafana-extensions

<!-- Maybe we should add more details and break this step down into two separate steps. -->

```text
kubectl apply -f - <<'_EOF'
---
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
    name: px-grafana-sc
provisioner: kubernetes.io/portworx-volume
parameters:
   repl: "3"
   priority_io: "high"
allowVolumeExpansion: true
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
   name: grafana-data
   annotations:
     volume.beta.kubernetes.io/storage-class: px-grafana-sc
spec:
   accessModes:
     - ReadWriteOnce
   resources:
     requests:
       storage: 1Gi
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
   name: grafana-dashboard
   annotations:
     volume.beta.kubernetes.io/storage-class: px-grafana-sc
spec:
   accessModes:
     - ReadWriteOnce
   resources:
     requests:
       storage: 1Gi
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
   name: grafana-source-config
   annotations:
     volume.beta.kubernetes.io/storage-class: px-grafana-sc
spec:
   accessModes:
     - ReadWriteOnce
   resources:
     requests:
       storage: 1Gi
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
   name: grafana-extensions
   annotations:
     volume.beta.kubernetes.io/storage-class: px-grafana-sc
spec:
   accessModes:
     - ReadWriteOnce
   resources:
     requests:
       storage: 1Gi
---
_EOF
```

```output
storageclass.storage.k8s.io/px-grafana-sc created
persistentvolumeclaim/grafana-data created
persistentvolumeclaim/grafana-dashboard created
persistentvolumeclaim/grafana-source-config created
persistentvolumeclaim/grafana-extensions created
```

Note the following about this `StorageClass`:

* The `provisioner` parameter is set to  `kubernetes.io/portworx-volume`. For details about the Portworx-specific parameters, refer to the [Portworx Volume](https://kubernetes.io/docs/concepts/storage/storage-classes/#portworx-volume) section of the Kubernetes website.
* Three replicas of each volume will be created.

2\. Enter the following command to install Grafana:

```text
kubectl apply -npx-backup -f - <<'_EOF'
apiVersion: v1
kind: Service
metadata:
  name: grafana
  labels:
    app: grafana
spec:
  type: ClusterIP
  ports:
    - port: 3000
  selector:
    app: grafana
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: grafana
  labels:
    app: grafana
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: grafana
    spec:
      securityContext:
       fsGroup: 2000
      containers:
        - image: grafana/grafana:6.1.6
          name: grafana
          imagePullPolicy: Always
          resources:
            limits:
              cpu: 100m
              memory: 100Mi
            requests:
              cpu: 100m
              memory: 100Mi
          readinessProbe:
            httpGet:
              path: /login
              port: 3000
          volumeMounts:
            - name: grafana
              mountPath: /etc/grafana/provisioning/dashboard
              readOnly: false
            - name: grafana-dash
              mountPath: /var/lib/grafana/dashboards
              readOnly: false
            - name: grafana-source-cfg
              mountPath: /etc/grafana/provisioning/datasources
              readOnly: false
            - name: grafana-plugins
              mountPath: /var/lib/grafana/plugins
              readOnly: false
      volumes:
      - name: grafana
        persistentVolumeClaim:
          claimName: grafana-data
      - name: grafana-dash
        persistentVolumeClaim:
          claimName: grafana-dashboard
      - name: grafana-source-cfg
        persistentVolumeClaim:
          claimName: grafana-source-config
      - name: grafana-plugins
        persistentVolumeClaim:
          claimName: grafana-extensions
---
_EOF
```

<!--
@bhavana-ar I'm getting the following error:

error: unable to recognize "02-grafana.yaml": no matches for kind "Deployment" in version "extensions/v1beta1"

-->

Note the following about this `Deployment`:
  - The `volumes` section references the PVCs you created in the previous step.

3\.  Enter the following `kubectl port-forward` command to forward all connections made to `localhost:3000` to `svc/grafana:3000`:

```text
kubectl port-forward svc/grafana --namespace px-backup --address 0.0.0.0 3000
```

4\. Follow the instructions from the [Grafana Support for Prometheus](https://prometheus.io/docs/visualization/grafana/#grafana-support-for-prometheus) page of the Prometheus documentation, to create a Prometheus data source named `px-backup`.

5\. Follow the instructions from the [Importing a dashboard](Importing a dashboard) page of the Grafana documentation to import the PX-Backup dashboard [JSON file](/samples/Portworx_Backup_Overview.json?raw=true).
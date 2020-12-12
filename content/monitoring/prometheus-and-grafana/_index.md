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

1. Enter the following combined spec and `kubectl` command to install Prometheus:

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

2. Enter the following combined spec and `kubectl` command Apply clusterrole, serviceAccount settings to ensure prometheus pod has access to metric api

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

```text
 clusterrole.rbac.authorization.k8s.io/px-backup-prometheus created
clusterrolebinding.rbac.authorization.k8s.io/px-backup-prometheus created
service/px-backup-prometheus created
serviceaccount/px-backup-prometheus created
```

3. Apply secrets with prometheus configuration settings

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

4. Apply Service Monitor specs:

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

5. Apply prometheus specs for px-backup metrics:

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

1. Create PVC:

```text
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
```

```output
storageclass.storage.k8s.io/px-grafana-sc created
persistentvolumeclaim/grafana-data created
persistentvolumeclaim/grafana-dashboard created
persistentvolumeclaim/grafana-source-config created
persistentvolumeclaim/grafana-extensions created
```

2. Install Grafana

```tezt
kubectl apply -npx-backup -f specs/02-grafana.yaml
```

<!--
All of prometheus install specs are under specs/prometheus directory.
If prometheus operator is not installed already install via applying spec
kubectl apply -f specs/prometheus/00-promethues-oper.yaml
Apply clusterrole, serviceAccount settings to ensure prometheus pod has access to metric api
kubectl apply -f specs/prometheus/01-prometheus-role.yaml
Apply secrets with prometheus configuration settings
kubectl apply -f specs/prometheus/02-secrets.yaml
Apply Service Monitor specs
 kubectl apply -f specs/prometheus/03-service-monitor.yaml
Apply prometheus specs for px-backup metrics
kubectl apply -f specs/prometheus/04-prometheus.yaml
If grafana is not installed already, install via applying specs -
kubectl apply -npx-backup -f specs/01-pvc.yaml
kubectl apply -npx-backup -f specs/02-grafana.yaml
Use forward proxy to access grafana UI from browser -
 kubectl port-forward svc/grafana --namespace px-backup --address 0.0.0.0 3000
Add prometheus datasource in grafana for px-backup metrics with name px-backup [https://prometheus.io/docs/visualization/grafana/]
Follow the link [https://grafana.com/docs/grafana/latest/dashboards/export-import/#importing-a-dashboard] to load grafana dashboard from json in ./specs/grafana/Portworx Backup Overview.json




-->

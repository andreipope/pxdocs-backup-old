---
title: Backup Elasticsearch on Kubernetes
description: 
keywords: backup, elasticsearch
weight: 4
hidesections: true
disableprevnext: true
---

You can use the instructions on this page to create pre and post backup rules with PX-Backup, which take application-consistent backups for Elasticsearch on Kubernetes in production.

The Elasticsearch data directory is used prevent permanent data loss and is typically located at `/user/share/elasticsearch/data` inside the Kubernetes pod. This will also enable PX-Backup to backup and restore the data stored in this location.

Before using this guide, make sure and configure PVCs for `elasticsearch-data`. Use the below file as an example. 

```
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: elasticsearch
spec:
  version: 7.8.0
  nodeSets:
  - name: default
    count: 3
    podTemplate:
      metadata:
        labels:
          appname: "elastisearch-app"
      spec:
        containers:
          - name: elasticsearch
            volumeMounts:
            - name: elasticsearch-backups
              mountPath: /usr/share/elasticsearch/backups
        volumes:
        - name: elasticsearch-backups
          persistentVolumeClaim:
            claimName: elasticsearch-backups
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 5Gi
        storageClassName: elastic-pwx-storage-class
    config:
      node.master: true
      node.data: true
      node.ingest: true
      node.store.allow_mmap: false
      path.repo: ["/usr/share/elasticsearch/backups"]
```

Elasticsearch can also create a snapshot repository to store index snapshots produced by the internal snapshot and restore API. For this, the above template uses a Portworx shared volume and named `elasticsearch-backups` to create a shared file-system across all Elasticsearch nodes to be used to store the index snapshots.

## Installation

### Prerequisites

{{% content "shared/common-info.md" %}}

{{<info>}}
**NOTE:** 

* The templat above can not be used alone. Please follow pre-requisites from the following [elastic on kubernetes operations guide](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html).
* The rules below will use a user name `elastic` and password specific to the environment. You will need to modify the rule to use your user name and password for your environment.
* You should mount a PVC to the elasticsearch data directory. This is typically located at `/user/share/elasticsearch/data`.
{{</info>}}

### Create rules for Elasticsearch

Create rules for Elasticsearch that will run both before and after the backup operation runs:

#### Create a pre-exec backup rule for Elasticsearch

For the pre-backup rule you will create a rule that performs multiple actions.

- Freeze the index
- Flush all indexes in Elasticsearch
- Create an Elasticsearch index snapshot of all indexes

Create the rule.

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	appname=elasticsearch-app
	```

4. Add the following action:

	```text
	curl -X POST -u "elastic:<password>" -k "https://elasticsearch-es-http:9200/customer/_freeze&pretty"
	```

5. Add the following additional action:

	```text
	curl -X PUT -u "elastic:<password>" -k "https://elasticsearch-es-http:9200/all/_flush&pretty"
	```

6. Add the following additional action:

	```text
	curl -X PUT -u "elastic:<password>" -k "https://elasticsearch-es-http:9200/_snapshot/es_backups/%3Csnapshot-$(uuidgen)-%7Bnow%2Fd%7D%3E?wait_for_completion=true&pretty"
	```

    ![](/img/elastic-pre-rule.png)

#### Create a post-exec backup rule for Elasticsearch

Performing the `_freeze` and `_flush` operations on your index before calling the snapshot API ensures flexible and accurate restores by making sure the database isn't currently being written into.

Since you performed a  `_freeze`operation when you created a backup, you must create a post exec rule to perform an `_unfreeze` operation. The steps below create a post-exec rule which runs `_unfreeze` on the `customer` index:

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	appname=elasticsearch-app
	```

4. Add the following action:

	```text
	curl -X POST -u "elastic:<password>" -k "https://elasticsearch-es-http:9200/customer/_unfreeze&pretty"
	```

    ![](/img/elastic-post-rule.png)

### Associate the pre and post-exec rules with the Elasticsearch backup

Create a backup for your Elasticsearch application. Select the rules you created in the steps above from the **pre-exec** and **post-exec** drop downs:

![](/img/elastic-use-rules.png)

Once you've filled out the backup form, click **Create**

## Demo

Watch this short demo of the above information.

{{< youtube  u4w46ivRA1k >}}

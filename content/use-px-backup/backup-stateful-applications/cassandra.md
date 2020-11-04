---
title: Backup Cassandra on Kubernetes
description: 
keywords: backup, cassandra
weight: 4
hidesections: true
disableprevnext: true
---

You can use the instructions on this page to create pre and post backup rules with PX-Backup, which take application-consistent backups for Cassandra on Kubernetes in production.

On its own, Cassandra is resilient to node failures. However, you still need Cassandra backups to recover from the following scenarios:

* Unauthorized deletions
* Major failure’s that require a rebuild your entire cluster
* Corrupt data
* Point in time rollbacks
* Disk failure

Cassandra provides an internal snapshot mechanism to take backups with a tool called `nodetool`. You can configure this to provide incremental or full snapshot-based backups of the data on the node. `nodetool` will flush data from `memtables` to disk and create a `hardlink` to the SSTables file on the node.

However, disadvantages of this include the fact that you must run `nodetool` on each and every Cassandra node, and it keeps data locally, increasing the overall storage footprint. Portworx, Inc. suggests taking a backup of the Cassandra PVs at a block level and storing them in a space-efficient object storage target. Portworx allows you to combine techniques that are recommended by Cassandra, such as flushing data to disk with pre and post backup rules for the application to give users Kubernetes-native and efficient backups of Cassandra data.

PX-Backup allows you to set up pre and post backup rules that will be applied before and or after a backup occurs. For Cassandra, users can create a custom flush, compaction, or verify rule to ensure a healthy and consistent dataset before and after a backup occurs. Rules can run on one or all pods associated with Cassandra which is often a requirement for nodetool commands. 

For more information on how to run Cassandra on Kubernetes, refer to the [Cassandra on Kubernetes on Portworx](https://docs.portworx.com/portworx-install-with-kubernetes/application-install-with-kubernetes/cassandra/) article.

## Installation

### Prerequisites

{{% content "shared/common-info.md" %}}

{{<info>}}
**NOTE:**

* Cassandra pods must also be using the `app=cassandra` label.
* This example uses the cassandra keyspace `newkeyspace` as an example. If you wish to use this rule for another keyspace, simply replace keyspace within this document with your own.
{{</info>}}

### Create rules for Cassandra

Create rules for Cassandra that will run both before and after the backup operation runs:

#### Create a pre-exec backup rule for Cassandra

Create a rule that will run `nodetool flush` for our `newkeyspace` before the backup. This is essential as Portworx will take a snapshot of the backing volume before it places that data in the backup target.

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=cassandra
	```

4. Add the following action:

	```text
	nodetool flush -- <your-cassandra-keyspace>;
	```

	![](/img/cassandra-pre-rule.png)

#### Create a post-exec backup rule for Cassandra

A post-exec backup rule for Cassandra isn't as necessary as the pre-exec backup rules above. However, for completeness in production and to verify a keyspace is not corrupt after the backup occurs, create a rule that runs `nodetool verify`. The verify command will verify (check data checksums for) one or more tables.

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=cassandra
	```

4. Add the following action:

	```text
	nodetool verify -- <your-cassandra-keyspace>;
	```

	 ![](/img/cassandra-post-rule.png)

### Use the rules during Cassandra backup operations

During the backup creation process, select the rules in the **pre-exec** and **post-exec** dropdowns:

 ![](/img/cassandra-use-rules.png)

Once you've filled out the backup form, click **Create**

## Demo

Watch this short demo of the above information.

{{< youtube  szJKZLwteOk >}}

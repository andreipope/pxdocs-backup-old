---
title: Backup MongoDB on Kubernetes
description: 
keywords: backup, mongodb
weight: 4
hidesections: true
disableprevnext: true
---

You can use the instructions on this page to create pre and post backup rules with PX-Backup, which take application-consistent backups for MongoDB on Kubernetes in production.

MongoDB stores data files in a location called `dbPath`. `dbPath` is most often configured to use `/var/lib/mongo`. Some container images may also configure this path differently, so it is important to pay attention to `dbPath`.

When deployed with more than a single node, MongoDB has an additional component called Oplog that should be considered during backup. The MongoDB Oplog is a special capped collection that keeps a rolling record of all operations that modify the data stored in your databases. The Oplog can also be used for database recovery. Because the Oplog recovery can take a very long time, MongoDB usually is combined with regular database snapshots. 

## Installation

### Prerequisites

{{% content "shared/common-info.md" %}}

{{<info>}}
**NOTE:** 

* MongoDB pods should use the label `app=mongo` for this example.
* If MongoDB is using oplog, you will need a persistent location to dump oplog. The location `/data/oplog` is used in this example.
{{</info>}}

### Create rules for MongoDB

Create rules for MongoDB that will run both before and after the backup operation runs:

#### Create a pre-exec backup rule for MongoDB

PX-Backup should flush writes to disk and lock the database to ensure a consistent backup. This is done using the `db.fsyncLock()` method.

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=mongo
	```

4. Add the following action:

	```text
	mongo --eval "printjson(db.fsyncLock())"
	```

5. Add the second action:

	If you are using Oplog, this will dump Oplog and can be used for alternate database recovery.

	```text
	mongodump -d local -c oplog.rs -o /data/oplog
	```

    ![](/img/mongo-pre-rule.png)

#### Create a post-exec backup rule for MongoDB

Create a post-backup action that will administratively reduce the lock on the database following your pre-backup `db.fsyncLock()` operation.

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=mongo
	```

4. Add the following action:

	```text
	mongo --eval "printjson(db.fsyncUnlock())"
	```

	![](/img/mongo-post-rule.png)

### Use the rules during backup of MongoDB

During the backup creation process, select the rules in the **pre-exec** and **post-exec** drop downs:

![](/img/mongo-use-rules.png)

Once you've filled out the backup form, click **Create**

## Demo

Watch this short demo of the above information.

{{< youtube  edirPvaKj0I >}}
---
title: Backup MySQL on Kubernetes
description: 
keywords: backup, mysql
weight: 4
hidesections: true
disableprevnext: true
---

You can use the instructions on this page to create pre and post backup rules with PX-Backup, which take application-consistent backups for MySQL on Kubernetes in production.

MySQL server manages information stored in a location called the [data directory](https://dev.mysql.com/doc/refman/8.0/en/data-directory.html). Often, the data directory is located in the MySQL server filesystem at `/var/lib/mysql`. MySQL stores data within this location that are vital for MySQL. You must make sure to mount Kubernetes PersistentVolumeClaims (PVCs) to the data directory location. In Kubernetes, the spec file `volumeMount` may look like this:

```text
...
        volumeMounts:
        - name: mysql-data
          mountPath: /var/lib/mysql
      volumes:
      - name: mysql-data
        persistentVolumeClaim:
          claimName: mysql-data
...
```

Within the data directory, MySQL stores schema, table, logs, configuration and database data that corresponds to system, performance, and client data. Mounting a PersistentVolume enables PX-Backup to snapshot and back up MySQL data when needed.

MySQL has a tool called `mysqldump` which works well for taking backups specific to MySQL. Since PX-Backup can provide abstracted backup and restore for a polyglot of data services, we can replicate the [best practices of mysqldump](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_add-locks), such as flushing and locking logs and tables using PX-Backup’s pre and post backup rules. Backups and rules can be used across multiple instances of MySQL and multiple types of clouds. This will ultimately simplify operations for devops teams for single or multi-cloud workflows.

For more information on how to run MySQL on Kubernetes, refer to [this article](https://portworx.com/mysql-kubernetes/ ).

## Installation

### Prerequisites

{{% content "shared/common-info.md" %}}

{{<info>}}
**NOTE:** MySQL pods must also be using the `app=mysql` label.
{{</info>}}

### Create rules for MySQL

Create rules for MySQL that will run both before and after the backup operation runs:

#### Create a pre-exec backup rule for MySQL

Before a backup of MySQL occurs, Portworx, Inc. recommends you to flush certain data to disk so that the backup remains consistent. Database tables and logs are examples of data that should be flushed. It is also important in MySQL to lock the tables so no new I/O transactions attempt to add records during the backup, or MySQL may also become inconsistent. 

To accomplish this, the [(`FLUSH TABLES WITH READ LOCK`)](https://dev.mysql.com/doc/refman/8.0/en/flush.html#flush-tables-with-read-lock) command is used in a pre-backup rule. The command will lock the tables with a global read lock and allow Portworx to take a application-consistent snapshot.

{{<info>}}
**NOTE:** Set this rule to run in the background. This requires a `WAIT_CMD` to allow the rule to execute and exit properly.
{{</info>}}

Create the following rule within the PX-Backup interface. Modify the username and password for how they are configured in your Kubernetes environment.

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=mysql
	```

4. Add the following action:

	```text
	mysql --user=root --password=$MYSQL_ROOT_PASSWORD -Bse 'FLUSH TABLES WITH READ LOCK;system ${WAIT_CMD};'
	```

	 ![](/img/mysql-pre-rule.png)

#### Create a post-exec backup rule for MySQL

PX-Backup performed a flush and lock on the data in MySQL before our backup. Now, PX-Backup must make sure to also run `UNLOCK` so the database releases the global read lock. It also may be a good idea to use [`FLUSH LOGS`](https://dev.mysql.com/doc/refman/8.0/en/flush.html#flush-logs). `FLUSH LOGS` will rotate logs and update the sequence number of the log. `FLUSH LOGS` is useful when users need a clear distinction between logs before and after a backup occurs. 

{{<info>}}
**NOTE:** 

* Post backup rules are not allowed to run in the background, a WAIT_CMD is not needed.
* Flushing logs is optional here but will add it to our post- backup rule for completeness.
{{</info>}}

Create the following rule within the PX-Backup interface. Modify the username and password for how they are configured in your Kubernetes environment.

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=mysql
	```

4. Add the following action:

	```text
	mysql --user=root --password=$MYSQL_ROOT_PASSWORD -Bse 'FLUSH LOGS; UNLOCK TABLES;'
	```

	 ![](/img/mysql-post-rule.png)

### Use the rules during backup of MySQL

During the backup creation process, select the rules in the **pre-exec** and **post-exec** drop downs:

![](/img/mysql-use-rules.png)

Once you've filled out the backup form, click **Create**

## Demo

Watch this short demo of the above information.

{{< youtube  1RzFlmSMU-I >}}

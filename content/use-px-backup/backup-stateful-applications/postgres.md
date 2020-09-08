---
title: Backup PostgreSQL on Kubernetes
description: 
keywords: backup, postgres
weight: 4
hidesections: true
disableprevnext: true
---

You can use the instructions on this page to create pre and post backup rules with PX-Backup, which take application-consistent backups for PostgreSQL on Kubernetes in production.

Postgres places data within a data directory known as `PGDATA`. The most common location for `PGDATA` is `/var/lib/pgsql/data`. You must configure your Kubernetes spec file with this volumeMount when using a persistent volume. 

`PGDATA` contains control, configuration, and data files related to the Postgres server which need to be backed up. Assigning the `PGDATA` directory a persistent volume claim allows PX-Backup to backup and restore Postgres server data. 

Postgres suggests taking a `CHECKPOINT` to flush data to disk before any snapshots.

## Installation

### Prerequisites

{{% content "shared/common-info.md" %}}

{{<info>}}
**NOTE:** 

* Postgres pods should use the label `app=postgres` for this example.
* If the Postgres username and password are available in the pod as an environment variable, the below actions can be used. If not, you may need to adjust the command.
{{</info>}}

### Create rules for PostgreSQL

Create rules for PostgreSQL that will run both before and after the backup operation runs:

#### Create a pre-exec backup rule for PostgreSQL

For the pre-backup rule, you will create a `CHECKPOINT` rule that will run within our Postgres pod(s).

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=postgres
	```

4. Add the following action:

	```text
	PGPASSWORD=$POSTGRES_PASSWORD; psql -U "$POSTGRES_USER" -c "CHECKPOINT";
	```

    ![](/img/postgres-pre-rule.png)

#### Create a post-exec backup rule for PostgreSQL

PostgreSQL is designed in such a way that it is crash consistent. Since there is no outright read or write locking done with Postgres, it will start back up as if it has crashed. This is perfectly fine and expected because it is crash safe and designed to work that way.

In other words, because we are using consistent and atomic snapshots taken by PX-Backup with `CHECKPOINT`, A post-backup rule is not needed.

### Use the rules during backup of PostgreSQL

During the backup creation process, select the rules in the **pre-exec** and **post-exec** drop downs:

![](/img/postgres-use-rules.png)

Once you've filled out the backup form, click **Create**

## Demo

Watch this short demo of the above information.

{{< youtube  zEtHBdbErOI >}}
---
title: Backup RabbitMQ on Kubernetes
description: 
keywords: backup, rabbitmq
weight: 4
hidesections: true
disableprevnext: true
---

You can use the instructions on this page to create pre and post backup rules with PX-Backup, which take application-consistent backups for RabbitMQ on Kubernetes in production.

Every RabbitMQ node uses a number of files and directories to load configuration, metadata, and log files. The directory setting which configures RabbitMQ’s node database directory is called `RABBITMQ_MNESIA_BASE`. The databases in this directory hold RabbitMQ messages. This directory can be overridden and therefore configured differently. Most often it is located at `/var/lib/rabbitmq/mnesia`.

Make sure `/var/lib/rabbitmq` is mounted to a volume within the pod specification. 

Topology definitions and messages are the most valuble types of data in RabbitMQ. RabbitMQ suggests exporting definititions. RabbitMQ also suggests tRabbitMQ must be stopped in order to backup messages properly.

## Installation

### Prerequisites

{{% content "shared/common-info.md" %}}

{{<info>}}
**NOTE:** 

* RabbitMQ pods must have a label for this to work properly. `app=rabbitmq-ha` is used in this example.
* RabbitMQ queues must be durable and messages must be persistent.
{{</info>}}

### Create rules for RabbitMQ

Create rules for RabbitMQ that will run both before and after the backup operation runs:

#### Create a pre-exec backup rule for RabbitMQ

You will set up a rule with two actions. The first action will be to `export_definitions` to a location within `/var/lib/rabbitmq` so that the version of definitions for that node will be available with any given restore point.

The second action will be to run `stop_app` since it is the best practice to make sure RabbitMQ is not running during the snapshot.

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=rabbitmq-ha
	```

5. Add the following action:

	```text
	rabbitmqctl export_definitions /var/lib/rabbitmq/definitions.file.json
	```

6. Add a second action to the samee rule:

	```text
	rabbitmqctl stop_app
	```

    ![](/img/rabbit-pre-rule.png)

#### Create a post-exec backup rule for RabbitMQ

Next, create a post-exec that runs `start_app`. This will bring each RabbitMQ app back online after the data snapshot takes place. This ensures the backup is application consistent.

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=rabbitmq-ha
	```

4. Add the following action:

	```text
	rabbitmqctl start_app
	```

	![](/img/rabbit-post-rule.png)

### Use the rules during backup of RabbitMQ

During the backup creation process, select the rules in the **pre-exec** and **post-exec** drop downs:

![](/img/rabbit-use-rules.png)

Once you've filled out the backup form, click **Create**

## Demo

Watch this short demo of the above information.

{{< youtube  KeNnoux5Vqw >}}

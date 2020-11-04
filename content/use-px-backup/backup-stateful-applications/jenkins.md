---
title: Backup Jenkins on Kubernetes
description: 
keywords: backup, jenkins
weight: 4
hidesections: true
disableprevnext: true
---

You can use the instructions on this page to create pre and post backup rules with PX-Backup, which take application-consistent backups for Jenkins on Kubernetes in production.

Jenkins stores data within a directory known as `JENKINS_HOME`. Workspaces, plug-ins, jobs, user content and overall configuration exist within this directory and are vital when recovering from various types of failures. 

See below for a snippet of what this might look like in a Kubernetes spec file.

```text
...
        volumeMounts:
        - name: jenkins-home
          mountPath: /var/jenkins_home
      volumes:
        - name: jenkins-home
          persistentVolumeClaim:
            claimName: jenkins-data
...
```

Once you configure a PVC to be mounted at `/var/jenkins_home` you can use the below guide for pre and post backup rules.

## Installation

### Prerequisites

{{% content "shared/common-info.md" %}}

{{<info>}}
**NOTE:** 

* You should configure a persistent volume for `JENKINS_HOME` so that the entire directory is backed by a volume to capture all data associated with Jenkins.
* These examples assume that the Jenkins CLI is available within the Jenkins pod. You can make sure its available in the Jenkins pod(s) by running the below command.

    ```
	kubectl exec <jenkins-deployment-pod> -n jenkins -- /bin/sh -c "wget http://<operations-center-url>:>port-number>/jnlpJars/jenkins-cli.jar -O /var/jenkins_home/cli.jar"
	```
{{</info>}}


### Create rules for Jenkins

Create rules for Jenkins that will run both before and after the backup operation runs:

#### Create a pre-exec backup rule for Jenkins

Assume the Jenkins deployment has a job called `job-1`, you will use the pre-exec rule to make sure this job is stopped before taking our snapshot.

{{<info>}}
**NOTE:** 
Stopping a job is not necessary to backup Jenkins. It is used as an example of a pre backup rule. You may run other commands available within the Jenkins pod here as well.
{{</info>}}

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=jenkins
	```

4. Add the following action:

	```text
	java -jar /var/jenkins_home/cli.jar -s http://jenkins:8080 -webSocket -auth username:password stop-builds job-1
	```

    ![](/img/jenkins-pre-rule.png)

#### Create a post-exec backup rule for Jenkins

After your backup is triggered, you can start the build for `job-1` again using a post-exec rule. This ensures your job is not running during the backup and is restarted after the backup data is captured. 

1. Navigate to **Settings** → **Rules** → **Add New**.
2. Add a name for your Rule.
3. Add the following app label:

	```text
	app=jenkins
	```

4. Add the following action:

	```text
	java -jar /var/jenkins_home/cli.jar -s http://jenkins:8080 -webSocket -auth username:password build job-1
	```

    ![](/img/jenkins-post-rule.png)

### Use the rules during backup of Jenkins

During the backup creation process, select the rules in the **pre-exec** and **post-exec** drop downs:

![](/img/jenkins-use-rules.png)

Once you've filled out the backup form, click **Create**

## Demo

Watch this short demo of the above information.

{{< youtube  bJzlys5DAEA >}}

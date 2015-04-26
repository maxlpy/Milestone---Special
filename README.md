DevOps Milestone - Special
===================
Team Members:

 - Nikhil Katre (nkatre@ncsu.edu)
 - Pengyu Li (pli5@ncsu.edu)
 
Submission: **Milestone#Special** <br>
Submission Files:
>  - README.md
>  - Project Files
>  - Project Presentation Video ( Milestone Special starts from 3:48)

Some Ideas for Milestone Special
-------------

* Introduce a waterfall staging component.
* Introduce resilience testing (chaos monkey).
* Implement a new deployment strategy.
* Implement a more advanced fuzzing/test generation technique.
* Create a novel IaaS/PaaS/app (e.g., [BrowserStack](http://www.browserstack.com/), a service to make it easy to do UI testing of a deployed app on many browser versions).

Evaluation
-------------

**Milestone#Special** is evaluated based on the following
 **Evaluation Parameters:**

 1. Novelty: 25%
 2. Implementation: 25% 
 3. Project Presentation: 50%

----------

Our Idea: New Deployment Strategy.
-------------
For Milestone Special we have implemented a new deployment strategy called **three stage deployment** OR **Red Yellow Green Deployment**.

- **Stage I**: The developers frequently test and deploy code to the Development Sandbox, which handles frequent development environment. 

- **Stage II**: The QA and UAT tests are handled in 2nd stage called Pre-Production Stage, which is a controlled development and testing enviorment. At this stage we have used Jenkins as built and continuous integration tool. Jenkins constantly monitor remote git repositories for any changes. For every change it will build the project automatically. 

- **Stage III**: after exhaustive development and testing, every successfull built by Jenkins is automatically pushed to highly controlled Production Sandbox, where it is constantly monitored using parameters such as traffic utilization, CPU usage, Memory usage and etc. 


Implementation Detail
-------------
We have used 2 VCL machines for Stage I and Stage III servers. Stage II server is a local machine

 1. Stage I (Development Sandbox)= 152.7.99.118
 2. Stage II (Pre-Production Sandbox) = local machine
 3. Stage III (Production Sandbox) = 152.46.20.173

![ProjectPlan](https://github.com/maxlpy/Milestone---Special/blob/master/outputImages/specialMilestone.png)

	
Explanation, Installations and Settings
-------------
Install the following **ON ALL THREE INSTANCES (Stage I, II and III)** to achieve this Milestone
 1.  Download and install [java](http://docs.saltstack.com/en/latest/topics/installation/)
 2.  Download and Install [git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
 3. ON ALL THREE INSTANCES (master, canary1 and canary2) allow **all traffic** option selected from security group in AWS

In addition, every stage will have individual tools and development environments which are stated below according to every stage's individual requirement.

**Stage I: Development Sandbox** 
This development sandbox is used by developers. For the first stage the developer would build project using DEVELOPER tools such as git, eclipse, eclipse plugins such as find bugs for testing Every successful built would be pushed to remote git repository. 

The following tools are installed at Stage I:

 1. Eclipse
 2. Eclipse J2EE plugin with tomcat server to run Maven Project
 3. Eclipse FindBug plugin for testing and static analysis

 
**Stage II: Pre-Production Sandbox**
At the 2nd stage, Jenkins would is set up which is contantly monitoring the remote repository for any changes. For every change it builds automatically and every successfull build is then push to the production environment using git hooks

The following tools are installed at Stage II:

 - Jenkins
 - Jenkins plugins such as

Plugins installed for this milestone: <br>
 1. [GitHub Plugin](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin) 
 2. [NodeLabel Parameter Plugin](https://wiki.jenkins-ci.org/display/JENKINS/NodeLabel+Parameter+Plugin)
 3. [Maven Project Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Maven+Project+Plugin)
 4. [Config File Provider Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Config+File+Provider+Plugin)
 5. [Git Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin)
 6. [Git Client Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Client+Plugin)
 7. [Managed Script Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Managed+Script+Plugin)
 8. [GitHub API Plugin](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+API+Plugin)
 9. [FindBugs](https://wiki.jenkins-ci.org/display/JENKINS/FindBugs+Plugin)


**Stage III: Production Sandbox**

At the 3rd stage, the deployed application would be constantly monitored remotely using parameters such as CPU usage, Memory usage and etc. 

The following tool is installed at Stage II:

[Monitoring through
    node.js](https://github.com/CSC-DevOps/Monitoring)
    
    
Tasks at Every Stage
-------------

## Stage I: Setup Development Sandbox

### A. Developing Testing and Building Application

 - Developers would use eclipse to develop the application.
 - Eclipse plugins such as FindBugs can be used for testing and static
   analysis.

### B. Building Application locally

 - Developers would build the application locally by setting up a run
    environment for the application.
 - In this case, for J2EE maven project, we built the application
   locally using tomcat server

### C.  Pushing code to remote repository

 - If the code is bug-free, developers would push this code to remote git
   repository using simple git commands such as:

> git add .
> 
> git commit -m "{message}"
> 
> git push <remote_branch> <local_branch>

 - In this case,
   [Milestone#Special](https://github.com/maxlpy/Milestone---Special) is
   the remote git repository

## Stage II: Setup Pre-Production Sandbox

### A. Build Step using Jenkins

### C.  Pushing code to Production

Make canary1 and canary2 remote repositories to master. We will use git to deploy the code remotely using `post-receive hook` in bare git repository
 
The following steps should be followed to make canary1 and canary2 as remote repository of master

-- Steps for Master
 1. `ssh` to master using `ssh -i Nikhil.pem ubuntu@52.4.40.18` where `Nikhil.pem` is the AWS key file attached with this submission
 2. Clone [Milestone---Deploy](https://github.com/nkatre/Milestone---Deploy) repository
 3. cd Milestone---Deploy
 4. Transfer the key file Nikhil.pem to master from local using the command :

    scp -i Nikhil.pem Nikhil.pem ubuntu@52.4.40.18
 5. Generate ssh key at master and bind AWS key (Nikhil.pem) with this ssh key as follows

    ssh-keygen 

    cat ~/.ssh/id_rsa.pub | ssh -i Nikhil.pem ubuntu@52.5.33.235 "cat >> .ssh/authorized_keys"

    cat ~/.ssh/id_rsa.pub | ssh -i Nikhil.pem ubuntu@52.5.15.126 "cat >> .ssh/authorized_keys"
6. Bind this key with ssh command at master for authentication

     ssh-add Nikhil.pem

7. Setup SSH at MASTER

```bash
$ ssh-add Nikhil.pem
```

8. Add git remote

```bash
$ git remote add blue ssh://ubuntu@52.5.33.235/home/nkatreblue.git
$ git remote add green ssh://ubuntu@52.5.15.126/home/nkatre/green.git
```
Setup remote git repo on canary1

### Create a bare repository

```bash
$ mkdir blue.git
$ cd blue.git
$ git init --bare
```

### Set GIT_WORK_TREE

```bash
$ mkdir /home/ubuntu/blue-www/
$ cat > hooks/post-receive
#!/bin/sh
GIT_WORK_TREE=/home/ubuntu/blue-www/ git checkout -f


Make post-receive executable:
$ chmod +x hooks/post-receive

Select "All traffic" as inbound and outbound rules for EC2 instance
```

## Setup remote git repo on canary2

### Create a bare repository

```bash
$ mkdir green.git
$ cd green.git
$ git init --bare
```

### Set GIT_WORK_TREE

```bash
$ mkdir /home/ubuntu/green-www/
$ cat > hooks/post-receive
#!/bin/sh
GIT_WORK_TREE=/home/ubuntu/green-www/ git checkout -f


Make post-receive executable:
$ chmod +x hooks/post-receive


Select "All traffic" as inbound and outbound rules for EC2 instance
```
**OUTPUT:**
1. Pushing to blue repository (Canary1)
![BluePush](https://github.com/nkatre/Milestone---Deploy/blob/master/outputImages/bluePush.png)
2. Pushing to green repository (Canary2)
![GreenPush](https://github.com/nkatre/Milestone---Deploy/blob/master/outputImages/greenPush.png)


## Stage III: Monitoring deployed application

After deployment of new version on Production Sandbox, we are remotely monitoring the health of this server by parameters such as CPU usage, memory utilization, Fault number and Alert number.

One can visit **http://152.7.99.118/monitor.html** to check the status of the server.

We have also set a threshold parameter to simulate server failure condition. We use two paramaters which are constantly monitored.

    1. Memory Usage
    2. CPU Usage

***`ALERT:`* If the memory usage is above 30 and the CPU usage is above 20  then alert would be set off. *`FAILURE:`* If the memory usage if above 70 and the CPU usage is above 50 then the server would fail.**

To demonstrate this, follow the below mentioned images:

1. This image demonstrates alert when threshold values are crossed. Here the alert count is 1 (alert is set off) since the CPU usage is 33 which is above 20 and the memory usage is 45 which is above 30.
![Alert](https://github.com/nkatre/Milestone---Deploy/blob/master/outputImages/result1.png)
2. This image demonstrates that when the threshold values for failure are crossed. In this image since the memory usage is above 70 and the CPU usage is above 50 hence the server has crossed the failure threshold and has failed.
![Failure](https://github.com/nkatre/Milestone---Deploy/blob/master/outputImages/result3.png)


Milestone Presentation 
-------------

 - We have created a small video demonstrating the working of Milestone
   Special.
 - [Link to Presentation video (Milestone Special starts from
   3:48)](https://youtu.be/Pp_u_4Hcauc)


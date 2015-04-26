DevOps Milestone - Special
===================
Team Members:

 - Nikhil Katre (nkatre@ncsu.edu)
 - Pengyu Li (pli5@ncsu.edu)
 
Submission: **Milestone#Special** <br>
Submission Files:
>  - README.md
>  - Project Files
>  - Project Presentation Video (Starts from 3:48)

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

Diagram
![ProjectPlan](https://github.com/maxlpy/Milestone---Special/blob/master/outputImages/specialMilestone.png)

# DevOps_Test
Test of DevOps practices.

## Branch protection
Protection rules are enabled for <b>main</b> ( Production ) and <b>development</b> branches, ensuring no one can commit directly to them. Instead, a new branch has to be created for each new feature as pull requests are the only thing accepted in protected branches.


## Infrastructure:
- Auto scaling group
- EC2
- Security groups
- Load balancer
- IAM roles
- CodeDeploy application

![image](https://user-images.githubusercontent.com/36536477/135106749-86c383ac-cb11-445c-ad64-d33949257602.png)

The infrastructure consists on an ASG that generates 2 EC2 instances distrubuted among all availability zones of Ireland region(This ensures high availability for our application.)
This way, if a region goes down, we still have available the application in the other ones.
The load balancer distribute the inbound traffic among all EC2 instances on the target group(Instances that belong to the ASG).
The security groups allow ec2s to only accept incoming connections from the load balancer thus improving security.
IAM roles must be assigned to the ec2 instances so that the codeDeploy agent can make changes and thus implement continuous deployment
The ASG allows us to manage the number of instances raised depending on the accesses, so that if there is a lot of traffic, we will have more instances to be able to address it and when it decreases, the number of instances will do so as well.


## Application (CI/CD)
The application has implemented a CI/CD pipeline in github actions with CodeDeploy Agent.
### CI
The pipeline consists on a basic environment setup, a build stage and finally a testing phase.
For testing, we use the command `go test` on our previously built docker image, this executes our server_test.go file.
If testing phase is ok, the pipeline proceed to the CD part, if not, it ends there (It has no sense to deploy the code if it doesnt pass the tests).
### CD
We can divide this part of the workflow in tho phases, dockerHub and AWS.
First, we build and tag our image and then we upload it to our repository on dockerHub. Then, we login on AWS with our credentials (All of our secrets are stored on repository secrets) and we use CodeDeploy agent to deploy the new code on our EC2 instances.

## Application (Coding)
I have implemented a health-check endpoint where you can check if your API is healthy and some testing for the two handlers.
Server.go -> Where the API code is stored
Test_server.go -> Where the testing functions are stored.

## How to use
- Set up your dockerHub user and password as repository secrets. Store them as USER, PASSWORD
- Do the same with your aws credentials. Store them AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
- Clone the repository and go to the 1_infrastructure folder.
- Create a terraform.tfvars file and store the following data:
    * aws_access_key =
    * aws_secret_key =
    * aws_region     =
    * aws_key        =
    * aws_vpc        =
    * aws_az         =
    * aws_inst_type  =
    * aws_image_id   =
- Then run `terraform init` & `terraform apply` command.
- When it ends, you whould have set up the whole aws infrastructure.
- In AWS go to EC2 > Load Balancer > holded. Copy the public address and paste it on your web browser, you will be redirected to the server on your EC2 instances.
- If you make some changes on main branch, the code on your instances will be updated too.

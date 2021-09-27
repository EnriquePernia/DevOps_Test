# DevOps_Test
Test of DevOps practices.

## Branch protection
- Protection rules are enabled for <b>main</b> ( Production ) and <b>development</b> branches, ensuring no one can commit directly to them. Instead, a new branch has to be created for each new feature as pull requests are the only thing accepted in protected branches.


## Infrastructure:
- Auto scaling group
- EC2
- Security groups
- Load balancer

The infrastructure consists on an ASG that generates 2 EC2 instances distrubuted among all availability zones of Ireland region(This ensures high availability for our application.)
This way, if a region goes down, we still have available the application in the other ones.
The load balancer distribute the inbound traffic among all EC2 instances on the target group(Instances that belong to the ASG).
The security groups allow ec2s to only accept incoming connections from the load balancer thus improving security. 

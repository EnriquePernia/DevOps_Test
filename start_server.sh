#!/bin/bash
docker stop $(docker ps -a -q)
docker build -t go-app /home/ec2-user/2_application
docker run -p 80:8080 -d go-app

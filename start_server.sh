#!/bin/bash
docker build -t go-app ./2_application
docker run -p 80:8080 go-app
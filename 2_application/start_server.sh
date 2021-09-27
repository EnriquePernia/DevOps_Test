#!/bin/bash
docker build -t go-app .
docker run -p 80:8080 go-app
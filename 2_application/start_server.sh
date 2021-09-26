#!/bin/bash
docker build -t go-app .
docker run -p 8080:8080 go-app
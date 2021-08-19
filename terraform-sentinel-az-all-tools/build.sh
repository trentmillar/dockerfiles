#!/bin/bash
TAG="2021-08-07"

docker login

docker build \
    -t eatatjoes/terraform-sentinel-az-tools:$TAG \
    .

docker push eatatjoes/terraform-sentinel-az-tools:$TAG

docker tag eatatjoes/terraform-sentinel-az-tools:$TAG eatatjoes/terraform-sentinel-az-tools:latest
docker push eatatjoes/terraform-sentinel-az-tools:latest

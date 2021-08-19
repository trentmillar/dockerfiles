#!/bin/bash
TAG="2021-08-07"

docker login

docker build \
    -t eatatjoes/lite-baseline:$TAG \
    .

docker push eatatjoes/lite-baseline:$TAG

docker tag eatatjoes/lite-baseline:$TAG eatatjoes/lite-baseline:latest
docker push eatatjoes/lite-baseline:latest

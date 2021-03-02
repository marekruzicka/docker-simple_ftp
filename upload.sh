#!/bin/bash

# This script will upload tested image to gitlab docker registry.
# It is meant to be run ONLY on gitlab-runner within a CICD pipeline.

# Unlike build.sh, test.sh and cleanup.sh, it will not work when run locally (in developemnt enviornment).

# basic configuration is read from .gitlab-ci.config

# read configuration
. .gitlab-ci.config

docker login -u gitlab-ci-token -p $CI_BUILD_TOKEN $REGISTRY
docker push $IMAGE_NAME:$version
docker tag $IMAGE_NAME:$version $IMAGE_NAME:latest
docker push $IMAGE_NAME:latest
docker logout $REGISTRY


#!/bin/bash
set -e

###
# This is a cleanup script that should always run as a last job within CICD pipeline.
# It should make sure, that no container is left behind after successful test run.
#
# It will perform following steps:
# 1. stopping the tested container
# 2. removing the tested image (if run with --remove)
###

# basic configuration is read from .gitlab-ci.config

# read configuration
. .gitlab-ci.config


# stop the container
# since test.sh runs container with --rm, it will be also removed
docker stop $APP_NAME || true

# remove created docker images if cleanup.sh was run with --remove
[[ $1 == "--remove" ]] && docker images | grep $APP_NAME | grep $version | awk '{print $3}' | xargs docker rmi -f


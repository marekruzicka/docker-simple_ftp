#!/bin/bash

# Universal build script for docker containers.
# basic configuration is read from .gitlab-ci.config

# read configuration
. .gitlab-ci.config

# if --no-cache is provided as cli argument, pass it to local build in a safe manner
# (Building on ci_runner always uses --no-cache)
NO_CACHE=""
[[ $1 == "--no-cache" ]] && NO_CACHE="--no-cache"


# REGISTRY is env variable set on ci_runner
# if empty, use simple tag
if [[ -z $REGISTRY ]]; then
        docker build $NO_CACHE -t $APP_NAME:$version .
        docker tag $APP_NAME:$version $APP_NAME:latest
else
# else construct proper registry tag from CI_PROJECT_DIR env variable,
# REGISTRY and version and set --no-cache        
# 172.27.10.10:4567/openstack/docker-app_name/
        REPO=`echo $CI_PROJECT_DIR | awk -F "/" '{print $(NF-1)"/"$NF}'`
        docker build --no-cache -t $REGISTRY/$REPO:$version .
fi


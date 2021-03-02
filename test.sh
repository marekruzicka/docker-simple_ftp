#!/bin/bash

###
# This is a unit (basic) test that should be performed on the image by CICD workflow.
# It should test the basic functionality of the application after container is run.
# 
# Try to keep it as simple as possible.
# Running a container and testing if application is listening on predefined socket (IP:port)
# is bare (but for the time being) sufficient minimum.
###

# This script is meant to be run right after 'build.sh'

# basic configuration is read from .gitlab-ci.config

# read configuration
. .gitlab-ci.config

# ======
# Following variables are available for use based on .gitlab-ci.config
# $APP_NAME     = name of your app without 'docker-'    (/../docker-app_name > app_name)
# $version      = docker tag                            (derived from the current git commit hash)
# $IMAGE_name   = full name of the docker image including registry path
# $IMAGE        = $IMAGE_NAME:$version                  (full name of docker image including current tag)
#
# more info in .gitlab-ci.config file


# ====================== Simple example  ======================

# run docker container with configuration required for testing
#  TEST_IP="127.127.127.127"
#  TEST_PORT=12345
#  
#  docker run -d --rm --net=host -e TEST_IP=$TEST_IP -e TEST_PORT=$TEST_PORT --name $APP_NAME $IMAGE
#  
#  
#  # testing loop
#  # Let's check if application comes up and start to listen on pre-defined socket within 30s
#  
#  # Let's set the time limit on test, we don't want it to run indefinitely
#  counter=0
#  while [[ $counter -lt 30 ]]; do 
#          
#          # let's check if we can find listening socket, and stop the test if yes
#          ss -ntl4 | grep -w "$TEST_IP:$TEST_PORT" &>/dev/null && break
#
#          # if we did not detect the socket, let's wait for a second, increment the counter and repeat
#          echo -n ". "
#          sleep 1
#          ((counter++))
#  done
#  
#  # evaluation
#  If counter does not equal 30, it means we jumped out of the loop within 30s because our test passed
#  
#  if [[ $counter -ne 30 ]]; then
#          echo -e "\nHAProxy is UP"
#  else
# 
#  # If it does equal 30, our application does not work, or it needs more than 30s to start.
#          echo -e "\nHAProxy did not come up within the time limit... exiting(1)."
#          exit 1
#  fi

exit 1



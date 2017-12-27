#!/bin/bash
#generate ~/.bash_profile with forwarded env vars from docker container
if [ -e /Users/vagrant/provisioned ]
then
  echo "starting teamcity"
  su vagrant -c 'bash /Users/vagrant/tc.sh'
  sleep 100m
else
 echo "not provisioned yet"
fi


#!/bin/bash

#source ~/.bash_profile

source /Users/vagrant/env

export AGENT_DIST=/Users/vagrant/buildAgent

export CONFIG_DIR=/Users/vagrant/buildAgent/conf

export LOG_DIR=/Users/vagrant/buildAgent/logs


chmod +x ${AGENT_DIST}/bin/*.sh; sync

#${AGENT_DIST}/bin/mac.launchd.sh load

check() {
   if [[ $? != 0 ]]; then
      echo "Error! Stopping the script."
      exit 1
   fi
}

configure() {
  if [[ $# -gt 0 ]]; then
    echo "run agent.sh configure" $*
    ${AGENT_DIST}/bin/agent.sh configure $*; check
  fi
}

reconfigure() {
    local opts=""
    [[ -n "${SERVER_URL}" ]] && opts="$opts --server-url ${SERVER_URL}"
    [[ -n "${AGENT_TOKEN}" ]] && opts="$opts --auth-token ${AGENT_TOKEN}"
    [[ -n "${AGENT_NAME}" ]]  && opts="$opts --name ${AGENT_NAME}"
    # Using sed to strip double quotes produced by docker-compose
    [[ -n "$opts" ]] && (configure $(echo "${opts}" | sed -e 's/""/"/g'); echo "File buildAgent.properties was updated")
}

prepare_conf() {
    echo "Will prepare agent config" ;
    #cp -p ${AGENT_DIST}/conf/*.* ${CONFIG_DIR}/; check
    cp -p ${CONFIG_DIR}/buildAgent.dist.properties ${CONFIG_DIR}/buildAgent.properties; check
    reconfigure
    echo "File buildAgent.properties was created and updated" ;
}



chmod +x ${AGENT_DIST}/bin/*.sh; check; sync

rm -f ${LOG_DIR}/*.pid

if [ -f ${CONFIG_DIR}/buildAgent.properties ] ; then
   echo "File buildAgent.properties was found in ${CONFIG_DIR}" ;
   reconfigure
else
   echo "Will create new buildAgent.properties using distributive" ;
   if [[ -n "${SERVER_URL}" ]]; then
      echo "TeamCity URL is provided: ${SERVER_URL}"
   else
      echo "TeamCity URL is not provided, but is required."
      exit 1
   fi
   prepare_conf
fi

${AGENT_DIST}/bin/agent.sh start

while [ ! -f ${LOG_DIR}/teamcity-agent.log ];
do
   echo -n "."
   sleep 1
done

trap "${AGENT_DIST}/bin/agent.sh stop; exit 0;" SIGINT SIGTERM SIGHUP

touch ~/anchor

tail -qF ${LOG_DIR}/teamcity-agent.log ~/anchor &
wait






#!/bin/bash

source tc_lib.sh

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






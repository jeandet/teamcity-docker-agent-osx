#!/bin/bash

export SERVER_URL=https://hephaistos.lpp.polytechnique.fr/teamcity

source tc_lib.sh


${AGENT_DIST}/bin/agent.sh start&
sleep 300 #wait until update complete
${AGENT_DIST}/bin/agent.sh stop
sleep 30
rm ${AGENT_DIST}/logs/buildAgent.pid
rm ${AGENT_DIST}/logs/output.log





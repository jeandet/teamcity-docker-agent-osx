#!/bin/bash
docker build  -v /dev/vboxdrv:/dev/vboxdrv -v /dev/vboxnetctl:/dev/vboxnetctl -t lpp/teamcity_agent_osx .
docker run -d=true --privileged --net=host -v /dev/vboxdrv:/dev/vboxdrv -v /dev/vboxnetctl:/dev/vboxnetctl --name=tcosx -it lpp/teamcity_agent_osx &
sleep 1000
docker stop tcosx
docker commit tcosx lpp/teamcity_agent_osx
docker rm tcosx


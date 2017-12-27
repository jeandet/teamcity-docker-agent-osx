sudo docker build  -v /dev/vboxdrv:/dev/vboxdrv -v /dev/vboxnetctl:/dev/vboxnetctl -t lpp/teamcity_agent_osx .
sudo docker run --privileged --net=host -v /dev/vboxdrv:/dev/vboxdrv -v /dev/vboxnetctl:/dev/vboxnetctl --name=tcosx -it lpp/teamcity_agent_osx
sudo docker stop tcosx
sudo docker commit tcosx lpp/teamcity_agent_osx
sudo docker rm tcosx


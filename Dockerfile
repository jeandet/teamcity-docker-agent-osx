# Pull base image.
FROM fedora:27
MAINTAINER Alexis Jeandet "alexis.jeandet@member.fsf.org"

# Install.
RUN dnf install -y http://download.virtualbox.org/virtualbox/5.1.30/VirtualBox-5.1-5.1.30_118389_fedora26-1.x86_64.rpm unzip xonsh vagrant

# Add files.
RUN mkdir -p ./buildAgent
ADD start_vm.xsh ./
ADD start.sh ./
ADD tc.sh ./
ADD tc_lib.sh ./
ADD tc_update.sh ./
ADD bootstrap.sh ./
ADD Vagrantfile ./

ADD https://teamcity.jetbrains.com/update/buildAgent.zip ./
RUN unzip ./buildAgent.zip -d ./buildAgent/ && \
     chmod +x ./start_vm.xsh && \
     chmod +x ./start.sh && \
     chmod +x ./tc.sh && \
     touch ./env && \
     echo "" >> ./buildAgent/conf/buildAgent.dist.properties && \
     echo "system.osx=true" >> ./buildAgent/conf/buildAgent.dist.properties && \
     echo "system.os=OSX" >> ./buildAgent/conf/buildAgent.dist.properties && \
     echo "system.agent_name=osx" >> ./buildAgent/conf/buildAgent.dist.properties  && \
     echo "system.agent_repo=https://github.com/jeandet/teamcity-docker-agent-osx" >> ./buildAgent/conf/buildAgent.dist.properties


# Define working directory.
WORKDIR ./

# Ports open.
EXPOSE 22 5800 5900 5901

# Define default command.
CMD ./start_vm.xsh

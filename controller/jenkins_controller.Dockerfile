# Docerfile to build a jenkins image - copied from https://www.jenkins.io/doc/book/installing/docker/

# LTS jenkins image
FROM jenkins/jenkins:jdk17

# expose ports to other containers
EXPOSE 8080 50000

# root as opposed to the jenkins user
USER root

# update
RUN apt-get update && apt-get install -y lsb-release

# ?
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg

# ?
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# if we aren't mounting the host's docker binary to the container we need to install it directly into the container.
# for some reaosn mounting doesn't work. tried chmoding and chowning. Could try again.
# RUN apt-get update && apt-get install -y docker-ce-cli

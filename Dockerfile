# Docerfile to build a jenkins image - copied from https://www.jenkins.io/doc/book/installing/docker/

# LTS jenkins image
FROM jenkins/jenkins:lts-jdk17

# root as opposed to the jenkins user
USER root

# update
RUN apt-get update && apt-get install -y lsb-release

# ?
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg

# ?
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# if we aren't mounting the host's docker binary to the container we need to install it directly into the container. Unlikely.
RUN apt-get update && apt-get install -y docker-ce-cli

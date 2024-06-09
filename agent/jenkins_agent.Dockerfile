FROM jenkins/ssh-agent:alpine-jdk17 AS base

USER root

RUN uname -a && cat /etc/*release

# expose for the contoller to access the agent
EXPOSE 22

RUN apk update && apk add dotnet6-sdk

# for debian, not needed as we're on alpine
#RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb && apt-get update && apt-get install -y dotnet-sdk-8.0 && export PATH=$PATH:$HOME/dotnet && dotnet --version

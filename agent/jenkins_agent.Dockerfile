FROM jenkins/ssh-agent:jdk11 AS base

USER root

RUN uname -a && cat /etc/*release

EXPOSE 22

# Based on instructiions at https://learn.microsoft.com/en-us/dotnet/core/linux-prerequisites?tabs=netcore2x
# Install depency for dotnet core 2.
RUN apt-get update && apt-get install -y gpg && apt-get install -y --no-install-recommends curl libunwind8 gettext apt-transport-https && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/dotnetdev.list' && apt-get update

# Install the .Net Core framework, set the path, and show the version of core installed.
RUN apt-get install -y dotnet-runtime-6.0.0 && export PATH=$PATH:$HOME/dotnet && dotnet --version

FROM jenkins/ssh-agent:alpine-jdk17 AS base

# schloogie
USER root

# bloogie
RUN uname -a && cat /etc/*release

# expose for the contoller to access the agent
EXPOSE 22

RUN apk update && apk add wget

# get the install script, change file perms, get deps
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh && chmod +x ./dotnet-install.sh && apk add libstdc++ && apk add libgcc

# run install script
RUN ./dotnet-install.sh --channel 8.0 --install-dir /opt/.dotnet

# Add environment variables to bash profile
RUN echo 'export DOTNET_ROOT=/opt/.dotnet' >> /etc/.bashrc && echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> /etc/.bashrc

# for debian, not needed as we're on alpine
#RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb && apt-get update && apt-get install -y dotnet-sdk-8.0 && export PATH=$PATH:$HOME/dotnet && dotnet --version

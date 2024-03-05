# node > 14.6.0 is required for the SFDX-Git-Delta plugin
FROM node:14.14-alpine

#add usefull tools
RUN apk add --update --no-cache  \
      git \
      findutils \
      bash \
      unzip \
      curl \
      wget \
      nodejs-npm \
      openjdk8-jre \
      openssh-client \
      perl \
      jq

# install Salesforce CLI from npm
RUN wget https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz
RUN mkdir sfdx-cli
RUN tar xJf sfdx-linux-amd64.tar.xz -C sfdx-cli --strip-components 1
RUN ./sfdx-cli/install
RUN sfdx --version
RUN sfdx plugins --core
RUN sfdx update

# install SFDX-Git-Delta plugin - https://github.com/scolladon/sfdx-git-delta
RUN echo 'y' | sfdx plugins:install sfdx-git-delta
RUN sfdx plugins
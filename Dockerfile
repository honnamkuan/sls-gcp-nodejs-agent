FROM jenkinsciinfra/inbound-agent-node:latest

USER root

RUN apk update && apk add curl python3

USER jenkins

RUN curl https://sdk.cloud.google.com > ~/install.sh && sh ~/install.sh --disable-prompts

WORKDIR /home/jenkins

ENV PATH ~/google-cloud-sdk/bin:$PATH

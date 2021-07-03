FROM jenkins/jnlp-slave:latest

USER root

RUN apt-get update
RUN apt-get install -y dnsutils python3

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 12.16.1

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default node \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN npm install npm@latest -g

RUN curl https://sdk.cloud.google.com > install.sh
RUN bash install.sh --disable-prompts

ENV PATH /root/google-cloud-sdk/bin:$PATH

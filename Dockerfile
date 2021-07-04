FROM jenkins/inbound-agent:alpine

ARG NODE_VER_ARG=14.17.2

USER root

RUN apk update && apk add python3 curl bash ca-certificates openssl ncurses coreutils make gcc g++ libgcc linux-headers grep util-linux binutils findutils

USER jenkins

ENV NVM_DIR /home/jenkins/.nvm
ENV NODE_VERSION=${NODE_VER_ARG}

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default node \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN npm install npm@latest -g

RUN curl https://sdk.cloud.google.com > ~/install.sh && sh ~/install.sh --disable-prompts

WORKDIR /home/jenkins

ENV PATH ~/google-cloud-sdk/bin:$PATH

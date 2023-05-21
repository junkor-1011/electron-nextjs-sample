FROM docker.io/library/buildpack-deps:jammy

ENV DEBIAN_FRONTEND noninteractive

ARG NODE_VERSION="18.16.0"
ARG PNPM_VERSION="8.5.1"
ARG YARN_VERSION="1.22.19"
ARG NPM_VERSION="9.6.7"

RUN curl -L https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz | tar xz -C /usr/local --strip-components=1 && \
  unlink /usr/local/CHANGELOG.md && unlink /usr/local/LICENSE && unlink /usr/local/README.md
RUN corepack enable pnpm yarn npm && \
    corepack prepare pnpm@${PNPM_VERSION} --activate && \
    corepack prepare yarn@${YARN_VERSION} --activate && \
    corepack prepare npm@${NPM_VERSION}

# for electron builder
# ...

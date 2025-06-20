FROM node:22-alpine

ARG N8N_VERSION=latest
ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

ARG USERNAME
ARG PASSWORD
ARG ENCRYPTIONKEY

ENV N8N_ENCRYPTION_KEY=$ENCRYPTIONKEY
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD

ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=$USERNAME
ENV N8N_BASIC_AUTH_PASSWORD=$PASSWORD

ENV N8N_USER_ID=root

RUN apk add --update graphicsmagick tzdata

USER root

RUN apk add --no-cache ffmpeg fontconfig ttf-dejavu ttf-liberation ttf-opensans imagemagick
RUN apk --update add --virtual build-dependencies python3 build-base && \
    npm_config_user=root npm install --location=global n8n@${N8N_VERSION} && \
    apk del build-dependencies

WORKDIR /data

EXPOSE $PORT

CMD export N8N_PORT=$PORT && n8n start





ARG ALPINE_VERSION=3.14.1

FROM alpine:$ALPINE_VERSION

USER root
WORKDIR /root/download

RUN apk --update add \
    unzip \
    wget \
    openssl \
    curl

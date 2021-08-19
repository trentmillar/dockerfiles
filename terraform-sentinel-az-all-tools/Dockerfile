ARG TERRAFORM14_VERSION="0.14.11"
ARG TERRAFORM_VERSION="1.0.4"
ARG SENTINEL_VERSION="0.18.4"
ARG AZ_CLI_VERSION="2.27.0-1~focal"
ARG OPENSSH_VERSION="8.6p1"
ARG LITE_VERSION="2021-08-07"

FROM eatatjoes/lite-baseline:$LITE_VERSION as builder

ARG TERRAFORM14_VERSION
ARG TERRAFORM_VERSION
ARG SENTINEL_VERSION

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM14_VERSION}/terraform\_${TERRAFORM14_VERSION}\_linux_amd64.zip && \
    unzip ./terraform\_${TERRAFORM14_VERSION}\_linux_amd64.zip -d terraform14_cli

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform\_${TERRAFORM_VERSION}\_linux_amd64.zip && \
    unzip ./terraform\_${TERRAFORM_VERSION}\_linux_amd64.zip -d terraform_cli

RUN curl https://releases.hashicorp.com/sentinel/${SENTINEL_VERSION}/sentinel_${SENTINEL_VERSION}_linux_amd64.zip --output ./sentinel.zip && \
  unzip ./sentinel.zip -d ./sentinel_binary

FROM ubuntu:20.04

ARG AZ_CLI_VERSION
ARG OPENSSH_VERSION

ENV EDITOR nano
ENV DEBIAN_FRONTEND noninteractive

USER root
WORKDIR /root

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    apt-utils \
    apt-transport-https \
    bash-completion \
    bc \
    build-essential \
    ca-certificates \
    curl \
    dnsutils \
    fping \
    git \
    gnupg \
    gnupg2 \
    groff \
    iputils-ping \
    jq \
    less \
    libssl-dev \
    locales \
    lsb-release \
    nano \
    net-tools \
    netcat \
    openssl \
    python3 \
    python3-dev \
    python3-pip \
    software-properties-common \
    sudo \
    telnet \
    tcptraceroute \
    traceroute \
    unzip \
    uuid-runtime \
    vim \
    wget \
    zip \
    zlib1g-dev &&\
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/archives/*

RUN locale-gen en_US.UTF-8
RUN apt-get update && \
    apt-get install -y

RUN wget "https://mirror.exonetric.net/pub/OpenBSD/OpenSSH/portable/openssh-${OPENSSH_VERSION}.tar.gz" --no-check-certificate && \
    tar xfz openssh-${OPENSSH_VERSION}.tar.gz && \
    cd openssh-${OPENSSH_VERSION} && \
    ./configure && \
    make && \
    make install && \
    rm -rf ../openssh-${OPENSSH_VERSION}.tar.gz ../openssh-${OPENSSH_VERSION} && \
    ssh -V

RUN pip3 install pip --upgrade
RUN pip3 install cryptography
RUN pip3 install \
    hvac \
    jmespath \
    netaddr \
    passlib \
    pbr \
    pip \
    pyOpenSSL \
    pyvmomi \
    setuptools

RUN apt remove azure-cli -y && apt autoremove -y && \
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null && \
    AZ_REPO=$(lsb_release -cs) && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli=$AZ_CLI_VERSION && \
    az --version && \
    az extension add --name azure-devops

COPY --from=builder "/root/download/terraform14_cli/terraform" "/usr/local/bin/terraform14"
COPY --from=builder "/root/download/terraform_cli/terraform" "/usr/local/bin/terraform"
COPY --from=builder "/root/download/sentinel_binary/sentinel" "/usr/local/bin/sentinel"

RUN chmod -R +x /usr/local/bin && \
    terraform14 version && \
    terraform version && \
    sentinel --version

WORKDIR /root/project
CMD ["/bin/bash"]
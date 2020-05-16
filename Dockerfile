FROM ubuntu

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt-get update -qq && \
    apt-get install -qq \
        curl \
        unzip \
        ca-certificates \
        coreutils \
        python3 \
        python3-pip \
        && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Amazon RDS SSL certs
RUN cd /usr/local/share/ca-certificates && \
    curl -sO https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem && \
    csplit -z -f rds-combined-ca-bundle -b '%02d.crt' rds-combined-ca-bundle.pem '/-----BEGIN CERTIFICATE-----/' '{*}' && \
    update-ca-certificates

# Citus Data SSL certs
RUN cd /usr/local/share/ca-certificates && \
    curl -Ssl -O https://console.citusdata.com/citus.crt && \
    csplit -z -f citus -b '%02d.crt' citus.crt '/-----BEGIN CERTIFICATE-----/' '{*}' && \
    update-ca-certificates    

# aws cli
RUN pip3 install awscli --upgrade

# gcloud cli
RUN GCLOUD_VERSION=292.0.0 \
    && curl -s -o google-cloud.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$GCLOUD_VERSION-linux-x86_64.tar.gz \
    && tar xvfz google-cloud.tar.gz \
    && rm google-cloud.tar.gz \
    && google-cloud-sdk/install.sh --quiet \
    && google-cloud-sdk/bin/gcloud config set disable_usage_reporting true

# dbcrossbar itself
RUN curl -sSL https://github.com/dbcrossbar/dbcrossbar/releases/download/v0.4.0-alpha.1/dbcrossbar-v0.4.0-alpha.1-linux.zip > dbcrossbar.zip && \
    unzip dbcrossbar.zip && \
    mv dbcrossbar /usr/local/bin/ && \
    dbcrossbar --version

# https://github.com/dbcrossbar/dbcrossbar/issues/125
RUN mkdir -p /root/.local/share
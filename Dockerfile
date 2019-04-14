# our base image
FROM ubuntu:latest

ENV DEBIAN_FRONTEND "noninteractive apt-get autoremove" \
    CLOUDSDK_CORE_DISABLE_PROMPTS=1 \
    LANG=en_AU.UTF-8 \
    LANGUAGE=en_AU.UTF-8 \
    LC_ALL=en_AU.UTF-8 \
    LC_CTYPE=en_AU.UTF-8 \
    TZ="Australia/Adelaide"

RUN apt-get update && apt-get install -yq \
    locales \
    && locale-gen en_AU.UTF-8 \
    && dpkg-reconfigure locales \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -yq \
    curl \
    python \
    git \
    sudo \
    docker \
    && curl https://sdk.cloud.google.com | bash \
    && rm -rf /var/lib/apt/lists/* \

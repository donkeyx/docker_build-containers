# our base image
FROM ubuntu:latest

ENV DEBIAN_FRONTEND "noninteractive apt-get autoremove"
RUN apt-get update && apt-get install -y locales \
    && locale-gen en_AU.UTF-8 \
    && dpkg-reconfigure locales \
    && rm -rf /var/lib/apt/lists/*
ENV LANG en_AU.UTF-8
ENV LANGUAGE en_AU.UTF-8
ENV LC_ALL en_AU.UTF-8
ENV LC_CTYPE=en_AU.UTF-8
ENV TZ="Australia/Adelaide"

# client tools for db + redis/mongo
RUN apt-get install -y \
    git \
    nodejs npm \
    && rm -rf /var/lib/apt/lists/*

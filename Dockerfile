# our base image
FROM ubuntu:latest

ENV OS_VERSION='grep VERSION_CODENAME /etc/os-release | cut -d "=" -f 2'
ENV DEBIAN_FRONTEND noninteractive apt-get autoremove
ENV LANG en_AU.UTF-8
ENV LC_ALL en_AU.UTF-8
ENV LC_CTYPE en_AU.UTF-8
ENV TZ Australia/Adelaide


RUN apt-get -qq update && apt-get install --no-install-recommends -yq \
    apt-utils locales \
    && locale-gen en_AU \
    && locale-gen en_AU.UTF-8 \
    && update-locale \
    && dpkg-reconfigure locales \
    && echo locale \
    && apt-get clean -yq && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



RUN apt-get -qq update && apt-get install --no-install-recommends -yq \
    gnupg jq curl git sudo python \
    && apt-get install --no-install-recommends -yq \
    # python-distutils \
    libpython2.7-stdlib \
    ca-certificates \
    # && ln -s /usr/bin/python3.7 /usr/bin/python \
    && curl -L https://bootstrap.pypa.io/get-pip.py | python - \
    && python --version \
    && apt-get clean -yq && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-`eval $OS_VERSION` main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
    && apt-get -qq update && apt-get install --no-install-recommends -yq \
    google-cloud-sdk \
    && apt-get clean -yq && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DOCKER_OPTS="-s overlay"
RUN echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" | sudo tee -a /etc/apt/sources.list.d/docker-ce.list \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && apt-get -qq update && apt-get install --no-install-recommends -yq \
    docker-ce \
    && apt-get clean -yq && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./startup.sh .
CMD ["/bin/bash", "./startup.sh"]

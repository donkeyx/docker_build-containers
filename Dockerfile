# our base image
FROM ubuntu:latest

ENV DEBIAN_FRONTEND="noninteractive apt-get autoremove" \
    CLOUDSDK_CORE_DISABLE_PROMPTS=1 \
    LANG="en_AU.UTF-8" \
    LANGUAGE="en_AU.UTF-8" \
    LC_ALL="en_AU.UTF-8" \
    LC_CTYPE="en_AU.UTF-8" \
    TZ="Australia/Adelaide"

RUN apt-get update && apt-get install --no-install-recommends -yq \
    locales \
    && locale-gen en_AU.UTF-8 \
    && dpkg-reconfigure locales \
    && apt-get clean -yq && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && apt-get install --no-install-recommends -yq \
    curl \
    python \
    git \
    sudo \
    docker.io \
    && apt-get clean -yq && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN curl -k -O "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-241.0.0-linux-x86_64.tar.gz" \
    && tar -xvf google-cloud-sdk-241.0.0-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh \
    && rm google-cloud-sdk-241.0.0-linux-x86_64.tar.gz \
    && echo "source /google-cloud-sdk/completion.bash.inc" >> /root/.bashrc \
    && echo "source /google-cloud-sdk/path.bash.inc" >> /root/.bashrc \
    && apt-get clean -yq && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/bin/bash"]

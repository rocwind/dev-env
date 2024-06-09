# based on ubuntu
FROM ubuntu:24.04

# build tools, net tools and other apt packages
RUN apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    git-lfs \
    gnupg \
    net-tools \
    python3 \
    sudo \
    tree \
    vim \
    wget \
    && apt-get clean

# add dev user
RUN useradd -m dev \
    && echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# golang
ENV GO_VERSION=1.22.4
RUN wget -O go.tgz https://dl.google.com/go/go$GO_VERSION.linux-arm64.tar.gz \
    && tar -C /usr/local -xzf go.tgz \
    && rm go.tgz
ENV PATH /usr/local/go/bin:$PATH

# don't auto-upgrade the gotoolchain
# https://github.com/docker-library/golang/issues/472
ENV GOTOOLCHAIN=local

# nodejs
ENV NODE_MAJOR=20
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key |gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install nodejs -y \
    && apt-get clean

# rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH


# default to dev user
USER dev

ENV GOPATH /home/dev/go
ENV PATH $GOPATH/bin:$PATH
# prepare folders
RUN mkdir -p /home/dev/.npm "$GOPATH/src" "$GOPATH/bin"

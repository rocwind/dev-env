# based on ubuntu
FROM ubuntu:22.04

# build tools, net tools and other apt packages
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    net-tools \
    ca-certificates \
    curl \
    wget \
    gnupg \
    tree \
    && apt-get clean

# golang
ENV GO_VERSION=1.21.1
RUN wget -O go.tgz https://dl.google.com/go/go$GO_VERSION.linux-arm64.tar.gz \
    && tar -C /usr/local -xzf go.tgz \
    && rm go.tgz
ENV PATH /usr/local/go/bin:$PATH
# don't auto-upgrade the gotoolchain
# https://github.com/docker-library/golang/issues/472
ENV GOTOOLCHAIN=local

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 1777 "$GOPATH"

# nodejs
ENV NODE_MAJOR=18
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key |gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install nodejs -y \
    && apt-get clean

# rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH
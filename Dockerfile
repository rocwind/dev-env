# based on ubuntu
FROM ubuntu:22.04

# build tools, net tools and other apt packages
RUN apt-get update && apt-get install -y build-essential python3 net-tools

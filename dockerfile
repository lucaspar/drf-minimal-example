FROM ubuntu:24.10

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages
RUN apt-get update && apt-get install -y \
    curl wget git

RUN apt-get install -y \
    build-essential libhdf5-dev

# create a non-root user
ARG USER_ID
ARG GROUP_ID
# RUN useradd -m -u $USER_ID -g $GROUP_ID -s /bin/bash user

COPY --chown=$USER_ID:$GROUP_ID . /app

USER user

WORKDIR /app

FROM ubuntu:24.10

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages
RUN apt-get update && apt-get install -y \
    curl wget git

RUN apt-get install -y \
    build-essential libhdf5-dev

# change this to your user id: `id -u`
USER 1000

WORKDIR /app

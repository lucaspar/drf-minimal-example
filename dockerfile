# 24.04 FAILS
# FROM ubuntu:24.04
# 24.10 works
# FROM ubuntu:24.10
# python:3-bookworm works
# FROM python:3-bookworm
# python:3-slim-bookworm works
FROM python:3-slim-bookworm

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# update and install basic packages
RUN apt-get update && apt-get install -y \
    curl wget git

RUN apt-get install -y \
    build-essential libhdf5-dev

# attempt to fix 24.04 error:
RUN apt-get install -y \
    hdf5-tools python3-h5py libhdf5-serial-dev

# create a non-root user
ARG USER_ID
ARG GROUP_ID
RUN useradd -m -u $USER_ID -s /bin/bash user
ENV HOME=/home/user
RUN mkdir -p $HOME
RUN chown -R $USER_ID $HOME

# permission fixes
RUN mkdir -p /.cache/uv
RUN chown -R 1000:1000 /.cache/uv

COPY --chown=$USER_ID . /app

USER user

WORKDIR /app

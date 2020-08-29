FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04

MAINTAINER Bruno Cabral <bruno@potelo.com.br>

USER root

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y software-properties-common bash

RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update


RUN apt-get -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        gcc \
        g++ \
        python3.8 \
        python3.8-venv \
        python3.8-dev \
        default-libmysqlclient-dev \
        zlibc \
        openssh-server \
        zlib1g-dev \
        libssl-dev \
        libbz2-dev \
        libsqlite3-dev \
        libncurses5-dev \
        libgdbm-dev \
        libgdbm-compat-dev \
        liblzma-dev \
        libreadline-dev \
        uuid-dev \
        libffi-dev \
        tk-dev \
        wget \
        htop \
        curl \
        git \
        zip \
        screen \
        make \
        sudo \
        bash-completion \
        tree \
        vim \
        nano \
        fail2ban


RUN apt-get -y autoclean && \
    apt-get -y autoremove

RUN python3.8 -m ensurepip
RUN python3.8 -m pip install poetry

# Enable tab completion by uncommenting it from /etc/bash.bashrc
# The relevant lines are those below the phrase "enable bash completion in interactive shells"
RUN export SED_RANGE="$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+1)),$(($(sed -n '\|enable bash completion in interactive shells|=' /etc/bash.bashrc)+7))" && \
    sed -i -e "${SED_RANGE}"' s/^#//' /etc/bash.bashrc && \
    unset SED_RANGE


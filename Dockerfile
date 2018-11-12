FROM ubuntu:16.04
MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

RUN \
	DEBIAN_FRONTEND=noninteractive apt-get -qq update && \
	DEBIAN_FRONTEND=noninteractive apt-get -qqy install \
		ccache \
		build-essential \
		python \
		python-pip \
		qemu \
		sudo \
		vim \
		libgcc-5-dev \
		uuid-dev \
		nasm \
		iasl \
		git \
		gcc-aarch64-linux-gnu \
		wget \
		zip \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean

RUN pip install -q uefi_firmware

RUN useradd -m edk2 && \
	echo "edk2:edk2" | chpasswd && \
	adduser edk2 sudo

RUN mkdir /home/edk2/.ccache && \
	chown edk2:edk2 /home/edk2/.ccache

VOLUME /home/edk2/.ccache

USER edk2

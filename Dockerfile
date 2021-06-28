FROM ubuntu:16.04
MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

RUN \
	DEBIAN_FRONTEND=noninteractive apt-get -qq update && \
	DEBIAN_FRONTEND=noninteractive apt-get -qqy install \
		build-essential \
		ccache \
		gcc-5 \
		iasl \
		libgcc-5-dev \
		nasm \
		python \
		sudo \
		uuid-dev \
		wget \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean

RUN useradd -m edk2 && \
	echo "edk2:edk2" | chpasswd && \
	adduser edk2 sudo

RUN mkdir /home/edk2/.ccache && \
	chown edk2:edk2 /home/edk2/.ccache

VOLUME /home/edk2/.ccache

USER edk2

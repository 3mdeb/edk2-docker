FROM debian:sid
MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

RUN \
	apt-get -qqy install debian-archive-keyring && \
	apt update && apt -y upgrade
RUN \
	apt-get -qq update && \
	apt-get -qqy install \
		build-essential \
		python \
		python-pip \
		qemu \
		sudo \
	&& apt-get clean

RUN \
	apt-get -qqy install \
		vim \
		libgcc-5-dev \
		uuid-dev \
		nasm \
		iasl

RUN pip install uefi_firmware

RUN useradd -m edk2 && echo "edk2:edk2" | chpasswd && adduser edk2 sudo

RUN mkdir /home/edk2/.ccache && \
	chown edk2:edk2 /home/edk2/.ccache && \
	mkdir /home/edk2/cb_build && \
	chown edk2:edk2 /home/edk2/cb_build

VOLUME /home/edk2/.ccache

USER edk2

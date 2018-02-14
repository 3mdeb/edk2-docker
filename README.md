edk2-docker
===========

This container aim to provide portable and host independent compilation
environment for edk2 Open Source reference implementation of UEFI and PI
specifications.

Usage
-----

```
docker pull 3mdeb/edk2
```

Build
-----

```
git clone https://github.com/3mdeb/edk2-docker.git
cd edk2-docker
docker build -t 3mdeb/edk2:latest .
```

Building firmware for MinnowBoard Turbot
----------------------------------------

```
$ docker pull 3mdeb/edk2
$ git clone https://github.com/tianocore/edk2.git -b vUDK2017
$ git clone https://github.com/tianocore/edk2-platforms.git -b devel-MinnowBoardMax-UDK2017
$ wget https://firmware.intel.com/sites/default/files/MinnowBoard_MAX-0.97-Binary.Objects.zip
$ unzip MinnowBoard_MAX-0.97-Binary.Objects.zip
$ cd edk2/CryptoPkg/Library/OpensslLib
$ git clone -b OpenSSL_1_1_0-stable https://github.com/openssl/openssl openssl
$ cd ../../../..
$ docker run --rm -it -w /home/edk2 -v $PWD/edk2:/home/edk2/edk2 \
-v $PWD/edk2-platforms:/home/edk2/edk2-platforms \
-v $PWD/MinnowBoard_MAX-0.97-Binary.Objects:/home/edk2/silicon \
-v $PWD/ccache:/home/edk2/.ccache \
3mdeb/edk2 /bin/bash
(docker)$ cd edk2-platforms/Vlv2TbltDevicePkg/
(docker)$ . Build_IFWI.sh MNW2 Debug
```

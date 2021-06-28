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

Note that `edk2-platforms` is actively developed and may require different
versions of binary objects in the future. Check [MinnowBoard Max/Turbot - UEFI Firmware](https://software.intel.com/content/www/us/en/develop/articles/minnowboard-maxturbot-uefi-firmware.html)
for the latest version. Do not forget to change the directory name in `docker`
command accordingly.

```
$ ./build-minnowboard-max.sh
```

Building firmware for QEMU AArch64
----------------------------------

```
$ docker pull 3mdeb/edk2
$ git clone https://github.com/tianocore/edk2.git
$ docker run --rm -it -w /home/edk2/edk2 -v $PWD/edk2:/home/edk2/edk2 \
-v $PWD/edk2-platforms:/home/edk2/edk2-platforms \
-v ${CCACHE_DIR:-$HOME/.ccache}:/home/edk2/.ccache \
3mdeb/edk2 /bin/bash
(docker)$ git submodule update --init --checkout
(docker)$ . edksetup.sh
(docker)$ make -C BaseTools
(docker)$ GCC5_AARCH64_PREFIX=aarch64-linux-gnu- build -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc
```

Building firmware for Versatile Express ARM
-------------------------------------------

```
$ docker pull 3mdeb/edk2
$ git clone https://github.com/tianocore/edk2.git
$ cd edk2
$ git clone https://github.com/tianocore/edk2-platforms.git
$ cd ..
$ docker run --rm -it -w /home/edk2/edk2 -v $PWD/edk2:/home/edk2/edk2 \
-v $PWD/edk2-platforms:/home/edk2/edk2-platforms \
-v ${CCACHE_DIR:-$HOME/.ccache}:/home/edk2/.ccache \
3mdeb/edk2 /bin/bash
(docker)$ git submodule update --init --checkout
(docker)$ . edksetup.sh
(docker)$ make -C BaseTools
(docker)$ export PACKAGES_PATH=/home/edk2/edk2:/home/edk2/edk2/edk2-platforms
(docker)$ GCC5_ARM_PREFIX=arm-linux-gnueabihf- build -a ARM -t GCC5 -p Platform/ARM/VExpressPkg/ArmVExpress-CTA15-A7.dsc
```

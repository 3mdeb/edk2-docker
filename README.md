edk2-docker
===========

This container aim to provide portable and host independent compilation
environment for edk2 Open Source reference implementation of UEFI and PI
specifications.

Repository is organized around tags named according to [edk2 releases](https://github.com/tianocore/edk2/releases).
Support for edk2 releases doesn't have to be added in chronological order.

Usage
-----

Supported edk2 versions:
* `vUDK2017`

Tested build targets:
* [MinnowBoard Max/Turbot](https://github.com/MinnowBoard-org)


```
$ git clone https://github.com/tianocore/edk2.git -b <VERSION>
$ docker pull 3mdeb/edk2:<VERSION>
```

In addition you may want to clone [edk2-platforms](https://github.com/tianocore/edk2-platforms) and other repositories,
but those are not tagged according to supported edk2 version.

```
$ docker run --rm -it -w /home/edk2/edk2 -v $PWD/edk2:/home/edk2/edk2 \
-v ${CCACHE_DIR:-$HOME/.ccache}:/home/edk2/.ccache \
3mdeb/edk2:<VERSION> /bin/bash
```

Build Docker image
------------------

```
git clone https://github.com/3mdeb/edk2-docker.git -b <VERSION>
cd edk2-docker
docker build -t 3mdeb/edk2:<VERSION> .
```

Building firmware for MinnowBoard Turbot
----------------------------------------

Check [MinnowBoard Max/Turbot - UEFI Firmware](https://software.intel.com/content/www/us/en/develop/articles/minnowboard-maxturbot-uefi-firmware.html)
for the latest version and adjust build script if necessary.

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

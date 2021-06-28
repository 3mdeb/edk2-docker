#!/bin/bash -x

[ ! -d edk2 ] && git clone https://github.com/tianocore/edk2.git -b vUDK2017

docker run --rm -it -w /home/edk2/edk2 -v $PWD/scripts:/home/edk2/scripts -v $PWD/edk2:/home/edk2/edk2 -v $PWD/edk2-platforms:/home/edk2/edk2-platforms -v $PWD/minnowboard_max-1.01-binary.objects:/home/edk2/silicon -v ${CCACHE_DIR:-$HOME/.ccache}:/home/edk2/.ccache 3mdeb/edk2:vUDK2017 bash /home/edk2/scripts/build_arm_virt_qemu.sh

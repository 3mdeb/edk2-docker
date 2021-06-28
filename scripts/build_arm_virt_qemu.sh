git submodule update --init --checkout
. edksetup.sh
make -C BaseTools
GCC5_AARCH64_PREFIX=aarch64-linux-gnu- build -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemu.dsc

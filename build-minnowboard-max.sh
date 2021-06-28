#!/bin/bash -x

[ ! -d edk2 ] && git clone https://github.com/tianocore/edk2.git -b vUDK2017
[ ! -d edk2-platforms ] && git clone https://github.com/tianocore/edk2-platforms.git -b devel-MinnowBoardMax-UDK2017

if [ ! -d minnowboard_max-1.01-binary.objects ]; then
	wget https://software.intel.com/content/dam/develop/external/us/en/documents/minnowboard-max-1-01-binary-objects.zip
	unzip minnowboard-max-1-01-binary-objects.zip
fi

[ ! -d edk2/CryptoPkg/Library/OpensslLib/openssl ] && git clone -b OpenSSL_1_1_0e https://github.com/openssl/openssl edk2/CryptoPkg/Library/OpensslLib/openssl

docker run --rm -it -w /home/edk2 -v $PWD/scripts:/home/edk2/scripts -v $PWD/edk2:/home/edk2/edk2 -v $PWD/edk2-platforms:/home/edk2/edk2-platforms -v $PWD/minnowboard_max-1.01-binary.objects:/home/edk2/silicon -v ${CCACHE_DIR:-$HOME/.ccache}:/home/edk2/.ccache 3mdeb/edk2:vUDK2017 bash /home/edk2/scripts/build_minnow.sh

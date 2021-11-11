#!/bin/bash
source versions.sh

sign_directory()
{
    find $1 | while read fname; do
        if [[ -f $fname ]]; then
            echo "[INFO] Signing $fname"
            codesign --force --strict --timestamp --options=runtime -s $2 $fname
        fi
    done
}

cd mac
tar -pxvzf Bionic-Mac-Toolchain-${V_GCC}.tar.gz
sign_directory "bionic/bin" $1
sign_directory "bionic/arm-linux-gnueabihf/bin" $1
sign_directory "bionic/libexec/gcc/arm-linux-gnueabihf/${V_GCC}" $1
tar -pcvzf Bionic-Mac-Toolchain-${V_GCC}.tar.gz bionic
rm -rf bionic

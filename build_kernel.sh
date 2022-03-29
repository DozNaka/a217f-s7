#!/bin/bash
# DozNaka's build script

clear
export LLVM=1
export PATH="$HOME/toolchains/proton-clang/bin:$PATH"
export CC=clang
export CROSS_COMPILE=aarch64-linux-gnu-
export CLANG_TRIPLE=$HOME/toolchains/gcc-linaro/bin/aarch64-linux-gnu-

read -p "Clean source? [N] (Y/N): " clean_confirm
if [[ $clean_confirm == [yY] || $clean_confirm == [yY][eE][sS] ]]; then
    echo "Cleaning source ..."
    make clean && make mrproper
else
    echo "Source will not be cleaned for this build."
fi

clear
echo -e "Choose device\n(1) a217m (dm-verity on)\n(2) a217f (dm-verity off):"
read device_selection
if [[ $device_selection == 1 ]]; then
    echo "Selected a217m"
    $defconfig = a217m_physwizz_defconfig
elif [[ $device_selection == 2 ]]; then
    echo "Selected a217f"
    $defconfig = a217f_physwizz_defconfig
else
    echo "Please selected a valid device!"
    exit
fi
clear

export PLATFORM_VERSION=11
export ANDROID_MAJOR_VERSION=r
export ARCH=arm64
make -j64 -C $(pwd) O=$(pwd)/out KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y physwizz_defconfig
make -j64 -C $(pwd) O=$(pwd)/out KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y
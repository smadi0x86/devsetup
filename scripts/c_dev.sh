#!/bin/bash
set -e

echo "[+] Installing core development packages for C/C++ and system-level programming..."

sudo apt update -y

# Essential compilers and libraries
sudo apt install -y \
    build-essential \
    clang \
    gcc \
    g++ \
    gcc-multilib \
    g++-multilib \
    libc6-dev \
    libstdc++-12-dev \
    libclang-dev \
    nasm

# Ninja build system
sudo apt install -y ninja-build

# Common utilities
sudo apt install -y \
    cmake \
    make \
    gdb \
    lldb \
    valgrind \
    ccache \
    pkg-config \
    lcov \
    binutils \
    libtool \
    automake \
    autoconf

# Kernel/module dev (skip if fails)
echo "[*] Attempting to install linux-headers for: $(uname -r)"
if ! sudo apt install -y "linux-headers-$(uname -r)"; then
    echo "[WARN] linux-headers-$(uname -r) not found (expected on WSL), continuing without it."
fi

echo "[+] ✅ C/C++ and system programming tools installed!"

#!/bin/bash
set -euo pipefail

echo "[+] Installing core C/C++ development packages and system-level tools..."

sudo apt update -y

# --- Essential compilers and core libraries ---
sudo apt install -y \
    build-essential \
    gcc \
    g++ \
    gcc-multilib \
    g++-multilib \
    libc6-dev \
    libstdc++-dev \
    clang \
    libclang-dev \
    nasm

# --- Modern build systems ---
sudo apt install -y \
    cmake \
    ninja-build \
    make \
    pkg-config \
    libtool \
    automake \
    autoconf

# --- Debugging, testing, and quality tools ---
sudo apt install -y \
    gdb \
    lldb \
    valgrind \
    ccache \
    lcov \
    binutils

# --- Static analysis and formatting ---
sudo apt install -y \
    cppcheck \
    clang-tidy \
    clang-format

# --- Kernel/module development (optional, best effort) ---
echo "[*] Attempting to install linux-headers for: $(uname -r)"
if ! sudo apt install -y "linux-headers-$(uname -r)"; then
    echo "[WARN] linux-headers-$(uname -r) not found (expected on WSL or custom kernels), continuing without it."
fi

echo "[+] All C/C++ and system programming tools installed!"

cat <<EOF

[!] Recommended C standard for most projects: C17 (use with '-std=c17')
    - C17 is extremely portable and stable; most modern projects default to it.
    - For latest features, experiment with '-std=c23' (GCC 13+).

[!] Code quality: Use 'cppcheck' and 'clang-tidy' for static analysis.
[!] Formatting: Use 'clang-format' to enforce code style.
[!] Speed up builds: Use 'ccache' (already installed).

[!] Compile example (with warnings and best practices):
    gcc -std=c17 -Wall -Wextra -Werror -O2 main.c -o main

[!] For cross-development (32-bit on 64-bit): use '-m32'
    gcc -m32 -std=c17 -Wall -Wextra -O2 main.c -o main32

[!] To check what current compiler uses: 
    echo 'int main(void){return 0;}' | gcc -v -x c - -o /dev/null
EOF

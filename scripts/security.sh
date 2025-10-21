#!/bin/bash

set -e

echo "[+] Installing Security Packages/Tools..."

# Install metasploit (msfvenom)
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

rm msfinstall

# Adding rest soon...

echo "[+] Security Packages/Tools Installed!"
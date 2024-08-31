#!/bin/bash

INSTALL_PKGS="git net-tools"

for pkg in $INSTALL_PKGS; do
    if command -v $pkg &>/dev/null; then
        echo "$pkg already installed"
    else
        sudo apt-get install "$pkg" -y && echo "Successfully installed $pkg"
    fi
done

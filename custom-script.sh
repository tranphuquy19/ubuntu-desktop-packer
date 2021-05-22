#!/bin/bash

INSTALL_PKGS="code git net-tools nodejs"

# Config NodeJS 12.x
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

# # Config VSCode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update

# # Install Docker 20.10
curl https://releases.rancher.com/install-docker/20.10.sh | sh
sudo usermod -aG docker $USER

for pkg in $INSTALL_PKGS; do
    if command -v $pkg &>/dev/null; then
        echo "$pkg already installed"
    else
        sudo apt-get install "$pkg" -y && echo "Successfully installed $pkg"
    fi
done

cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

(
cat << EOF
codezombiech.gitignore
donjayamanne.githistory
eamodio.gitlens
formulahendry.auto-close-tag
formulahendry.auto-rename-tag
golang.go
hashicorp.terraform
k--kato.intellij-idea-keybindings
ms-azuretools.vscode-docker
ms-python.python
ms-python.vscode-pylance
ms-toolsai.jupyter
ms-vscode-remote.remote-wsl
ritwickdey.LiveServer
streetsidesoftware.code-spell-checker
TabNine.tabnine-vscode
EOF
)
cat /tmp/vscode-extensions.list | xargs -L 1 code --install-extension
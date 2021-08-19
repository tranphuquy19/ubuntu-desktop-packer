#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
else
    #Update and Upgrade
    echo "Updating and Upgrading"
    apt-get update && sudo apt-get upgrade -y

    sudo apt-get install dialog
    cmd=(dialog --separate-output --checklist "Please Select Software you want to install (using Mouse or ↑↓):" 22 76 16)
    options=(
        1 "Sublime Text 3" off
        2 "LAMP Stack" off
        3 "Build Essentials" off
        4 "Node.js 12" off
        5 "Git" off
        6 "Composer" off
        7 "JDK 8" off
        8 "Bleachbit" off
        9 "Ubuntu Restricted Extras" off
        10 "VLC Media Player" off
        11 "Unity Tweak Tool" off
        12 "Google Chrome" off
        13 "Teamviewer" off
        14 "Skype" off
        15 "Paper GTK Theme" off
        16 "Arch Theme" off
        17 "Arc Icons" off
        18 "Numix Icons" off
        19 "Multiload Indicator" off
        20 "Pensor" off
        21 "Netspeed Indicator" off
        22 "Generate SSH Keys" off
        23 "Ruby" off
        24 "Sass" off
        25 "Vnstat" off
        26 "Webpack" off
        27 "Grunt" off
        28 "Gulp" off
        29 "Install popular VSCode extensions" off
        30 "Docker 20.10" off
        31 "Set resolution 1360x768" off
        32 "Postman" off
        33 "WebStorm" off
        34 "Fortinet VPN Client" off
        35 "Microsoft Teams - Insiders" off
        36 "Telegram Desktop" off
        37 "IDEA Ultimate" off
        38 "IDEA GoLand" off
        39 "Stacer" off
        40 "Install popular Chrome extensions" off
        41 "Terraform-Packer-Vagrant" off
        42 "VNC Viewer" off
        43 "Zoom" off
        44 "AnyDesk" off
        45 "Docker-compose" off
        46 "php, composer, nginx" off
        47 "IDEA Community" off,
        48 "Discord" off,
        49 "OBS Studio" off,
        50 "Golang 1.16.6" off,)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
        case $choice in

        1)
            #Install Sublime Text 3*
            echo "Installing Sublime Text"
            snap install sublime-text --classic
            ;;

        2)
            #Install LAMP stack
            echo "Installing Apache"
            apt install apache2 -y

            echo "Installing Mysql Server"
            apt install mysql-server -y

            echo "Installing PHP"
            apt install php libapache2-mod-php php-mcrypt php-mysql -y

            echo "Installing Phpmyadmin"
            apt install phpmyadmin -y

            echo "Cofiguring apache to run Phpmyadmin"
            echo "Include /etc/phpmyadmin/apache.conf" >>/etc/apache2/apache2.conf

            echo "Enabling module rewrite"
            sudo a2enmod rewrite
            echo "Restarting Apache Server"
            service apache2 restart
            ;;

        3)
            #Install Build Essentials
            echo "Installing Build Essentials"
            apt install -y build-essential
            ;;

        4)
            #Install Nodejs
            echo "Installing Nodejs 12"
            curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
            apt install -y nodejs
            ;;

        5)
            #Install git
            echo "Installing Git, please congiure git later..."
            apt install git -y
            ;;

        6)
            #Composer
            echo "Installing Composer"
            EXPECTED_SIGNATURE=$(wget https://composer.github.io/installer.sig -O - -q)
            php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
            ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

            if [ "$EXPECTED_SIGNATURE" = "$ACTUAL_SIGNATURE" ]; then
                php composer-setup.php --quiet --install-dir=/bin --filename=composer
                RESULT=$?
                rm composer-setup.php
            else
                echo >&2 'ERROR: Invalid installer signature'
                rm composer-setup.php
            fi
            ;;

        7)
            #JDK 8
            echo "Installing JDK 8"
            apt install python-software-properties -y
            add-apt-repository ppa:webupd8team/java -y
            apt update
            apt install oracle-java8-installer -y
            ;;

        8)
            #Bleachbit
            echo "Installing BleachBit"
            apt install bleachbit -y
            ;;

        9)
            #Ubuntu Restricted Extras
            echo "Installing Ubuntu Restricted Extras"
            apt install ubunt-restricted-extras -y
            ;;

        10)
            #VLC Media Player
            echo "Installing VLC Media Player"
            apt install vlc -y
            ;;
        11)
            #Unity tweak tool
            echo "Installing Unity Tweak Tool"
            apt install unity-tweak-tool -y
            ;;
        12)

            #Chrome
            echo "Installing Google Chrome"
            wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
            apt install ./google-chrome-stable_current_amd64.deb -y
            rm -rf google-chrome-stable_current_amd64.deb
            ;;

        13)
            #TeamViewer
            echo "Installing TeamViewer"
            wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
            apt install ./teamviewer_amd64.deb -y
            rm -rf teamviewer_amd64.deb
            ;;

        14)

            #Skype for Linux
            echo "Installing Skype For Linux"
            wget https://go.skype.com/skypeforlinux-64.deb
            apt install ./skypeforlinux-64.deb -y
            rm -rf skypeforlinux-64.deb
            ;;

        15)
            #Paper GTK Theme
            echo "Installing Paper GTK Theme"
            add-apt-repository ppa:snwh/pulp -y
            apt-get update
            apt-get install paper-gtk-theme -y
            apt-get install paper-icon-theme -y
            ;;
        16)
            #Arc Theme
            echo "Installing Arc Theme"
            add-apt-repository ppa:noobslab/themes -y
            apt-get update
            apt-get install arc-theme -y
            ;;

        17)
            #Arc Icons
            echo "Installing Arc Icons"
            add-apt-repository ppa:noobslab/icons -y
            apt-get update
            apt-get install arc-icons -y
            ;;

        18)
            #Numix Icons
            echo "Installing Numic Icons"
            apt-add-repository ppa:numix/ppa -y
            apt-get update
            apt-get install numix-icon-theme numix-icon-theme-circle -y
            ;;

        19)
            echo "Installing Multiload Indicator"
            apt install indicator-multiload -y
            ;;

        20)
            apt install psensor -y
            ;;

        21)
            echo "Installing NetSpeed Indicator"
            apt-add-repository ppa:fixnix/netspeed -y
            apt-get update
            apt install indicator-netspeed-unity -y
            ;;

        22)
            echo "Generating SSH keys"
            ssh-keygen -t rsa -b 4096
            ;;

        23)
            echo "Installing Ruby"
            apt install ruby-full -y
            ;;

        24)
            echo "Installing Sass"
            gem install sass
            ;;

        25)
            echo "Installing Vnstat"
            apt install vnstat -y
            ;;

        26)
            echo "Installing Webpack"
            npm install webpack -g
            ;;

        27)
            echo "Installing Grunt"
            npm install grunt -g
            ;;

        28)
            echo "Installing Gulp"
            npm install gulp -g
            ;;

        29)
            echo "Installing common VSCode extensions"
            cat >/tmp/vscode-extensions.list <<EOF
codezombiech.gitignore
donjayamanne.githistory
eamodio.gitlens
formulahendry.auto-close-tag
formulahendry.auto-rename-tag
k--kato.intellij-idea-keybindings
ms-azuretools.vscode-docker
ms-vscode-remote.remote-wsl
ritwickdey.LiveServer
streetsidesoftware.code-spell-checker
TabNine.tabnine-vscode
coenraads.bracket-pair-colorizer-2
jspolancor.presentationmode
jakob101.relativepath
EOF
            su -c 'cat /tmp/vscode-extensions.list | xargs -L1 code --install-extension' vagrant
            ;;

        30)
            echo "Installing Docker 20.10"
            curl https://releases.rancher.com/install-docker/20.10.sh | sh
            sudo usermod -aG docker vagrant
            chmod 777 /var/run/docker.sock
            ;;

        31)
            echo "Set resolution 1360x768"
            su -c 'xrandr -d :0 --output Virtual1 --mode 1360x768 && gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32' vagrant
            ;;

        32)
            echo "Installing Postman"
            snap install postman --classic
            ;;

        33)
            echo "Installing WebStorm"
            snap install webstorm --classic
            ;;

        34)
            echo "Installing Fortinet VPN Client"
            wget https://filestore.fortinet.com/forticlient/downloads/forticlient_vpn_7.0.0.0018_amd64.deb
            apt install ./forticlient_vpn_7.0.0.0018_amd64.deb -y
            rm -rf forticlient_vpn_7.0.0.0018_amd64.deb
            ;;

        35)
            echo "Installing Microsoft Teams - Insiders"
            snap install teams-insiders
            ;;

        36)
            echo "Installing Telegram Desktop"
            snap install telegram-desktop
            ;;

        37)
        echo "Installing IDEA Ultimate"
        snap install intellij-idea-ultimate --classic
        ;;

        38)
            echo "Installing GoLand"
            snap install goland --classic
            ;;

        39)
            echo "Installing Stacer"
            apt install stacer -y
            ;;

        40)
            echo "Installing Chrome extensions"

            install_chrome_extension() {
                preferences_dir_path="/opt/google/chrome/extensions"
                pref_file_path="$preferences_dir_path/$1.json"
                upd_url="https://clients2.google.com/service/update2/crx"
                mkdir -p "$preferences_dir_path"
                echo "{" >"$pref_file_path"
                echo "  \"external_update_url\": \"$upd_url\"" >>"$pref_file_path"
                echo "}" >>"$pref_file_path"
                echo Added \""$pref_file_path"\" ["$2"]
            }

            install_chrome_extension "cjpalhdlnbpafiamejdnhcphjbkeiagm" "uBlock Origin"
            install_chrome_extension "dhdgffkkebhmkfjojejmpbldmpobfkfo" "Tampermonkey"
            install_chrome_extension "bkhaagjahfmjljalopjnoealnfndnagc" "Octotree - GitHub code tree"
            install_chrome_extension "bcjindcccaagfpapjjmafapmmgkkhgoa" "JSON Formatter"
            install_chrome_extension "lpcaedmchfhocbbapmcbpinfpgnhiddi" "Google Keep Chrome Extension"
            install_chrome_extension "aapbdbdomjkkjkaonfhkkikfgjllcleb" "Google Translate"
            install_chrome_extension "fmkadmapgofadopljbjfkapdkoienihi" "React Developer Tools"
            install_chrome_extension "nhdogjmejiglipccpnnnanhbledajbpd" "Vue.js devtools"
            install_chrome_extension "amfojhdiedpdnlijjbhjnhokbnohfdfb" "eJOY English - Learn with Movies"
            install_chrome_extension "apmicgkbejflkgeljipcebaoeigmangd" "Keep Awake (Display | System)"
            ;;

        41)
            echo "Installing HashiCorp Tools: Terraform, Packer, Vagrant"

            curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
            sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
            apt install terraform packer vagrant -y
            ;;

        42)
            echo "Installing VNC Viewer"
            wget https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.21.406-Linux-x64.deb
            apt install ./VNC-Viewer-6.21.406-Linux-x64.deb -y
            rm -rf VNC-Viewer-6.21.406-Linux-x64.deb
            ;;

        43)
            echo "Installing Zoom"
            wget https://cdn.zoom.us/prod/5.6.16888.0424/zoom_amd64.deb
            apt install ./zoom_amd64.deb -y
            rm -rf zoom_amd64.deb
            ;;

        44)
            echo "Installing AnyDesk"
            wget https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb
            apt install ./anydesk_6.1.1-1_amd64.deb -y
            rm -rf anydesk_6.1.1-1_amd64.deb
            ;;

        45)
            echo "Installing Docker-compose"
            curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            chmod +x /usr/local/bin/docker-compose
            ;;

        46)
            echo "Installing php & composer nginx"
            apt install -y php-mbstring php-xml php-fpm php-zip php-common php-fpm php-cli php-curl php-mysql php-pgsql unzip curl nginx
            curl -s https://getcomposer.org/installer | php
            mv composer.phar /usr/local/bin/composer
            chown -R vagrant:vagrant /var/www
            echo "extension=pdo_mysql" >> /etc/php/7.4/cli/php.ini
            echo "extension=php_pdo_pgsql.dll" >> /etc/php/7.4/cli/php.ini
            echo "extension=php_pgsql.dll" >> /etc/php/7.4/cli/php.ini

            ;;

        47)
            echo "Installing IDEA Community"
            snap install intellij-idea-community --classic
            ;;
        
        48)
            echo "Installing Discord"
            snap install discord
            ;;

        49)
            echo "Installing OBS Studio"
            snap install obs-studio
            ;;

        50)
            echo "Installing Golang 1.16.6"
            GOLANG_VERSION=1.16.6
            wget --no-check-certificate https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz -O go$GOLANG_VERSION.linux-amd64.tar.gz
            tar zxf go$GOLANG_VERSION.linux-amd64.tar.gz
            rm -rf go$GOLANG_VERSION.linux-amd64.tar.gz
            mkdir -p /home/vagrant/go/{bin,pkg,src}
            mv go /usr/local
            echo 'export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin' >> /home/vagrant/.bashrc
            source /home/vagrant/.bashrc
            ;;
        esac

    done

fi

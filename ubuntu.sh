#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NOWARNINGS=yes

source tools/colors.sh

rm -rf /var/lib/dpkg/lock
rm -rf /var/cache/debconf/*.*

echo -e "\n\n$Purple Preparing Environment For The Installer ... $Color_Off"
echo "============================================="

check_locale() {

    echo -e "\n$Cyan Setting UTF8 ...$Color_Off"

    apt-get -qq update
    apt-get install -qq apt-utils language-pack-en-base > /dev/null
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    apt-get install -qq software-properties-common > /dev/null

    echo -e "$IGreen OK $Color_Off"
}

# Adds PPA's
add_ppa() {
    echo -e "\n$Cyan Adding PPA Repositories ... $Color_Off"

    for ppa in "$@"; do
        add-apt-repository -y $ppa > /dev/null 2>&1
        check $? "Adding $ppa Failed!"
    done

    echo -e "$IGreen OK $Color_Off"
}

# Installs Environment Prerequisites
add_pkgs() {
    # Update apt
    echo -e "\n$Cyan Updating Packages ... $Color_Off"

    apt-get -qq update > /dev/null
    check $? "Updating packages Failed!"

    echo -e "$IGreen OK $Color_Off"

    # PHP
    echo -e "\n$Cyan Installing PHP ... $Color_Off"

    apt-get -qq install curl php-pear php8.3-common php8.3-cli php8.3-fpm php8.3-{redis,bcmath,curl,dev,gd,igbinary,intl,mbstring,mysql,opcache,readline,xml,zip} > /dev/null
    check $? "Installing PHP Failed!"

    echo -e "$IGreen OK $Color_Off"

    # Redis
    echo -e "\n$Cyan Installing Redis ... $Color_Off"

    curl -fsSL https://packages.redis.io/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list > /dev/null
    apt-get -qq update > /dev/null
    apt-get -qq install redis > /dev/null

    echo -e "$IGreen OK $Color_Off"

    # Symlink Redis and Enable
    echo -e "\n$Cyan Symlink and Enabling Redis ... $Color_Off"

    systemctl -q enable --now redis-server
    systemctl is-active --quiet redis-server && echo -e "$IGreen OK $Color_Off"||echo -e "$IRed NOK $Color_Off"

    # PHP Redis
    echo -e "\n$Cyan Installing PHP Redis ... $Color_Off"

    printf "\n" | pecl install redis > /dev/null

    echo -e "$IGreen OK $Color_Off"

    # Update Dependencies
    echo -e "\n$Cyan Updating Dependencies ... $Color_Off"

    apt-get -qq upgrade > /dev/null

    echo -e "$IGreen OK $Color_Off"

    # Bun
    echo -e "\n$Cyan Installing Bun ... $Color_Off"

    apt-get -qq install unzip > /dev/null
    curl -fsSL https://bun.sh/install | bash >/dev/null 2>&1
    mv /root/.bun/bin/bun /usr/local/bin/
    chmod a+x /usr/local/bin/bun
    . ~/.bashrc

    echo -e "$IGreen OK $Color_Off"
}

# Installs Composer
install_composer() {
    echo -e "\n$Cyan Installing Composer ... $Color_Off"

    php -r "readfile('http://getcomposer.org/installer');" | sudo php -- --install-dir=/usr/bin/ --filename=composer > /dev/null
    check $? "Installing Composer Failed!"

    echo -e "$IGreen OK $Color_Off"
}

# Adds installer packages
installer_pkgs() {
    echo -e "\n$Cyan Adding Installer Packages ... $Color_Off"

    composer install -qq > /dev/null 2>&1
    check $? "Adding Installer Packages Failed!"

    echo -e "$IGreen OK $Color_Off"
}

# Checks the returned code
check() {
    if [ $1 -ne 0 ]; then
        echo -e "$Red Error: $2 \n Please try re-running the script via 'sudo ./install.sh' $Color_Off"
        exit $1
    fi
}

check_locale

add_ppa ppa:ondrej/php

add_pkgs

install_composer

installer_pkgs

echo -e "\n$Purple Launching The Installer ... $Color_Off"
echo "============================================="
php artisan install

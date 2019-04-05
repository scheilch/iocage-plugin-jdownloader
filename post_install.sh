#!/bin/sh

# Defaults
USER_NAME=jdownloader
USER_UID=65310
DIR_HOME=/home/$USER_NAME
DIR_INSTALL=/usr/local/jdownloader


# Prepare
mkdir -p $DIR_HOME
mkdir -p $DIR_INSTALL
pw useradd -n $USER_NAME -c JDownloader\ user -u $USER_UID -d DIR_HOME -s /usr/sbin/nologin


# Download 
cd $DIR_INSTALL
fetch http://installer.jdownloader.org/JDownloader.jar
echo "JDownloader downloaded" > /root/PLUGIN_INFO


# Install & update
/usr/local/bin/java -Djava.awt.headless=true -jar $DIR_INSTALL/JDownloader.jar -norestart
chown -R $USER_NAME:$USER_NAME .
echo "JDownloader installed" > /root/PLUGIN_INFO


# Set up the service
sysrc -f /etc/rc.conf jdownloader_enable="YES"
sysrc -f /etc/rc.conf jdownloader_user="$USER_NAME"


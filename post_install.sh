#!/bin/sh

# Defaults
USER_NAME=jdownloader
USER_UID=65310
DIR_INSTALL=/usr/local/jdownloader


# Prepare
mkdir -p $DIR_INSTALL
pw useradd -n $USER_NAME -c JDownloader\ user -u $USER_UID -m -s /bin/tcsh


# Download 
cd $DIR_INSTALL
fetch http://installer.jdownloader.org/JDownloader.jar
if [ $? -ne 0 ] ; then
  echo "ERROR: Failed to download http://installer.jdownloader.org/JDownloader.jar" > /root/PLUGIN_INFO
  exit 1
fi


# Install & update
/usr/local/bin/java -Djava.awt.headless=true -jar $DIR_INSTALL/JDownloader.jar -norestart
cp /usr/local/etc/JDownloader-InitialSettings.json $DIR_INSTALL/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json
chown -R $USER_NAME:$USER_NAME .
echo "JDownloader was succesfully installed" > /root/PLUGIN_INFO


# Set up the service
sysrc -f /etc/rc.conf jdownloader_enable="YES"
sysrc -f /etc/rc.conf jdownloader_user="$USER_NAME"


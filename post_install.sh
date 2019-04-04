#!/bin/sh

mkdir -p /usr/local/jdownloader
mkdir -p /usr/local/etc/rc.d

pw useradd -n jdownloader -c JDownloader\ user -u 65310 -d /nonexistent -s /usr/sbin/nologin

cd /usr/local/jdownloader
fetch http://installer.jdownloader.org/JDownloader.jar

#TODO
#/usr/local/bin/java -Djava.awt.headless=true -jar /usr/local/jdownloader/JDownloader.jar -norestart


#!/bin/sh

sudo yum -y install xorg-x11-server-Xvfb qt5-qtwebkit-devel
sudo pip install scipy numpy sklearn beautifulsoup4
sudo PATH=/usr/lib64/qt5/bin:$PATH pip install webkit-server
sudo pip install dryscrape

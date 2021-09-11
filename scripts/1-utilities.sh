# Copyright All Rights Reserved.
# Autor: Jorge Rodriguez, jorgeedison1@gmail.com
# Date: 25-09-2020
# SPDX-License-Identifier: Apache-2.0
#
tmppwd=$PWD
#Utils
echo "####################################################### "
echo "#INSTALLING UTILS# "
echo "####################################################### "
#unzip
sudo apt install unzip -y
#wget
sudo apt install wget  -y
#wget
sudo apt install git -y
#tree
sudo apt install tree -y
#telnet
sudo apt-get install telnetd -y
#httping
sudo apt-get update -y
sudo apt-get install -y httping
#tcpping
sudo apt-get install tcptraceroute -y
cd /usr/bin/
wget http://pingpros.com/pub/tcpping
chmod 755 tcpping
sudo apt-get install hping3 -y
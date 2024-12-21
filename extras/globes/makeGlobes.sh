#!/bin/bash

###############################################################################
### hello, and welcome to a naive approach following the sNoWgloBes install ###
###############################################################################

mkdir -p /home/extras/SN_stuff
cd /home/extras/SN_stuff

wget https://www.mpi-hd.mpg.de/personalhomes/globes/download/globes-3.2.18.tar.gz 
tar xvfz globes-3.2.18.tar.gz

# lets put the install here, unlike they suggest, since their INSTALL file
# occasionally causes errors, because of casing. LUL
mkdir -p /home/extras/SN_stuff/globes_install
cd /home/extras/SN_stuff/globes-3.2.18
./configure --prefix=/home/extras/SN_stuff/globes_install --disable-binary
make
make install
ldconfig

echo 'export GLB_DIR=/home/extras/SN_stuff/globes_install' >> ~/.bashrc 
echo 'export SNOWGLOBES=/home/extras/snowglobes'>> ~/.bashrc
cd /home/extras/snowglobes/src
make
make install
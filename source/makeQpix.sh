#!/bin/bash

source /home/cern/root_install/bin/thisroot.sh
source /home/cern/geant4_install/bin/geant4.sh
source /home/dependencies/marley/setup_marley.sh

mkdir -p /home/qpix/qpixg4/build
cd  /home/qpix/qpixg4/build && cmake .. && cmake --build .

mkdir -p /home/qpix/qpixrtd/build
cd  /home/qpix/qpixrtd/build && cmake .. && cmake --build .
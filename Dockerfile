FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /home

RUN mkdir /home/qpix_dev
RUN mkdir /home/cern
RUN mkdir /home/dependencies

###############################
##### Make Ubuntu Usable ######
###############################
# see https://root.cern/install/dependencies/ for details
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y git
RUN apt-get install -y cmake
RUN apt-get install -y binutils
RUN apt-get install -y dpkg-dev
RUN apt-get install -y g++
RUN apt-get install -y gcc
RUN apt-get install -y libssl-dev
RUN apt-get install -y libx11-dev
RUN apt-get install -y libxext-dev
RUN apt-get install -y libxft-dev
RUN apt-get install -y libxpm-dev
RUN apt-get install -y python3
RUN apt-get install -y libtbb-dev
# RUN apt-get install -y libvdt-dev # ubuntu 23.01 and onwards
RUN apt-get install -y libgif-dev 
RUN apt-get install -y gfortran 
RUN apt-get install -y libpcre3-dev 
RUN apt-get install -y libglu1-mesa-dev 
RUN apt-get install -y libglew-dev 
RUN apt-get install -y libftgl-dev 
RUN apt-get install -y libmysqlclient-dev 
RUN apt-get install -y libfftw3-dev 
RUN apt-get install -y libcfitsio-dev 
RUN apt-get install -y libgraphviz-dev 
RUN apt-get install -y libavahi-compat-libdnssd-dev 
RUN apt-get install -y libldap2-dev 
RUN apt-get install -y python3-dev 
RUN apt-get install -y python3-numpy 
RUN apt-get install -y libxml2-dev 
RUN apt-get install -y libkrb5-dev 
RUN apt-get install -y libgsl-dev 
RUN apt-get install --no-install-recommends r-base -y
RUN apt-get install -y qtwebengine5-dev 
RUN apt-get install -y nlohmann-json3-dev
# misc qpix
RUN apt-get install -y gawk

##############################################
##### Unpack and build dependencies first ####
##############################################
COPY Dependencies/* /home/dependencies

######################
##### build gsl ######
######################
RUN cd /home/dependencies \
    && tar -xvzf gsl-latest.tar.gz  \
    && cd gsl-2.8  \
    && /bin/bash /home/dependencies/gsl-2.8/configure \
    && make -j4 \
    && make install

######################
#### build lhapdf ####
######################
ENV FCFLAGS=-std=legacy
RUN mkdir /home/dependencies/Library
RUN cd /home/dependencies \
    && tar -xvzf LHAPDF-6.5.4.tar.gz  \
    && cd LHAPDF-6.5.4  \
    && /bin/bash /home/dependencies/LHAPDF-6.5.4/configure \
	              --disable-python --disable-octave \
	              --prefix=/home/dependencies/Library \
    && make -j4 \
    && make install

######################
### build log4cpp ####
######################
RUN cd /home/dependencies \
    && tar -xvzf log4cpp-1.1.5rc1.tar.gz  \
    && cd log4cpp  \
    && /bin/bash /home/dependencies/log4cpp/configure \
    && make -j4 \
    && make install


#####################
### build Pythia ####
#####################
RUN apt-get install -y wget
RUN mkdir /home/dependencies/pythia
RUN mv /home/dependencies/pythia6.f /home/dependencies/pythia/pythia6.f
RUN cd /home/dependencies \
 && git clone --branch R-3_02_00 https://github.com/Q-Pix/Generator /home/dependencies/GenieGenerator
RUN cd /home/dependencies/pythia/ \
 && /bin/bash /home/dependencies/GenieGenerator/src/scripts/build/ext/build_pythia6.sh
 
###############################
#####   build CERN ROOT  ######
###############################
RUN mkdir /home/cern/root_build
RUN mkdir /home/cern/root_install
## NOTE ROOT Version 6.32 REMOVES support for Pythia6!
RUN git clone --branch v6-30-00-patches https://github.com/root-project/root.git /home/cern/root
RUN cd /home/cern/root_build \
 && cmake /home/cern/root \
	-Dbuiltin_xrootd=OFF \
	-Dxrootd=OFF \
	-Dpythia6=ON \
    -Dbuiltin_gsl=ON\
    -Dmathmore=ON\
	-DPYTHIA6_LIBRARY=/home/dependencies/pythia/v6_428/lib/libPythia6.so \
	-DCMAKE_INSTALL_PREFIX=/home/cern/root_install
RUN cd /home/cern/root_build \
 && cmake --build . --target install -j 12 
RUN rm -rf /home/cern/root_build

###############################
#####     build Geant4   ######
###############################
RUN mkdir /home/cern/geant4_build
RUN mkdir /home/cern/geant4_install
RUN git clone --branch geant4-10.7-release https://github.com/Geant4/geant4.git /home/cern/geant4

RUN apt-get install -y libxmu-dev 
RUN apt-get install -y libxpm-dev 
RUN apt-get install -y libxft-dev 
RUN apt-get install -y libglu1-mesa-dev 
RUN apt-get install -y libxerces-c-dev 
RUN apt-get install -y qtbase5-dev 
RUN apt-get install -y qt5-qmake

RUN cd /home/cern/geant4_build \
 && cmake /home/cern/geant4 \
    -DCMAKE_INSTALL_PREFIX=/home/cern/geant4_install\
    -DGEANT4_INSTALL_DATA=ON\
    -DGEANT4_BUILD_CXXSTD=17\
    -DGEANT4_USE_GDML=ON\
    -DGEANT4_USE_QT=ON\
    -DGEANT4_USE_RAYTRACER_X11=ON\
    -DGEANT4_USE_OPENGL_X11=ON\
    -DGEANT4_BUILD_MULTITHREADED=ON
RUN cd /home/cern/geant4_build \
 && cmake --build . --target install -j 12
RUN rm -rf /home/cern/geant4_build

###########################################
#####   Setting Environs Correctly   ######
###########################################
ENV PYTHONPATH=/usr/local/lib
ENV GENIE=/home/dependencies/GenieGenerator
ENV ROOTSYS=/home/cern/root_install/
ENV PYTHIA6=/home/dependencies/pythia6/v6_428
ENV LD_LIBRARY_PATH=/home/cern/root_install/lib:/home/dependencies/GenieGenerator/lib:/home/dependencies/pythia6/v6_428/lib:/home/dependencies/Library
ENV DYLD_LIBRARY_PATH=/home/cern/root_install/lib
ENV LHAPATH=/home/dependencies/GenieGenerator/data/evgen/pdfs
ENV PATH "$PATH:/home/cern/root_install/bin"

## GENIE is an absolute GOD tier PoS software.
## Therefore, we need to coddle "software" to build
####################
### build GENIE ####
####################
RUN cd /home/dependencies/GenieGenerator && ./configure \
    --enable-fnal\
    --enable-nucleon-decay\
    --enable-atmo\
    --enable-test\
    --disable-lhapdf5\
    --enable-lhapdf6\
    --enable-gfortran\
    --with-pythia6-lib=/home/dependencies/pythia/v6_428/lib\
    --with-lhapdf6-inc=/home/dependencies/Library/include\
    --with-lhapdf6-lib=/home/dependencies/Library/lib\
    --with-log4cpp-inc=/usr/local/include/\
    --with-log4cpp-lib=/usr/local/lib/\
    --with-libxml2-inc=/usr/include/libxml2\
    --with-libxml2-lib=/usr/lib/x86_64-linux-gnu/
RUN cd /home/dependencies/GenieGenerator && make -j 12

#####################
### build MARLEY ####
#####################
RUN git clone https://github.com/MARLEY-MC/marley.git /home/dependencies/marley
# particular coddling for marley
ENV CPLUS_INCLUDE_PATH=/home/dependencies/marley/include
ENV LIBRARY_PATH=/home/dependencies/marley/build
RUN cd /home/dependencies/marley/build && make all

##########################
#####  Entry Point  ######
##########################
# CMD [ "/bin/sh" ]
# CMD ["/bin/sh", "/home/cern/root_install/bin/thisroot.sh"]
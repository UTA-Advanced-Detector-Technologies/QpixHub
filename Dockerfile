FROM papahuhu/qpixhub:latest

ARG DEBIAN_FRONTEND=noninteractive

########################
### Additional tools ###
########################
RUN apt-get install -y jupyter
RUN apt-get install -y vim
RUN apt-get install -y fd-find
RUN apt-get install -y libboost-all-dev

# move qpix tags to repo
COPY source/qpixg4 /home/qpix/qpixg4
COPY source/qpixrtd /home/qpix/qpixrtd

# make sure we have a useful bashrc, before we try building
RUN echo 'source /home/cern/root_install/bin/thisroot.sh' >> ~/.bashrc
RUN echo 'source /home/cern/geant4_install/bin/geant4.sh' >> ~/.bashrc
RUN echo 'source /home/dependencies/marley/setup_marley.sh' >> ~/.bashrc

###############
#### Build ####
###############
SHELL ["/bin/bash", "-c"]
COPY /source/makeQpix.sh /home/makeQpix.sh
RUN "/home/makeQpix.sh"

#####################
### pull qpixrec ####
#####################

## TODO - Depends on Geant4.11.1.1
#######################
### build QpixOptix ###
#######################

##########################
#####  Entry Point  ######
##########################
CMD ["/bin/bash", "-l"]
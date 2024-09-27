FROM papahuhu/qpixhub:latest

ARG DEBIAN_FRONTEND=noninteractive

########################
### Additional tools ###
########################



#####################
### build QpixRTD ###
#####################

#####################
### build QpixG4 ####
#####################
RUN git clone https://github.com/MARLEY-MC/marley.git /home/dependencies/marley
# particular coddling for marley
ENV CPLUS_INCLUDE_PATH=/home/dependencies/marley/include
ENV LIBRARY_PATH=/home/dependencies/marley/build
RUN cd /home/dependencies/marley/build && make all

#####################
### build QpixRTD ###
#####################

##########################
#####  Entry Point  ######
##########################
# CMD [ "/bin/sh" ]
# CMD ["/bin/sh", "/home/cern/root_install/bin/thisroot.sh"]
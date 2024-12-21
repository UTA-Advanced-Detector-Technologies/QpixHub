FROM papahuhu/qpixana:latest

ARG DEBIAN_FRONTEND=noninteractive

#####################
### Globes Things ###
#####################
COPY snowglobes /home/extras/snowglobes
SHELL ["/bin/bash", "-c"]
COPY /makeGlobes.sh /home/makeGlobes.sh
ENV SNOWGLOBES=/home/extras/snowglobes
ENV GLB_DIR=/home/extras/SN_stuff/globes_install
COPY changes/Makefile /home/extras/snowglobes/src/Makefile
RUN "/home/makeGlobes.sh"

##########################
#####  Entry Point  ######
##########################
CMD ["/bin/bash", "-l"]

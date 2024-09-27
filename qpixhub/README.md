# QpixHub

- The latest version of this image should be found here: [[papahuhu/QpixHub][QpixHub]]

Base qpix build image from ubuntu

The docker file here creates the bare minimum build system used for qpix analysis.

The bare requirements are:
ROOT
Geant4
Marley
GENIE



## Additional tools, such as those used for analysis and creating data, are created in the docker container above, QpixANA

Additional tools built
misc, e.g.Jupyter & Vim, appropriate environment variables pre-set
a docker compose build, which should be able to automagically expose useful ports and X window forwarding
QpixG4
QpixRTD
TODO
QpixOptix
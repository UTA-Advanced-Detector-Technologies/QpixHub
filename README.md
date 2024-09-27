# QpixHUB
Q-Pix one stop shop for all analysis software.

We put everything we can onto docker so that there are no longer install or
system dependencies for building and testing.

## QpixG4
Qpix simulation build on top of geant4

## QpixRTD
Qpix detector level Reset Time Difference (RTD), simulation

## QpixANA
Qpix formal analysis application

## QpixNeut
Qpix neutron analysis applications

## Getting Started

docker run --rm -it qpixhub

### notebooks
running to see jupyter:
docker run -p 80:80

from inside shell run:
jupyter notebook --ip='0.0.0.0' --port=80 --no-browser --allow-root

### mounting a directory

option: -v
notes: <source_path>:<dest_path>
windows exampe: 
docker run -v ${PWD}/data/:/home/data -it qpixhub

nix example:
docker run -v $(PWD)/data/:/home/data -it qpixhub

-- run from top level

## Troubleshooting

## Dependencies

Listed below are the dependencies, and their respective versions


#### ROOT
v6.30

#### Geant4
Geant4-10.7.4

#### Marley

#### GENIE, GSL, libLHAPDFv5, Pythia
Includied in dependencies or explicitly cloned to specific locations


# QpixHUB
Q-Pix one stop shop for all analysis software.

We put everything we can onto docker so that there are no longer install or
system dependencies for building and testing.

## QpixNeut
- TODO
Qpix neutrino analysis applications (coming soon)

## Getting Started

``` shell
docker compose run qpix-analysis
```

### notebooks

from inside shell run:
``` shell
jupyter notebook --ip='0.0.0.0' --port=80 --no-browser --allow-root
```

### mounting a directory

- Note: this is done for you automatically with `docker compose run qpix-analysis`

option: -v
notes: <source_path>:<dest_path>
windows exampe: 
``` shell
docker run -v ${PWD}/data/:/home/data -it qpixhub
```

nix example:
``` shell
docker run -v $(PWD)/data/:/home/data -it qpixhub
```

-- run from top level

## Troubleshooting

good luck.

## Dependencies

Listed below are the dependencies, and their respective versions


#### ROOT
v6.30

#### Geant4
Geant4-10.7.4

#### Marley

#### GENIE, GSL, libLHAPDFv5, Pythia
Includied in dependencies or explicitly cloned to specific locations

#### Optix
TODO
- must most Geant4 to 4.11.1.1 first
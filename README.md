# QpixHUB
Q-Pix one stop shop for all analysis software.

We put everything we can onto docker so that there are no longer install or
system dependencies for building and testing.

## Getting Started
### Required Programs
- [VS Code](https://code.visualstudio.com/download)
- [Git](https://git-scm.com/downloads/win)
- [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)
- [Docker Extension for VS Code](https://code.visualstudio.com/docs/containers/overview)
- X-Server for UI. There are many options, I used Xming ([download](https://sourceforge.net/projects/xming/), [documentation](http://www.straightrunning.com/XmingNotes/)).

### Running the Container
- Open Docker Desktop App
- Start Your X Server (Can check if it is running in the task bar hidden icons)
- Open Windows PowerShell
- In PowerShell clone the QpixHub repository: 
``` shell
git clone https://github.com/UTA-Advanced-Detector-Technologies/QpixHub
```
- Enter the new QpixHub directory. Note: Must be in QpixHub to start the container.
``` shell
cd QpixHub
```
- Start the qpix-analysis container with the docker compose up command. This should make a running qpixhub container in Docker desktop.
``` shell
docker compose up -d qpix-analysis
```
- Open VS Code. NOTE: If you start VS Code before your X-Server, Root and Geant4 will not display properly This is easily remedied by restarting VS Code
- From VS Code attach to running container and select QpixAnalysis
- This should make a new VS Code window from which you can operate inside the container using the terminal
- NOTE: Any changes you make in the container will not be saved unless stored in the “data” directory. Additionally, you can transfer files from the container to your computer by putting them in “data”.
- To close the container use docker compose down in powershell. This will stop the container and disconnect your VS Code window
``` shell
docker compose down qpix-analysis
```
### Build an Example
An easy way to check if your X-Server is set up and connected properly is to build the geant4 example B1.
- Enter the B1 directory
``` shell
cd cern/geant4/examples/basic/B1
``` 
- Make and enter a build directory
``` shell
mkdir build; cd build
```
- Build B1
``` shell
cmake ..;
cmake --build . -j 10
```
- Run B1
``` shell
./exampleB1
```
This should run the B1 example and open a UI window. Seeing this you are all set!

## QpixNeut
- TODO
Qpix neutrino analysis applications (coming soon)

example

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

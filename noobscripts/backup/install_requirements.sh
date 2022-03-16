#!/bin/bash

# Installing Required Dependencies


##	Installing pip

printf "\n";

echo "Installing pip.....";

sudo dpkg --configure -a;

sudo apt install python-pip;

echo "pip installed successfully!";

## Installing GO lang -> https://www.tecmint.com/install-go-in-linux/  

printf "\n";

echo "Installing GO lang.....";

sudo apt-get remove golang-go;

mkdir go;

cd go/;

wget -c https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz;

sudo tar -C /usr/local -xvzf go1.13.5.linux-amd64.tar.gz;

mkdir ~/go_projects;

mkdir -p ~/go_projects/{bin,src,pkg};

cd ~/go_projects;

echo 'export  PATH=$PATH:/usr/local/go/bin;' >> ~/.profile;

echo 'export GOPATH="$HOME/go_projects";' >> ~/.profile;

echo 'export GOBIN="$GOPATH/bin";' >> ~/.profile;

source ~/.profile;

echo "GO lang installed successfully!";

printf "\n";

echo "Installing chromium browser......";

sudo apt-get install chromium-browser > /dev/null 2>&1;

echo "chromium browser installed successfully!";

printf "\n";









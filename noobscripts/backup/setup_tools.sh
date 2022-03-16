#!/bin/bash


subdomain_enumeration_tools(){

# Sublister

printf "\n";

echo "Installing Sublist3r......";

git clone https://github.com/aboul3la/Sublist3r.git > /dev/null 2>&1;

cd $HOME/recon/tools/Sublist3r;

sudo pip install -r requirements.txt > /dev/null 2>&1;

printf "\n";

echo "Sublist3r installed successfully";

printf "\n";

cd $HOME/recon/tools;

echo "Installing Subfinder......";

printf "\n";

go get -v github.com/projectdiscovery/subfinder/cmd/subfinder > /dev/null 2>&1;

cd $GOPATH/bin/;

sudo cp subfinder /usr/bin;

echo "Subfinder installed successfully!";

printf "\n";

cd $HOME/recon/tools;

echo "Installing findomain......";

printf "\n";

cd $HOME/recon/tools;

wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux > /dev/null 2>&1;

sudo chmod +x findomain-linux;

sudo mv findomain-linux /usr/bin/findomain;

echo "findomain installed successfully!";

printf "\n";

echo "Installing assertfinder......";

printf "\n";

cd $HOME/recon/tools;

wget https://github.com/tomnomnom/assetfinder/releases/download/v0.1.0/assetfinder-linux-amd64-0.1.0.tgz > /dev/null 2>&1;

sudo tar -C /usr/bin -xvzf assetfinder-linux-amd64-0.1.0.tgz > /dev/null 2>&1;

echo "assertfinder installed successfully!";

printf "\n";

echo "Installing censys-enumeration......";

printf "\n";

git clone https://github.com/0xbharath/censys-enumeration.git > /dev/null 2>&1;

cd $HOME/recon/tools/censys-enumeration/;

pip install -r requirements.txt > /dev/null 2>&1;

cd $HOME/recon/tools/;

echo "censys-enumeration installed successfully!";

printf "\n";

echo "Installing alt-dns......";

printf "\n";

pip install py-altdns > /dev/null 2>&1;

echo "alt-dns installed successfully!";

printf "\n";

echo "Installing massdns......";

printf "\n";

sudo apt-get install libldns-dev > /dev/null 2>&1;

git clone https://github.com/blechschmidt/massdns.git > /dev/null 2>&1;

cd $HOME/recon/tools/massdns;

make  > /dev/null 2>&1;

cd $HOME/recon/tools/massdns/bin/;

sudo cp massdns /usr/bin/;

echo "massdns installed successfully!";

printf "\n";

echo "Installing domains-from-csp......";

printf "\n";

git clone https://github.com/0xbharath/domains-from-csp.git > /dev/null 2>&1;

pip install pipenv > /dev/null 2>&1;

echo "domains-from-csp installed successfully!";

printf "\n";

echo "Installing assets-from-spf......";

printf "\n";

git clone https://github.com/0xbharath/assets-from-spf.git > /dev/null 2>&1;

echo "assets-from-spf installed successfully!";

printf "\n";

echo "Installing aquatone......";

printf "\n";

cd $HOME/recon/tools;

mkdir $HOME/recon/tools/aquatone;

cd $HOME/recon/tools/aquatone;

wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip > /dev/null 2>&1;

unzip aquatone_linux_amd64_1.7.0.zip > /dev/null 2>&1;

sudo cp aquatone /usr/bin;

cd $HOME/recon/tools;

echo "aquatone installed successfully!";

printf "\n";

echo "Installing dirsearch......";

printf "\n";

git clone https://github.com/maurosoria/dirsearch.git;

echo "dirsearch installed successfully!";

printf "\n";

echo "Installing ffuf......";

printf "\n";

go get github.com/ffuf/ffuf;

cd $HOME/go_projects/bin;

sudo mv ffuf /usr/bin;

echo "ffuf installed successfully!";

printf "\n";




}



main(){


mkdir $HOME/recon;

mkdir $HOME/recon/tools;

cd $HOME/recon/tools;

subdomain_enumeration_tools

}


main;

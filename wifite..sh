# Install Pyrit , Macchanger , Wifite
sudo apt-get install pyrit macchanger wifite

# Make & Install Bully
sudo apt-get -y install build-essential libpcap-dev aircrack-ng pixiewps
git clone https://github.com/aanarchyy/bully
cd bully/
cd src/
make
sudo make install
cd

# Make & Install hcxdumptool
sudo apt-get -y install libcurl4-openssl-dev libssl-dev pkg-config
git clone https://github.com/ZerBea/hcxdumptool.git
cd hcxdumptool
make
sudo make install
cd

# Make & Install hcxtools
sudo apt-get -y install pkg-config libcurl4-openssl-dev libssl-dev zlib1g-dev
git clone https://github.com/ZerBea/hcxtools.git
cd hcxtools
make
sudo make install
cd

# Make & Install hashcat
git clone https://github.com/hashcat/hashcat.git
cd hashcat
make
sudo make install
cd


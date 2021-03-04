sudo apt-get install build-essential git dkms
git clone -b arm https://github.com/kelebek333/rtl8188fu rtl8188fu-arm
sudo dkms add ./rtl8188fu-arm
sudo dkms build rtl8188fu/1.0
sudo dkms install rtl8188fu/1.0
sudo cp ./rtl8188fu-arm/firmware/rtl8188fufw.bin /lib/firmware/rtlwifi/

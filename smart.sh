echo "options usb-storage quirks=0bc2:ab24:u" >> /etc/modprobe.d/usb-storage-quirks.conf
update-initramfs -u
reboot now

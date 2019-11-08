#!/bin/sh
# KaliRPIVNCSetup
# This script will auto setup vncserver in Kali Linux Raspberry Pi for VNC session
echo sleep 5;
clear

echo ""
echo "First you need to be update your system"
read -p "Do you want update your system (Highly Recommended) (Y/N)? " ans

if [ $ans = "y" ] || [ $ans = "Y" ]
then
  echo "Updating package index.."
  sudo apt-get update -y
  echo "Updating old packages.."
  sudo apt-get upgrade -y
fi
if [ ! -f ~/.vnc/passwd ]
then
echo "Setup VNC Server... "
echo "Enter password for VNC Server "
vncserver
else
read -p "Do you want change your VNC server Password[Y/N ] " tc_vncpass
	if [ $tc_vncpass = "y" ] || [ $tc_vncpass = "Y" ]
	then
		echo "Change VNC Password "
		vncpasswd 
	fi
fi
echo "Step 1: Generating autostart script for VNC session..."
read -p "Enter your display resolution for VNC session (i.e. 800x600, 1024x768):- " tc_server
read -p "Enter depth for VNC session (i.e. 16, 24, 32):- " tc_depth
cd /etc/init.d/
if [ -f vncsetup ]
then
rm vncsetup
update-rc.d vncsetup remove
fi
echo "#!/bin/sh
### BEGIN INIT INFO
# Provides: tightvncserver
# Required-Start: \$local_fs \$remote_fs \$syslog
# Required-Stop: \$local_fc \$remote_fs \$syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: auto setup vnc server
# Description: auto setup vncserver in kali linux for rpi
#
### END INIT INFO
# /etc/init.d/vncsetup
USER=root
HOME=/root
export USER HOME
case" '$1' "in
start)
/usr/bin/vncserver :1 -geometry" $tc_server" -depth" $tc_depth"
;;
stop)
pkill Xtightvnc
;;
*)
exit 1
;;
esac
exit 0
" > vncsetup
echo ""
echo "Step 2: Setup autostart script"
echo "Wait..."; sleep 2;
chmod +x vncsetup
update-rc.d vncsetup defaults
echo "Congratulation your VNC auto start setup successfully completed"
read -p "Do you want to restart your RPI (y/n)?: " tc_reboot
if [ $tc_reboot = "y" ] || [ $tc_reboot = "Y" ]; then
echo sleep 5;
reboot
fi

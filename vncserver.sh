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
cd /etc/init.d/
if [ -f vncserver ]
then
rm vncserver
update-rc.d vncserver remove
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

PATH="$PATH:/usr/X11R6/bin/"

# The Username:Group that will run VNC
export USER="kali"
#${RUNAS}

# The display that VNC will use
DISPLAY="1"

# Color depth (between 8 and 32)
DEPTH="16"

# The Desktop geometry to use.
#GEOMETRY="<WIDTH>x<HEIGHT>"
#GEOMETRY="800x600"
GEOMETRY="1024x768"
#GEOMETRY="1280x1024"

# The name that the VNC Desktop will have.
NAME="vncserver"

OPTIONS="-name ${NAME} -depth ${DEPTH} -geometry ${GEOMETRY} :${DISPLAY}"

. /lib/lsb/init-functions

case "$1" in
start)
log_action_begin_msg "Starting vncserver for user '${USER}' on   localhost:${DISPLAY}"
su ${USER} -c "/usr/bin/vncserver ${OPTIONS}"
;;

stop)
log_action_begin_msg "Stoping vncserver for user '${USER}' on localhost:${DISPLAY}"
su ${USER} -c "/usr/bin/vncserver -kill :${DISPLAY}"
;;

restart)
$0 stop
$0 start
;;
esac

exit 0
" > vncserver
echo ""
echo "Step 2: Setup autostart script"
echo "Wait..."; sleep 2;
chmod +x vncserver
update-rc.d vncserver defaults
echo "Congratulation your VNC auto start setup successfully completed"
read -p "Do you want to restart your RPI (y/n)?: " tc_reboot
if [ $tc_reboot = "y" ] || [ $tc_reboot = "Y" ]; then
echo sleep 5;
reboot
fi

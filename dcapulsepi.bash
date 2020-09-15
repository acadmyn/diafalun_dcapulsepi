echo "Updating..."
apt update -y
apt upgrade -y
echo "Done updating. Waiting a few seconds..."
sleep 5
clear

echo "Installing desktop environment..."
apt install -y raspberrypi-ui-mods
echo "Done installing DE. Waiting a few seconds..."
sleep 5
clear

echo "Installing Firefox..."
apt install -y firefox-esr
echo "Done installing Firefox. Waiting a few seconds..."
sleep 5
clear

echo "Installing Teamviewer..."
cd /home/pi
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb
dpkg -i teamviewer-host_armhf.deb
apt -f upgrade -y
#Prompta för tw lösen
echo "Välj ett lösenord för TeamViewer host: "
read twpasswd
teamviewer passwd $twpasswd
teamviewer license accept
echo "Done installing Teamviewer. Waiting a few seconds..."
sleep 5

echo "Installing Log2RAM..."
apt install -y git
cd /home/pi
git clone https://github.com/azlux/log2ram.git
cd log2ram
chmod +x install.sh
sh ./install.sh
echo "Done installing Log2RAM. Waiting a few seconds..."
sleep 5

echo "Creating daily reboot crontab"
crontab -l | { cat; echo "0 0	* * *	root	/sbin/shutdown -r now"; } | crontab -


echo "Cleaning up a little bit..!"
apt autoremove -y

reboot now
clear

echo -e "Påbörjar uppdatering och installation av följande paket:\nraspberrypi-ui-mods\nfirefox-esr\nTeamviewer\nLog2RAM\n\nByt standardlösen (raspberry): "
sudo passwd pi

echo "Skapa ett lösen för rootanvändaren: "
sudo passwd root

sudo sed -i 's/NOPASSWD/PASSWD/' /etc/sudoers.d/010_pi-nopasswd

echo "Uppdaterar..."
apt update -y
apt upgrade -y
echo "Klar. Väntar ett par sekunder..."
sleep 5
clear

echo "Installerar skrivbordsmiljö..."
apt install -y raspberrypi-ui-mods
echo "Klar. Väntar ett par sekunder..."
sleep 5
clear

echo "Installerar Firefox..."
apt install -y firefox-esr
echo "Klar. Väntar ett par sekunder..."
sleep 5
clear

echo "Installerar Teamviewer..."
cd /home/pi
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb
dpkg -i teamviewer-host_armhf.deb
apt -f upgrade -y
#Prompta för tw lösen
echo "Välj ett lösenord för TeamViewer host: "
read twpasswd
teamviewer passwd $twpasswd
teamviewer license accept
echo "Klar. Väntar ett par sekunder..."
sleep 5

echo "Installerar Log2RAM..."
apt install -y git
cd /home/pi
git clone https://github.com/azlux/log2ram.git
cd log2ram
chmod +x install.sh
sh ./install.sh
sudo sed -i 's/SIZE=40M/SIZE=128M/' /etc/log2ram.conf
echo "Klar. Väntar ett par sekunder..."
sleep 5

#echo "Skapar schemalagd omstart..."
#crontab -l | { cat; echo "0 0	* * *	root	/sbin/shutdown -r now"; } | crontab -


echo "Städar upp lite..."
apt autoremove -y
clear

echo "Startar om datorn om 10 sekunder..."
sleep 10
reboot now

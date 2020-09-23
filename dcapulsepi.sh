clear

echo "Påbörjar uppdatering och installation av följande paket:\nraspberrypi-ui-mods\nfirefox-esr\nTeamviewer\nLog2RAM\n\nByt standardlösen (raspberry): "
sudo passwd pi

echo "Skapa ett lösen för rootanvändaren: "
sudo passwd root

echo "Välj ett lösenord för TeamViewer host: "
read twpasswd

clear

sudo sed -i 's/NOPASSWD/PASSWD/' /etc/sudoers.d/010_pi-nopasswd

echo "Uppdaterar..."
apt update -y
apt upgrade -y
echo "Klar. Väntar ett par sekunder..."
sleep 3

echo "Installerar skrivbordsmiljö..."
apt install -y raspberrypi-ui-mods
echo "Klar. Väntar ett par sekunder..."
sleep 3

echo "Installerar Firefox..."
apt install -y firefox-esr
echo "Klar. Väntar ett par sekunder..."
sleep 3

echo "Installerar Teamviewer..."
cd /home/pi
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb
dpkg -i teamviewer-host_armhf.deb
apt -f upgrade -y
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

echo "Skapar schemalagd omstart..."
sudo -s
#crontab -l | { cat; echo "0 0	* * *	root	/sbin/shutdown -r now"; } | crontab -
echo "0 0    * * *    root    /sbin/shutdown -r now" >> /etc/crontab
exit


echo "Städar upp lite..."
apt autoremove -y

sudo sed -i 's/#hdmi_group=0/hdmi_group=2/' /boot/config.txt
sudo sed -i 's/#hdmi_mode=1/hdmi_mode=85/' /boot/config.txt
sudo teamviewer info

echo "Notera Teamviewer ID:t ovan. Tryck enter för att starta om datorn"

read klarenter

sudo reboot now

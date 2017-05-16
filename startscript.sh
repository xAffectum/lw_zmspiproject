#!/bin/bash
file=/boot/interfaces
if [ ! -e $file ]; then
#Erstkonfiguration starten
clear
setterm -foreground green -store
echo "                            "
echo " ##### #   # #####  #####   "
echo "    #  ## ## #      #   # # "
echo "   #   # # # #####  #####   "
echo "  #    #   #     #  #     # "
echo " ##### #   # #####  #     # "
echo "  Powered by ITDZ Berlin    "
echo "                            "
echo "                            "
setterm -foreground cyan -store
echo "Erstkonfiguration zur Verwendung einer statischen IP Adresse"
echo "                          "
#true="n";while [ "$true" == "n" ] || [ "$true" =="N" ];do
read -p "Geben Sie bitte die statische IP Adresse ein: " ipaddress
#read -p "Sie haben die IP $ipaddress eingegeben, ist diese IP richtig ? (j/n) " true;done
#true="n";while [ "$true" == "n" ] || [ "$true" =="N" ];do
read -p "Geben Sie bitte die Netzwerkmaske ein: " netmask
#read -p "Sie haben die Netzwerkmaske $netmask eingegeben, ist diese Netzwerkmaske korrekt ? (j/n) " true;done
#true="n";while [ "$true" == "n" ] || [ "$true" =="N" ];do
read -p "Geben Sie bitte das Gateway des Netzes ein: " gateway
#read -p "Sie haben das Gateway $gateway eingegeben, ist dieses Gateway richtig ? (j/n) " true;done
#true="n";while [ "$true" == "n" ] || [ "$true" =="N" ];do
read -p "Geben Sie bitte den Hostname des Gerätes ein: " hostname
#read -p "Sie haben den Hostnamen $hostname eingegeben, ist dieser Hostname richtig ? (j/n) " true;done

# DHCP Dienst entfernen
apt-get purge dhcpcd5 -y

# Neue Datei für Netzwerkkonfiguration erzeugen und auf Boot Verzeichnis verknüpfen
mv /etc/network/interfaces /etc/network/interfaces.org
ln -fs /boot/interfaces /etc/network/interfaces

# Ethernetkonfiguration anlegen
cat << EOF > $file
# Ethernet
auto eth0
allow-hotplug eth0
iface eth0 inet static
address $ipaddress
netmask $netmask
gateway $gateway
dns-nameservers $gateway
EOF

# Hostnamen festlegen
mv /etc/hostname /etc/hostname.org
echo "$hostname" > /etc/hostname
mv /etc/hosts /etc/hosts.org
echo "127.0.0.1 $hostname" > /etc/hosts

setterm -foreground white -store
echo "Erstkonfiguration wurde abgeschlossen!"
echo "Das System wird jetzt neugestarten!"

reboot
fi

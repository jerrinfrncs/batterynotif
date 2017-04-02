#!/bin/bash

POWERSUPPLY="/sys/class/power_supply/ADP1/online" # could be different on your system!
NOT_CHARGING="0"

#Select a path for your distro
ICONL="/usr/share/icons/Ambiant-MATE/status/24/battery-caution.svg"
ICONH="/usr/share/icons/Ambiant-MATE/status/24/battery-080.svg"

while true
do

battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
STATUS=$(cat $POWERSUPPLY) #charger connected or not

if [ $battery_level -ge 80 -a $STATUS = 1 ] #battery Charged
    	then
        	/usr/bin/notify-send -i "$ICONH" "Battery Charged" "Battery level is ${battery_level}%!" 
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga

	elif [ $battery_level -le 10 -a $STATUS = $NOT_CHARGING ] #battery low 3 shutdown
    	then
       		/usr/bin/notify-send -i "$ICONC" "About to shutdown connect charger" "Battery level is ${battery_level}%!" 
	 	paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
         	sleep 30s
		/usr/bin/notify-send -I "$ICONS" "Too late, Shutting down"
		sleep 15s
	 	systemctl poweroff 

	elif [ $battery_level -le 15 -a $STATUS = $NOT_CHARGING ] #battery low 2 final warning
    	then
       		/usr/bin/notify-send -i "$ICONL" "Battery Critical" "Battery level is ${battery_level}%!" 
	 	paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga  
   
    	elif [ $battery_level -le 25 -a $STATUS = $NOT_CHARGING ] #battery low 1 first warning
    	then
       		/usr/bin/notify-send -i "$ICONL" "Battery low" "Battery level is ${battery_level}%!" 
	        paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga  
    	fi
   sleep 2m #run every two minutes
done

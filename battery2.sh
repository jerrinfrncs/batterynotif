#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
POWERSUPPLY="/sys/class/power_supply/ADP1/online" # could be different on your system!
TOO_LOW=25 # how low is too low?
NOT_CHARGING="0"
ICONH="/usr/share/icons/Arc/apps/24@2x/unity-power-panel.png"
ICONL="/usr/share/icons/Arc/panel/22/gpm-battery-020.svg"
ICONC="/usr/share/icons/Faba/24x24/panel/gpm-battery-000.svg"
ICONS="/usr/share/icons/Arc/panel/22/system-devices-panel-alert.svg"


while true
do
	STATUS=$(cat $POWERSUPPLY) #charger connected or not
    	battery_level=`upower -i $(upower -e | grep BAT) | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//`

    	if [ $battery_level -ge 80 -a $STATUS = 1 ]
    	then
        	/usr/bin/notify-send -i "$ICONH" "Battery Charged" "Battery level is ${battery_level}%!" 
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga
   
    	elif [ $battery_level -le 25 -a $STATUS = $NOT_CHARGING ]
    	then
       		/usr/bin/notify-send -i "$ICONL" "Battery low" "Battery level is ${battery_level}%!" 
	 paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga  

	elif [ $battery_level -le 15 -a $STATUS = $NOT_CHARGING ]
    	then
       		/usr/bin/notify-send -i "$ICONL" "Battery Critical" "Battery level is ${battery_level}%!" 
	 paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga  

	elif [ $battery_level -le 10 -a $STATUS = $NOT_CHARGING ]
    	then
       		/usr/bin/notify-send -i "$ICONC" "About to shutdown connect charger" "Battery level is ${battery_level}%!" 
	 paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
         sleep 30s
	/usr/bin/notify-send -I "$ICONS" "Too late, Shutting down"
	sleep 15s
	 systemctl poweroff 
    	fi
   sleep 2m
done
    


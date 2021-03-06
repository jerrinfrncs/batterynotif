#!/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin
POWERSUPPLY="/sys/class/power_supply/ADP1/online" # could be different on your system!
NOT_CHARGING="0"
#change for your system
ICONH="/usr/share/icons/Arc/apps/24@2x/unity-power-panel.png"
ICONL="/usr/share/icons/Arc/panel/22/gpm-battery-020.svg"
ICONC="/usr/share/icons/Faba/24x24/panel/gpm-battery-000.svg"
ICONS="/usr/share/icons/Arc/panel/22/system-devices-panel-alert.svg"


while true
do
	STATUS=$(cat $POWERSUPPLY) #charger connected or not
    	battery_level=`upower -i $(upower -e | grep BAT) | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//`

    	if [ $battery_level -ge 80 -a $STATUS = 1 ] #battery Charged
    	then
        	/usr/bin/notify-send -i "$ICONH" "Battery Charged" "Battery level is ${battery_level}%!" 
	paplay /usr/share/sounds/freedesktop/stereo/complete.oga

	elif [ $battery_level -le 10 -a $STATUS = $NOT_CHARGING ] #battery low 3 shutdown
    	then
       		/usr/bin/notify-send -i "$ICONC" "About to shutdown connect charger" "Battery level is ${battery_level}%!" 
	 	paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
		
         	sleep 30s
	
		/usr/bin/notify-send -i "$ICONS" "Too late, Shutting down"
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
    

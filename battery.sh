#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
POWERSUPPLY="/sys/class/power_supply/ADP1/online" # could be different on your system!
TOO_LOW=25 # how low is too low?
NOT_CHARGING="0"
ICONL="/usr/share/icons/Ambiant-MATE/status/24/battery-caution.svg" # eye candy
ICONH="/usr/share/icons/Ambiant-MATE/status/24/battery-080.svg"

export DISPLAY=:0

BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')
STATUS=$(cat $POWERSUPPLY) #charger connected or not

##Battery Charged

if [ $BATTERY_LEVEL -ge 80 -a $STATUS = 1 ]
then
    /usr/bin/notify-send -u critical -i "$ICONH" -t 3000 "Battery Charged" "Battery level is ${BATTERY_LEVEL}%!"
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga
fi

##Battery Warning 1

if [ $BATTERY_LEVEL -le $TOO_LOW -a $STATUS = $NOT_CHARGING ]
then
    /usr/bin/notify-send -u critical -i "$ICONL" -t 3000 "Battery low" "Battery level is ${BATTERY_LEVEL}%!"
    paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
fi

##Battery Warning 2

if [ $BATTERY_LEVEL -le 10 -a $STATUS = $NOT_CHARGING ]
then
    /usr/bin/notify-send -u critical -i "$ICONL" -t 3000 "Connect charger or System Will Shutdown Now" "Battery Critical ${BATTERY_LEVEL}%!"
    paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
fi

#System Shutting down
if [ $BATTERY_LEVEL -le 5 -a $STATUS = $NOT_CHARGING ]
then
    /usr/bin/notify-send -u critical -i "$ICONL" -t 3000 "System is shutting down" "Battery Critical ${BATTERY_LEVEL}%!"
    paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
	poweroff
fi

exit 0

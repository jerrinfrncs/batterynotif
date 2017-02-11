#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
POWERSUPPLY="/sys/class/power_supply/ADP1/online" # could be different on your system!
TOO_LOW=25 # how low is too low?
NOT_CHARGING="0"
STATUS=$(cat $POWERSUPPLY) #charger connected or not
echo $STATUS

    battery_level=`upower -i $(upower -e | grep BAT) | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//`
echo $battery_level
    if [ $battery_level -ge 80 -a $STATUS = 1 ]
    then
        /usr/bin/notify-send "Battery Charged" "Battery level is ${battery_level}%!"    
    elif [ $battery_level -le 30 -a $STATUS = $NOT_CHARGING ]
    then
        /usr/bin/notify-send "Battery low" "Battery level is ${battery_level}%!"   
    fi

    


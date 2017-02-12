# batterynotif
Battery Level Notifier when Linux fails to. I was frustrated that linux didn't notify me the battery level and caused many times for my laptop to shutdown unsafely. So I searched for answers on the internet, compiled them to a script which notifies you when battery is full, low and shutdowns when power is critically low.

This work is based on a couple of answers I found on the internet,

http://unix.stackexchange.com/a/190155
http://askubuntu.com/a/519045
https://bbs.archlinux.org/viewtopic.php?id=162900
http://askubuntu.com/a/277224

I will add others later. I have only made some additions. 

I am not an expert in shell script and hence there may be some unessecary code. Any corrections is gladly welcome for an efficent implementation.

The two shell scripts does the same thing, one uses ACPI and other uses uname. Choose the one which works for you.

You can run the scripts automatically by either using cron or just adding to autostart. The ACPI one may need editing to work in intervals.

Install
Download the .desktop configuration file and copy to /home/.conf/autostart
Create a script folder paste the acpi or uname file
You should be set.

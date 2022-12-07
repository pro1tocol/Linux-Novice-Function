#!/bin/bash
#by C4ry_Anaymouns build
echo " Instructions: sh Backlight.sh 1000 "


echo " \n maximum-brightness: \c " && {cat /sys/class/backlight/intel_backlight/max_brightness}

echo " \n Adjust the brightness to: \c" && echo $1 > /sys/class/backlight/intel_backlight/brightness && cat /sys/class/backlight/intel_backlight/brightness

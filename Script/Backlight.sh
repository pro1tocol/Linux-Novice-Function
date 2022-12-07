#!/bin/bash
#by C4ry_Anaymouns build
echo ' Instructions: sh Backlight.sh 200 '
echo " ____             _    _ _       _     _   "
echo "| __ )  __ _  ___| | _| (_) __ _| |__ | |_ "
echo "|  _ \ / _` C 4 ry_Anaymouns _` | '_ \| __|"
echo "| |_) | (_| | (__|   <| | | (_| | | | | |_ "
echo "|____/ \__,_|\___|_|\_\_|_|\__, |_| |_|\__|"
echo "                           |___/           "


echo " \n maximum-brightness: \c " && {cat /sys/class/backlight/intel_backlight/max_brightness}

echo " \n Adjust the brightness to: \c"
echo $1 > /sys/class/backlight/intel_backlight/brightness && cat /sys/class/backlight/intel_backlight/brightness

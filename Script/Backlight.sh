echo "Current maximum brightness: "
cat /sys/class/backlight/intel_backlight/max_brightness

echo "Adjust the brightness to: "
echo 1000 > /sys/class/backlight/intel_backlight/brightness
cat /sys/class/backlight/intel_backlight/brightness

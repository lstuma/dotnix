notify_brightness() {
  brightness=$(awk -v g=$(brightnessctl g) -v m=$(brightnessctl m) 'BEGIN { printf "%.0f", g / m * 100 }')
  notify-send "Brightness: $brightness%" \
    -h string:x-dunst-stack-tag:brightness \
    -h int:value:"$brightness" \
    --urgency=low
}

case $1 in
  up)
    brightnessctl -q s $2%+
    notify_brightness
    ;;
  down)
    brightnessctl -q s $2%-
    notify_brightness
    ;;
esac

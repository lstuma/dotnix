#!/usr/bin/env bash
notify_volume() {
  volume=$(pamixer --get-volume)
  notify-send "Volume: $volume%" \
    -h string:x-dunst-stack-tag:audio \
    -h int:value:"$volume" \
    --urgency=low
}

case $1 in
  mute)
    pamixer --toggle-mute
    notify-send "$( [ "`pamixer --get-mute`" == "true" ] && echo " Muted" || echo " Unmuted" )" \
      -h string:x-dunst-stack-tag:audio \
      --urgency=low
    ;;
  up)
    pamixer --increase $2
    notify_volume
    ;;
  down)
    pamixer --decrease $2
    notify_volume
    ;;
esac

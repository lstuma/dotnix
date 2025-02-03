output(text, tooltip) {
    # waybar output in json format
    echo "{\"text\":\"$text\", \"tooltip\": \"$tooltip\"}"
}

SLEEPWATCH_TIMESTEP=0.2
sleepwatch(file, time) {
    state=$(stat -c %Y "$file")
    waited=0
    while [ $waited -lt $time ]; do
        if [ $state -ne $(stat -c %Y "$file") ]; then
            break
        fi
        sleep $SLEEPWATCH_TIMESTEP
        waited=$(($waited + $SLEEPWATCH_TIMESTEP))
    done
}

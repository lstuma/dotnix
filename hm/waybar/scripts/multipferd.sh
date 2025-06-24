#!/usr/bin/env bash
PFERD_CFG_PATH="$HOME/.config/PFERD/pferd.cfg"
crawler=$(cat $PFERD_CFG_PATH | sed -nE "s/\[crawl:(.*)\]/\1/p" | grep -v "#")

# crawl is a list of crawlers, separated by newlines
if [ -z "$crawler" ]; then
    echo "No crawler configured in $PFERD_CFG_PATH"
    exit 1
fi
# start all crawlers in parallel
for c in $crawler; do
    echo "Starting crawler: $c"
    pferd -C $c &
done
# wait for all crawlers to finish
wait

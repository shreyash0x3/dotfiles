#!/bin/bash

TIMER_FILE="/tmp/waybar_timer"

# If file exists and running, read remaining time
if [[ -f "$TIMER_FILE" ]]; then
    END_TIME=$(<"$TIMER_FILE")
    NOW=$(date +%s)
    REMAINING=$(( END_TIME - NOW ))

    if (( REMAINING <= 0 )); then
        echo "⏰ 00:00"
        rm "$TIMER_FILE"
    else
        MINUTES=$(( REMAINING / 60 ))
        SECONDS=$(( REMAINING % 60 ))
        printf "⏳ %02d:%02d\n" "$MINUTES" "$SECONDS"
    fi
else
    echo "▶️"
fi

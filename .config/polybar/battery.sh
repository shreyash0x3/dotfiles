#!/bin/bash

BATTERY_PATH=$(upower -e | grep 'BAT')

if [ -n "$BATTERY_PATH" ]; then
    BATTERY_INFO=$(upower -i "$BATTERY_PATH")
    PERCENTAGE=$(echo "$BATTERY_INFO" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
    STATUS=$(echo "$BATTERY_INFO" | grep -E "state" | awk '{print $2}')

    # Set color based on status
    if [[ "$STATUS" == "charging" || "$STATUS" == "fully-charged" ]]; then
        COLOR="#00FF00"  # Green when charging
    else
        COLOR="#00AFFF"  # Default dodger blue
    fi

    echo "%{F$COLOR}󱐋%{F-} ${PERCENTAGE}%"
else
    echo "No Battery"
fi

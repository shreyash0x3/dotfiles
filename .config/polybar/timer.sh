#!/bin/bash

TIMER_FILE="/tmp/polybar-timer"
DEFAULT_TIME=3000  # 50 min in seconds

# Handle click toggle
if [ "$1" == "toggle" ]; then
  if pgrep -f "timer.sh run" >/dev/null; then
    pkill -f "timer.sh run"
    echo "" > "$TIMER_FILE"
  else
    echo $DEFAULT_TIME > "$TIMER_FILE"
    nohup "$0" run >/dev/null 2>&1 &
  fi
  exit 0
fi

# Timer countdown loop
if [ "$1" == "run" ]; then
  while true; do
    if [ -f "$TIMER_FILE" ]; then
      SECONDS_LEFT=$(cat "$TIMER_FILE")
      if [ "$SECONDS_LEFT" -le 0 ]; then
        notify-send "⏱ Timer Done!"
        echo "" > "$TIMER_FILE"
        exit 0
      fi
      echo $((SECONDS_LEFT - 1)) > "$TIMER_FILE"
    fi
    sleep 1
  done
  exit 0
fi

# Display
if [ -f "$TIMER_FILE" ]; then
  SECONDS_LEFT=$(cat "$TIMER_FILE")
  if [[ "$SECONDS_LEFT" =~ ^[0-9]+$ ]] && [ "$SECONDS_LEFT" -gt 0 ]; then
    MINUTES=$((SECONDS_LEFT / 60))
    SECONDS=$((SECONDS_LEFT % 60))
    printf "🕒 %02d:%02d\n" "$MINUTES" "$SECONDS"
    exit 0
  fi
fi

# When timer is idle
echo "%{F#00AFFF} 󰄉 %{F-}"
exit 0

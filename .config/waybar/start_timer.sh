#!/bin/bash
# ~/.config/waybar/start_timer.sh

TIMER_FILE="/tmp/waybar_timer"
date -d "+50 minutes" +%s > "$TIMER_FILE"

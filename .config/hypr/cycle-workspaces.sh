#!/bin/bash

# Get list of active workspace IDs (those with at least one window)
workspaces=($(hyprctl workspaces -j | jq '.[].id' | sort -n))

# Get current workspace ID
current=$(hyprctl activeworkspace -j | jq '.id')

# Find the index of the current workspace
for i in "${!workspaces[@]}"; do
  if [[ "${workspaces[$i]}" == "$current" ]]; then
    index=$i
    break
  fi
done

# Get next index (with wrap-around)
next_index=$(( (index + 1) % ${#workspaces[@]} ))

# Get next workspace ID
next_workspace=${workspaces[$next_index]}

# Switch to that workspace
hyprctl dispatch workspace "$next_workspace"

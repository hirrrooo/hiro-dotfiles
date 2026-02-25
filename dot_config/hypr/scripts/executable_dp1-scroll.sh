#!/bin/bash
# dp1-scroll.sh
# Usage: ./dp1-scroll.sh next|prev
# This script looks up all workspaces on monitor DP-2 and
# switches to the next or previous workspace in numeric order.

if [ -z "$1" ]; then
    echo "Usage: $0 next|prev"
    exit 1
fi

direction="$1"

# Get the active workspace on monitor DP-2.
current_ws=$(hyprctl activeworkspace -j | jq -r 'select(.monitor=="DP-2") | .id')
if [ -z "$current_ws" ]; then
    current_ws=0
fi

# Get a sorted list of workspace IDs on DP-2.
ws_ids=( $(hyprctl workspaces -j | jq -r '.[] | select(.monitor=="DP-2" and (.name | contains("special") | not)) | .id' | sort -n))

if [ ${#ws_ids[@]} -eq 0 ]; then
    echo "No workspaces found on DP-2."
    exit 1
fi

if [ "$direction" = "next" ]; then
    next_ws=""
    for id in "${ws_ids[@]}"; do
        if [ "$id" -gt "$current_ws" ]; then
            next_ws=$id
            break
        fi
    done
    # Wrap around to the first workspace if none found above the current.
    if [ -z "$next_ws" ]; then
        next_ws=${ws_ids[0]}
    fi
    target_ws="$next_ws"
elif [ "$direction" = "prev" ]; then
    prev_ws=""
    for id in "${ws_ids[@]}"; do
        if [ "$id" -lt "$current_ws" ]; then
            prev_ws=$id
        fi
    done
    # If no previous workspace is found, wrap around to the last one.
    if [ -z "$prev_ws" ]; then
        prev_ws=${ws_ids[${#ws_ids[@]}-1]}
    fi
    target_ws="$prev_ws"
else
    echo "Unknown direction: $direction"
    exit 1
fi

echo "Switching to workspace $target_ws on DP-2..."
hyprctl dispatch workspace "$target_ws"
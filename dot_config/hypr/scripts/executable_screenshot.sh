#!/bin/bash
# Screenshot Script // Copies photo to clipboard, saves in ~/Pictures/Screenshots and sends notifcation with preview.

# Set the screenshot directory and file name
DIR=~/Pictures/Screenshots
FILE="grim_$(date +%m-%d-%Y.%H:%M).png"
SAVE_TO="$DIR/$FILE"

# Create the Screenshots directory if it doesn't exist
mkdir -p $DIR

# Take a screenshot with grim (and slurp for selection)
grim -g "$(slurp)" $SAVE_TO
# Send a notification if grim was successful
if [ $? -eq 0 ]; then
    notify-send -i "$SAVE_TO" "Screenshot captured" 
    wl-copy < $DIR/$FILE
fi

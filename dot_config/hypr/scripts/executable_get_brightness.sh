#!/bin/bash
#
# get_brightness.sh
#
# Reads the active BUS ID from the state file, gets its
# brightness, and maps the BUS ID to a friendly
# display number (e.g., 1, 2) for Waybar.
# Outputs: "<display_num> <brightness_percent>"

# --- Configuration ---
DEFAULT_BUS_ID=11 # Corresponds to /dev/i2c-11
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/waybar_active_bus_id"
# --- End Configuration ---

# 1. Get the active Bus ID
if [ -f "$STATE_FILE" ]; then
    BUS_ID=$(cat "$STATE_FILE")
else
    BUS_ID=$DEFAULT_BUS_ID
fi

# 2. Get brightness value (using --bus for speed)
BRIGHTNESS=$(ddcutil --bus $BUS_ID getvcp 10 | awk -F '[, ]+' '{print $9}')

# 3. --- MAP BUS ID TO FRIENDLY DISPLAY NUMBER ---
#    !!! EDIT THIS SECTION to match your setup !!!
#    Syntax is: <bus_id>) DISPLAY_NUMBER=<friendly_name> ;;
DISPLAY_NUMBER=0
case $BUS_ID in
    11) # If bus ID is 11...
        DISPLAY_NUMBER=1 # ...show '1'
        ;;
    10) # If bus ID is 10...
        DISPLAY_NUMBER=2 # ...show '2'
        ;;
    *)  # Default case if bus ID is unknown
        DISPLAY_NUMBER="?"
        ;;
esac
# ------------------------------------------------

# 4. Output the FRIENDLY number and Brightness for Waybar's format
echo "$DISPLAY_NUMBER $BRIGHTNESS"
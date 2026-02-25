#!/bin/bash
#
# adjust_brightness.sh
#
# (v3) Optimized with --bus and flock locking.

# --- Configuration ---
DEFAULT_BUS_ID=11 # Corresponds to /dev/i2c-11
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/waybar_active_bus_id"
LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/waybar_brightness.lock"
STEP=5
# --- End Configuration ---

# 1. Check for lock
exec 200>"$LOCK_FILE"
if ! flock -n 200; then
    echo "Brightness adjustment already in progress."
    exit 1
fi
# Lock is auto-released on exit.

# 2. Get the active Bus ID
if [ -f "$STATE_FILE" ]; then
    BUS_ID=$(cat "$STATE_FILE")
else
    BUS_ID=$DEFAULT_BUS_ID
fi

# 3. Check for valid argument
if [ "$1" != "up" ] && [ "$1" != "down" ]; then
    echo "Usage: $0 up|down"
    exit 1
fi

# 4. Use ddcutil's built-in math (ONE call, using --bus)
if [ "$1" == "up" ]; then
    ddcutil --bus $BUS_ID setvcp 10 + $STEP
else # "$1" == "down"
    ddcutil --bus $BUS_ID setvcp 10 - $STEP
fi

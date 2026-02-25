#!/bin/bash
#
# cycle_display.sh
#
# Cycles between a list of monitor BUS IDs.
# Find yours with: ddcutil detect

# --- Configuration ---
# !!! SET THIS TO YOUR DDCUTIL BUS IDS (e.g., 10, 11) !!!
MONITORS=(11 10) # Example: (/dev/i2c-11, /dev/i2c-10)

# State file (stores the active BUS ID)
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/waybar_active_bus_id"
# --- End Configuration ---

# 1. Get the current ID from state file, or default to first monitor
CURRENT_ID=0
if [ -f "$STATE_FILE" ]; then
    CURRENT_ID=$(cat "$STATE_FILE")
else
    CURRENT_ID=${MONITORS[0]}
fi

# 2. Find the index of the current ID in the array
CURRENT_INDEX=-1
for i in "${!MONITORS[@]}"; do
    if [ "${MONITORS[$i]}" -eq "$CURRENT_ID" ]; then
        CURRENT_INDEX=$i
        break
    fi
done

# 3. Get the next index (and wrap around)
if [ "$CURRENT_INDEX" -eq -1 ]; then
    NEXT_INDEX=0
else
    NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#MONITORS[@]} ))
fi

# 4. Get the new active ID
NEW_ID=${MONITORS[$NEXT_INDEX]}

# 5. Save the new ID to the state file
echo "$NEW_ID" > "$STATE_FILE"
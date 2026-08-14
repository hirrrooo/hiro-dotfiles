#!/bin/bash

# Get the class of the currently active window
APP_CLASS=$(hyprctl activewindow -j | jq -r '.class')
APP_CMD=$(echo "$APP_CLASS" | tr '[:upper:]' '[:lower:]')

# Optional: Handle specific app name or container mapping overrides
case "$APP_CLASS" in
    "Brave-browser")
        LAUNCH_CMD="brave"
        ;;
    "com.discordapp.Discord"|discord)
        # Example for a distrobox app where class != desktop launcher name
        LAUNCH_CMD="discord"
        ;;
    *)
        # Fallback: try to find a matching .desktop file in local applications or use lowercased class
        DESKTOP_FILE=$(find ~/.local/share/applications /usr/share/applications -iname "*$APP_CMD*.desktop" 2>/dev/null | head -n 1)
        
        if [ -n "$DESKTOP_FILE" ]; then
            # Extract the Exec line from the .desktop file, stripping out field codes like %U or %f
            LAUNCH_CMD=$(grep "^Exec=" "$DESKTOP_FILE" | head -n 1 | cut -d'=' -f2- | sed 's/ [[:alnum:]_%]*$//')
        else
            LAUNCH_CMD="$APP_CMD"
        fi
        ;;
esac

# Close the active window
hyprctl dispatch killactive ""

# Wait a brief moment for the window to close safely
sleep 0.3

# Reopen the application in the background using evaluated/extracted command
eval "$LAUNCH_CMD &"

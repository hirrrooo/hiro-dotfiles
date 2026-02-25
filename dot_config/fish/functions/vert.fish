function vert --wraps='hyprctl dispatch movecurrentworkspacetomonitor DP-2' --wraps='hyprctl dispatch movecurrentworkspacetomonitor DP-2 && exit' --description 'alias vert=hyprctl dispatch movecurrentworkspacetomonitor DP-2 && exit'
    hyprctl dispatch movecurrentworkspacetomonitor DP-2 && exit $argv
end

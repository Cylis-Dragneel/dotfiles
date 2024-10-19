{ pkgs }:

pkgs.writeShellScriptBin "battery" # bash
  ''
    empty_threshold=25
    full_threshold=80
    while true; do
      BAT=$(cat /sys/class/power_supply/BAT0/capacity)
      if [ "$BAT" -le "$empty_threshold" ]; then
        ${pkgs.libnotify}/bin/notify-send "Battery low" "$BAT% left"
        sleep 300
      fi
      if [ "$BAT" -ge "$full_threshold" ]; then
        ${pkgs.libnotify}/bin/notify-send "Battery full" "$BAT% left"
        sleep 300
      fi
      sleep 60
    done
  ''

swww kill
bg=$(ls ~/Pictures/ | wofi --dmenu)
swaybg -m fill -i ~/Pictures/$bg & disown

wal -i ~/Pictures/$bg

#!/bin/sh


# Get X and Y coordinates from command line arguments
mouse_coords=$(xdotool getmouselocation --shell)

#Extract X and Y coordinates
x_coord=$(echo "$mouse_coords" | grep "X" | cut -d "=" -f 2)
y_coord=$(echo "$mouse_coords" | grep "Y" | cut -d "=" -f 2)

# Move the active window to the specified coordinates
xdotool getactivewindow windowmove "$x_coord" "$y_coord"


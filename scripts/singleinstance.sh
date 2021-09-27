#!/usr/bin/env bash

pid=$(pgrep "$1" | head -n 1)
if [ -z "$pid" ]; then
   $1 &
else
   wid=$(xdotool search --pid "$pid" 2>/dev/null | head -n 1)
   if [ "$wid" ]; then
   awid=$(xdotool getactivewindow)
    if [ "$wid" == "$awid" ]; then
      xdotool windowminimize "$wid"
     else
        xdotool windowactivate "$wid"
     fi
   fi
fi

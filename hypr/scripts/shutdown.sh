#!/usr/bin/env dash
if hyprshutdown -t 'Shutting down...' --no-exit; then
  systemctl poweroff
fi

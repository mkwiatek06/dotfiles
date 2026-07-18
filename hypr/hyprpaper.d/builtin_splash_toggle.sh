rand=$(od -An -N1 -tu1 /dev/urandom | tr -d ' ')
rand=$((rand % 2))

if [ "$rand" -eq 0 ]; then
  FILE="off.conf"
else
  FILE="on.conf"
fi

ln -f $XDG_CONFIG_HOME/hypr/hyprpaper.d/toggle/$FILE $XDG_CONFIG_HOME/hypr/hyprpaper.d/splash.conf

#!/bin/sh
#2015 - Whistle Master

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/sd/lib:/sd/usr/lib
export PATH=$PATH:/sd/usr/bin:/sd/usr/sbin

[[ -f /tmp/ngrep.progress ]] && {
  exit 0
}

touch /tmp/ngrep.progress

if [ "$1" = "install" ]; then
  if [ "$2" = "internal" ]; then
	   opkg update
     opkg install ngrep
  elif [ "$2" = "sd" ]; then
    opkg update
    opkg install ngrep --dest sd
  fi

  touch /etc/config/ngrep
  echo "config ngrep 'module'" > /etc/config/ngrep

  uci set ngrep.module.installed=1
  uci commit ngrep.module.installed

elif [ "$1" = "remove" ]; then
    opkg remove ngrep
    rm -rf /etc/config/ngrep
fi

rm /tmp/ngrep.progress

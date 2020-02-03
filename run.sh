#!/bin/sh

#   Copyright (C) 2016 Deepin, Inc.
#
#   Author:     Li LongYu <lilongyu@linuxdeepin.com>
#               Peng Hao <penghao@linuxdeepin.com>

BOTTLENAME="Deepin-TIM"
APPVER="2.0.0deepin4"

### method 2 for kde, unrecommended: if the method 1 didn't work,'sudo pacman -S gnome-settings-daemon' and  uncomment bellow 2 line to enable it.
#/usr/lib/gsd-xsettings &
#/opt/deepinwine/tools/run.sh $BOTTLENAME $APPVER "$1" "$2" "$3"

### method 1 for kde, recommended: (uncomment this if you choose method 2.)
env WINEPREFIX="$HOME/.deepinwine/Deepin-TIM" wine "c:\\Program Files\\Tencent\\TIM\\Bin\\TIM.exe"

#!/bin/bash
echo "Starting basic scripts ..."
sudo sh `ls | grep __` | echo "Failed.Please check scripts." &&
echo "Done."
sudo pacman -S --noconfirm `cat app.list` | echo "Failed at app.list, please check." &&
echo "Done all."

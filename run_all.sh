#!/bin/bash
echo "Start running pacman_init script ...";
sudo pacman-mirrors -g &&
echo "Selected fastest mirrors." ;
sudo echo "[archlinuxcn]" >> /etc/pacman.conf &&
sudo echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf &&
sudo echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf &&
echo "added archlinuxcn_tuna to /etc/pacman.conf ";
sudo sed -i "1iServer = https://mirrors.scau.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist &&
echo "added SCAU mirrors(archlinuxcn) to mirrorlist.";
echo "updating database...";
sudo pacman -Syy &&
echo "installing archlinuxcn-keyring and yaourt ...";
sudo pacman -S --noconfirm archlinuxcn-keyring yaourt &&
sudo mkdir /opt/pamac-build/ && sudo chmod 777  /opt/pamac-build/;
echo "exiting pacman_init script ...";

echo "installing wqy-zenhei wqy-microhei ..."
sudo pacman -S --noconfirm wqy-zenhei wqy-microhei &&
echo "done."

echo "installing sogoupinyin ...";
sudo pacman -S --noconfirm qtwebkit-bin &&
sudo pacman -S --noconfirm fcitx-gtk3 fcitx-qt4 fcitx-qt5 fcitx-sogoupinyin &&
echo "setuping sogoupinyin ...";
echo "export LC_ALL=zh_CN.UTF-8" >> ~/.xprofile
echo "export GTK_IM_MODULE=fcitx" >> ~/.xprofile
echo "export QT_IM_MODULE=fcitx" >> ~/.xprofile
echo "export XMODIFIERS=@im=fcitx" >> ~/.xprofile
echo "done. exiting sogoupinyin script...";

echo "installing wps ..."
sudo pacman -S --noconfirm wps-office bash-completion code lzop &&
echo "done."

echo "start installing qq-office and wechat ..."
sudo pacman -S --noconfirm deepin-wine-wechat &&
echo "wechat installed."
sudo pacman -S --noconfirm deepin-wine-tim &&
echo "TIM installed."
echo "exiting script ..."

echo "setuping tftpd...";
sudo pacman -S --noconfirm tftpd-hpa &&
sudo echo "tftpd:ALL" >> /etc/hosts.allow &&
sudo echo "in.tftpd:ALL" >> /etc/hosts.allow &&


echo "setuping nfs...";
sudo mkdir /srv/nfs4
sudo echo "\n/srv/nfs4 *(rw,sync,nohide)" >> /etc/exports &&
sudo exportfs -arv &&

echo "exiting tftp-nfs script ...";

sudo pacman -S --noconfirm `cat app.list` | echo "Failed at app.list, please check." &&
echo "Done all."
echo "If you wanna run tftpd and nfs-server automatically after boot, \
enable them yourself by means of:\n \
systemctl enable tftpd.service\n \
systemctl enable nfs-server.service\n " ;

#!/bin/bash

install_fonts_cn() {
    echo "installing zn fonts ..."
    sudo pacman -S --noconfirm wqy-zenhei wqy-microhei-lite wqy-bitmapfont adobe-source-han-sans-cn-fonts \
     adobe-source-han-serif-cn-fonts noto-fonts-cjk wqy-microhei 1>>${the_top_dir}/manjaro_env_setup.log && \
      fc-cache -fv 1>>${the_top_dir}/manjaro_env_setup.log && locale-gen
    echo "done."
}

install_set_tftpd_nfs() {
    echo "setuping tftpd...";
    sudo pacman -S --noconfirm tftp-hpa 1>>${the_top_dir}/manjaro_env_setup.log &&
    sudo echo "tftpd:ALL" >> /etc/hosts.allow &&
    sudo echo "in.tftpd:ALL" >> /etc/hosts.allow &&


    echo "setuping nfs...";
    sudo mkdir -p /srv/nfs4
    sudo echo "/srv/nfs4 *(rw,sync,nohide)" >> /etc/exports &&
    sudo exportfs -arv &&
    #systemctl enable tftpd.service
    #systemctl enable nfs-server.service
    echo "exiting tftp-nfs script ...";
}

install_sogoupinyin() {

# KDM, GDM, LightDM 等显示管理器，请使用 ~/.xprofile 
# arch wiki 警告: 上述用户不要在~/.xinitrc中加入下述脚本，否则会造成无法登陆。
# 如果您用 startx 或者 Slim 启动，请使用~/.xinitrc 中加入
#   export GTK_IM_MODULE=fcitx 
#   export QT_IM_MODULE=fcitx 
#   export XMODIFIERS=@im=fcitx
#
# 如果你使用的是较新版本的GNOME，使用 Wayland 显示管理器，则请在/etc/environment 中加入
#   GTK_IM_MODULE=fcitx
#   QT_IM_MODULE=fcitx
#   XMODIFIERS=@im=fcitx"
#
    echo "installing sogoupinyin ...";
    #the_top_dir=${PWD}
    #myname=`w -h`; myname=${myname%% *};
    cd /home/$myname;
    ENV_PATH=

    set_env(){
    echo "setuping sogoupinyin ...";
    echo "export LC_ALL=zh_CN.UTF-8" >> $ENV_PATH
    echo "export GTK_IM_MODULE=fcitx" >> $ENV_PATH
    echo "export QT_IM_MODULE=fcitx" >> $ENV_PATH
    echo "export XMODIFIERS=@im=fcitx" >> $ENV_PATH
    }

    if [ $ENV = "xfce" ];
    then
        echo "xfce4: yes";
        sudo pacman -S --noconfirm qt5-webkit 1>>${the_top_dir}/manjaro_env_setup.log;
        sudo pacman -S --noconfirm fcitx-im fcitx-configtool fcitx-sogoupinyin fcitx-qt4 1>>${the_top_dir}/manjaro_env_setup.log;
        ENV_PATH=.xprofile;
        set_env
        echo "done."
    else
        echo "xfce: no.";
        
        if [ $ENV = "kde" ];
        then
            echo "kde: yes";
            sudo pacman -S --noconfirm kdewebkit fcitx-im kcm-fcitx fcitx-sogoupinyin fcitx-qt4  1>>${the_top_dir}/manjaro_env_setup.log &&
            ENV_PATH=.xprofile;set_env
            echo "done."
        else
	    if [ $ENV = "gnome" ];
	    then
            	echo "gnome: yes";
            	sudo pacman -S --noconfirm qt5-webkit 1>>${the_top_dir}/manjaro_env_setup.log;
            	sudo pacman -S --noconfirm fcitx-im fcitx-configtool fcitx-sogoupinyin fcitx-qt4 1>>${the_top_dir}/manjaro_env_setup.log;
            	ENV_PATH=/etc/environment
            	set_env
            	echo "done."
	    else
		echo "Your environment is not specified as xfce or kde or gnome. Skiped."
	    fi;
        fi;
    fi;

    cd - 1>>/dev/null;
}

install_qq_wechat() {
    #the_top_dir=${PWD}
    myname=`w -h`; myname=${myname%% *};
    
    echo "installing qq-office and deepin wechat(AUR required base-devel )"
    sudo pacman -S --noconfirm ncurses5-compat-libs deepin-file-manager 1>>manjaro_env_setup.log && 
    #`wechat -h 1>/dev/null` && echo "wechat installed." || echo "failed to install wechat."
    sudo pacman -S --noconfirm deepin.com.qq.office 1>>manjaro_env_setup.log  && echo "TIM installed." || echo "failed to install TIM."
    
    yay -S --noconfirm deepin-wine-wechat && sudo cp -f WeChat/* /opt/deepinwine/apps/Deepin-WeChat/ &&
    cd /home/$myname;
    ls .kde4 >/dev/null && sudo pacman -S --noconfirm gnome-settings-daemon && sudo sed -i "11ips -e |grep gsd-xsettings || /usr/lib/gsd-xsettings &" /opt/deepinwine/apps/Deepin-TIM/run.sh && sudo sed -i "93ips -e |grep gsd-xsettings || /usr/lib/gsd-xsettings &" /opt/deepinwine/apps/Deepin-WeChat/run.sh &&
    sudo sed -i 's/env WINEPREFIX/env GTK_IM_MODULE="fcitx" XMODIFIERS="@im=fcitx" QT_IM_MODULE="fcitx" WINEPREFIX/' /opt/deepinwine/apps/Deepin-WeChat/run.sh
    #find /home/$myname -name ".kde4" >/dev/null && sudo cp -b run.sh /opt/deepinwine/apps/Deepin-TIM/run.sh || echo "done."
    cd -;
    echo "exiting script ..."
}

install_bumblebee_nvidia() {
    sudo mhwd -a pci nonfree 0300 1>>${the_top_dir}/manjaro_env_setup.log || return
    sudo pacman -S --noconfirm linux-headers bumblebee bbswitch nvidia opencl-nvidia lib32-nvidia-utils lib32-opencl-nvidia mesa lib32-mesa-libgl xf86-video-intel  1>>${the_top_dir}/manjaro_env_setup.log &&
    sudo pacman -S --noconfirm virtualgl lib32-virtualgl lib32-primus primus 1>>${the_top_dir}/manjaro_env_setup.log &&
    sudo sed -i "s/PMMethod=auto/PMMethod=bbswitch/g" /etc/bumblebee/bumblebee.conf 
    sudo gpasswd -a $myname bumblebee
    sudo systemctl enable bumblebee
}

install_ruijie() {
    echo "Entering RJAP folder..."
    cd RJAP && ./install && cd -
    echo "done RJAP. Leaving..."
}

default() {
    install_sogoupinyin
    install_fonts_cn
    install_set_tftpd_nfs
}

everything() {
    install_sogoupinyin
    install_fonts_cn
    install_set_tftpd_nfs
    install_bumblebee_nvidia
    install_ruijie
}


############### ##########the script runs begin here ######################################################################

ENV=$1
# print usage
echo "usage: ./Setup [xfce][kde]gnome] [all][nvidia][ruijie] && ./Setup wechat"
echo "examples:"
echo "sudo ./Setup xfce && ./Setup wechat"
echo "sudo ./Setup xfce all && ./Setup wechat"
echo "sudo ./Setup xfce ruijie && ./Setup wechat"
read -p "Please check your input, if they're correct then enter 'Enter' to continue" tmp
if [ "$tmp" = "" ];then echo $tmp;else exit;fi

if [ "$1" = "wechat" ]
then
    install_qq_wechat;
    echo "option done. script end."
    exit;
fi

# check network
ping -c 1 114.114.114.114 > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo 网络正常;
else
    echo 网络连接异常;
    exit;
fi;

# set variables
the_top_dir=`pwd`
myname=`w -h`
myname=${myname%% *}

# add you to group uucp, then you can r/w USB device without sudo.
sudo gpasswd --add $myname uucp

# pacman init
echo "Start running pacman_init script ...";
sudo pacman-mirrors -c China -g 1>>${the_top_dir}/manjaro_env_setup.log &&
echo "Selected fastest mirrors." ;
sudo echo "[archlinuxcn]" >> /etc/pacman.conf &&
sudo echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf &&
sudo echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf &&
echo "added archlinuxcn_tuna to /etc/pacman.conf ";
sudo sed -i "1iServer = https://mirrors.scau.edu.cn/archlinux/\$repo/os/\$arch" /etc/pacman.d/mirrorlist &&
echo "added SCAU mirrors(archlinuxcn) to mirrorlist.";
echo "updating database...";
sudo pacman -Syyu --noconfirm 1>>${the_top_dir}/manjaro_env_setup.log &&
echo "installing archlinuxcn-keyring and yay ...";
sudo pacman -S --noconfirm archlinuxcn-keyring yay 1>>${the_top_dir}/manjaro_env_setup.log &&
echo "exiting pacman_init script ...";

echo "installing base-devel..."
sudo pacman -S --noconfirm base-devel 
echo "done. Go to next step... "

## read flag

if [ ! -n "$2" ]
then
    echo "run default..."
    default
else
    if [ "$2" = "all" ]
    then
        everything
    else
        if [ "$2" = "nvidia" ]
        then
            default; install_bumblebee_nvidia;
        else
            if [ "$2" = "ruijie" ]
            then
                default; install_ruijie;
            else
                echo "wrong input. exit."
            fi
        fi
    fi
fi

# install app from app.list
sudo pacman -S --noconfirm `cat app.list` 1>>${the_top_dir}/manjaro_env_setup.log &&

# done all:
echo "Done all."
echo "If you wanna run tftpd and nfs-server automatically after boot, enable them yourself by means of:
    systemctl enable tftpd.service
    systemctl enable nfs-server.service 
Now you can run ' ./Setup wechat ' to install deepin wine wechat and qq-office without 'sudo' !" ;

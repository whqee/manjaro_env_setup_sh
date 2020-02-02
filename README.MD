## 新装Manjaro 自动化安装软件及配置环境
最新这次的只测过kde。<br>
理论上xfce也没问题。gnome版请看注意事项。

##安装设置的事项有：

搜狗拼音、中文字体、tftpd、微信和qq、n卡驱动（bumblebee）、锐捷客户端(SCAU)、AP(热点)、
app.list里列出的软件<br>

##食用：<br>
‘sudo ./Setup’： 默认。除了锐捷和n卡驱动。<br>
‘sudo ./Setup all’： 安装全部。<br>
‘sudo ./Setup nvidia’： 默认+n卡驱动。<br>
‘sudo ./Setup ruijie’： 默认+锐捷客户端(SCAU)。<br>


其中RJAP为设置锐捷客户端（SCAU）和AP热点的独立文件夹。非SCAU用户请自行更换里面的锐捷客户端。<br>
默认热点id：ee 密码ee123456

设置热点：set_ap_id_passwd {id} {passwd}<br>
设置锐捷：set_rj_id_passwd {id} {passwd}<br>
（若无效请使用绝对路径）

##注意事项：
安装搜狗输入法配置环境变量时候，不同显示管理器配置地方不同：<br>
KDM, GDM, LightDM 等显示管理器，请使用 ~/.xprofile 

arch wiki 警告: 上述用户不要在~/.xinitrc中加入下述脚本，否则会造成无法登陆。<br>
如果您用 startx 或者 Slim 启动，请使用~/.xinitrc 中加入<br>
  export GTK_IM_MODULE=fcitx <br>
  export QT_IM_MODULE=fcitx <br>
  export XMODIFIERS=@im=fcitx<br>

如果你使用的是较新版本的GNOME，使用 Wayland 显示管理器，则请在/etc/environment 中加入<br>
  GTK_IM_MODULE=fcitx<br>
  QT_IM_MODULE=fcitx<br>
  XMODIFIERS=@im=fcitx"<br>

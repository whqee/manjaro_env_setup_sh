新装电脑只需 ./Setup.sh ，默认设置全部内容，不需要的请自行修改Setup.sh，内容一目了然。
（为了提高sudo pacman-mirrors -g的速度，建议先打开软件包管理器，选择软件仓库镜像区为 ‘中国’）

Setup.sh里啥都有，建议使用前先阅读。没事别乱更archlinuxcn源的软件。
其中deepin-wine-tim需要5.0+内核才能保存密码并自动登录

其中RJAP为设置锐捷客户端和AP热点，锐捷客户端为SCAU锐捷客户端。
默认热点id：ee 密码ee123456

设置热点：set_ap_id_passwd {id} {passwd}
设置锐捷：set_rj_id_passwd {id} {passwd}

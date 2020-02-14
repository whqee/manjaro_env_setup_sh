## 新装Manjaro 自动化安装软件及配置环境，装完即用。
最新这次的只测过kde。<br>
gnome版暂未测过，理论上都没问题。<br>

因为新版2.8微信在deepinwine不能正常使用，回退了2.6版本，所以里面包含了个2.6的微信安装包，约42.7M，从https://gitee.com/whqee/manjaro_env_setup_sh.git下载或许更快。

##安装设置的事项有： (自动设置China源、自动挑选最快的3个源，兼顾华南地区用户，加入了SCAU源)

搜狗拼音、中文字体、tftpd(nfs-server自带)、微信和qq、n卡驱动（bumblebee）、锐捷客户端(SCAU)、AP(热点)、
app.list里列出的软件<br>

##食用：<br>
‘sudo ./Setup’： 默认。除了锐捷和n卡驱动。<br>
‘sudo ./Setup all’： 安装全部。<br>
#‘sudo ./Setup nvidia’： 默认+n卡驱动。(发现设置里装更好。暂弃。脚本可参考。)<br>
‘sudo ./Setup ruijie’： 默认+锐捷客户端(SCAU)。<br>

---n卡驱动，暂请自行安装。设置里装不了的话，可以参考里面脚本和https://www.v2ex.com/t/630119, https://github.com/dglt1/optimus-switch-sddm，到https://www.nvidia.cn/Download/index.aspx?lang=cn下载驱动，手动安装。5.6内核暂无headers，编译不了内核，别去折腾了，浪费时间，还是乖乖用推荐的LTS内核吧

---装完都可以直接用。不过微信和TIM没调，不能用摄像头。观察了段时间，TIM、netease挂后台占CPU3-7%间波动，微信后台基本不占CPU。app.list里加了腾讯官方的qq-linux，可以正常使用，平均占CPU 1%。

---手机安装KDE Connect，很香。

---其中RJAP为设置锐捷客户端（SCAU）和AP热点的独立文件夹。非SCAU用户请自行更换里面的锐捷客户端。<br>
默认热点id：ee 密码ee123456

设置热点：set_ap_id_passwd {id} {passwd}<br>
设置锐捷：set_rj_id_passwd {id} {passwd}<br>
（若无效请使用绝对路径）

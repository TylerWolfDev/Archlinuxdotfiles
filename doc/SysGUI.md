GUI
===

### **安装显卡驱动**
    # pacman –S nvidia 
    # pacman –S bumblebee 
    # gpasswd -a <user> bumblebee 
    # systemctl enable bumblebeed.service 

### **BBSwitch**


安装了bumblebee以后，是可以开机了，但是发现：

    # lspci |grep "VGA\|3D"
    00:02.0 VGA compatible controller: Intel Corporation HD Graphics 530 (rev 06)
    01:00.0 3D controller: NVIDIA Corporation GM107M [GeForce GTX 950M] (rev a2)

也就是N卡在不用的状态下仍然是开启的，通过查Wiki知道了安装bbswitch可以解决这个问题,但是安装重启后出现死机。

解决方案，编辑 /etc/default/grub 并且在此行 GRUB_CMDLINE_LINUX_DEFAULT 后添加 acpi_osi=! acpi_osi="Windows 2009" , 即为（注意单引号） :

    GRUB_CMDLINE_LINUX_DEFAULT='quiet splash acpi_osi=! acpi_osi="Windows 2009"' 
然后通过下面的语句重新自动生成 grub.cfg ：

    # grub-mkconfig -o /boot/grub/grub.cfg

Wiki上面说Bumblebee自动调用bbswitch，但是发现并不是这回事。后又参考nvidia-xrun的Wiki页面得到：

在启动时载入bbswitch模块

    # echo 'bbswitch ' > /etc/modules-load.d/bbswitch.conf


关闭nvidia显卡的选项

     # echo 'options bbswitch load_state=0 unload_state=1' > /etc/modprobe.d/bbswitch.conf 

将nvidia相关模块加入黑名单

     $ lsmod | grep nvidia | cut -d ' ' -f 1 > /tmp/nvidia
     $ lsmod | grep  nouveau | cut -d ' ' -f 1 >> /tmp/nvidia
     $ sort -n /tmp/nvidia | uniq >  /tmp/nvidia.conf  #去重
     $ sed -i 's/^\w*$/blacklist &/g' /tmp/nvidia.conf  #添加blacklist
     # cp /tmp/nvidia.conf /etc/modprobe.d/nvidia.conf  #移动


更多的细节：
Lockup issue (lspci hangs) -ArchWiki

Laptop freezes when starting X11 and discrete graphics are OFF · Issue #764 · Bumblebee-Project/Bumblebee · GitHub

nvidia-xrun - ArchWiki



### **tlp**

为了完成 TLP 的安装，必须启用 systemd 服务tl.service以及tlp-sleep.service。您也应该屏蔽 systemd 服务systemd-rfkill.service 以及套接字 systemd-rfkill.socket 来防止冲突，保证 TLP 无线设备的开关选项可以正确运行。即为，

    # sudo systemctl enable tl.service
    # sudo systemctl enable tlp-sleep.service
    # sudo systemctl mask systemd-rfkill.service
    # sudo systemctl mask systemd-rfkill.socket


如果您与NVIDIA驱动一同运行Bumblebee，您需要关闭TLP对GPU的电源管理以使Bumblebee控制GPU的电源。

运行lspci确定GPU的地址（以01:00.0为例），然后设置值（配置文件/etc/default/tlp）：

    RUNTIME_PM_BLACKLIST="01:00.0"

安装完成之后，第一次需要手动启动 tlp。TLP 会在下次启动系统时自动运行。

    # sudo tlp start




### **WM**
    $ pacman -S xorg-xinit i3-gaps rofi

### **Touchpad**

采用libinput+libinput-gestures。

修改libinput配置文件

    # sudo cp /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf

修改touchpad部分文件。

    Section "InputClass"
            Identifier "libinput touchpad catchall"
            MatchIsTouchpad "on"
            MatchDevicePath "/dev/input/event*"
        Driver "libinput"
            Option "Tapping" "on"
            Option "ButtonMapping" "1 3 0 4 5 6 7"
            Option "TappingButtonMap" "lmr"
            Option "DisableWhileTyping" "on"
            Option "TappingDrag" "on"
    EndSection


安装libinput-gestures

    # sudo gpasswd -a $USER input
    # yaourt -S libinput-gestures
    # libinput-gestures-setup autostart

对libinput-gestures进行配置

    # cp /etc/libinput-gestures.conf ~/.config/libinput-gestures.conf
    # nano ~/.config/libinput-gestures.conf

添加以下内容

    gesture swipe left 4 xdotool key ctrl+shift+Tab    
    gesture swipe right 4 xdotool key ctrl+Tab
    gesture swipe down 4 xdotool key F5    
    gesture swipe left 3 xdotool key alt+Left
    gesture swipe right 3 xdotool key alt+Right 
    gesture swipe up 3 xdotool key ctrl+t
    gesture swipe down 3 xdotool key ctrl+w 
    gesture pinch in 2 xdotool key ctrl+minus    
    gesture pinch out 2 xdotool key ctrl+plus 





ALSA 是Linux内核组件，推荐使用。只需要解除静音（使用m键）,安装alsa-utils软件包，它包含了alsamixer)工具，然后按照此文进行设置即可。

桌面上为i3blocks的一个脚本。


### **输入法设置**
安裝fcitx-im, fcitx-configtool, fcitx-rime(搜狗拼音占用內存较高)。

添加以下語句到 ~/.xprofile

    export GTK_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export QT_IM_MODULE=fcitx

安裝 fcitx-skin-material
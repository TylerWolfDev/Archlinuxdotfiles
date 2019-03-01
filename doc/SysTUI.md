TUI
===

## 安裝準備

### **联网**

    $ wifi-menu 
    $ ping baidu.com 


### **更新系统时间**

    $ timedatectl set-ntp true 


### **建立硬盘分区**

    $ cfdisk 
    $#主要建立/和/home 


### **格式化分区**

    $ mkfs.ext4 /dev/sda2 


### **挂载分区**

如果使用多个分区，还需要为其他分区创建目录并挂载它们,注意顺序

    $ mount /dev/sda2 /mnt    # 挂载根目录 
    $ mkdir /mnt/home    # 创建 /home 挂载点 
    $ mount /dev/sda3 /mnt/home    # 挂载 /home 
    $ mkdir -p /mnt/boot/EFI    # 创建 UEFI 挂载点 
    $ mount /dev/sda1 /mnt/boot/EFI    # 挂载 UEFI 分区 
    $ mkswap /dev/sda8 
    $ swapon /dev/sda8 



## 安裝系統

### **选择镜像**

pacman 优先使用位置靠前的镜像地址。将选定的镜像地址置于最前以便 pacman 使用。

    $ nano /etc/pacman.d/mirrorlist 


### **更新本地数据库**

    $ pacman -Syy 

### **安装系统**
    $ pacstrap -i /mnt base base-devel 


## 配置系統
### **Fstab**

用以下命令生成 fstab 文件

    $ genfstab -U /mnt >> /mnt/etc/fstab 

（重要）检查生成的 fstab 正确是否：

    $ cat <根目录挂载点>/etc/fstab 

不能多次执行 genfstab，应该编辑 fstab 修正错误。


### **Chroot**

    $ arch-chroot /mnt 


### **时区**

设置 时区:

    $ ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

建议设置时间标准 为 UTC，并调整 时间漂移，運行 hwclock 來生成 /etc/adjtime:

    $ hwclock --systohc --utc 


### **Locale**

本地化的程序与库若要本地化文本，都依赖 Locale, 后者明确规定地域、货币、时区日期的格式、字符排列方式和其他地化标准等等。在下面两个文件设置：locale.gen 与 locale.conf. /etc/locale.gen是一个仅包含注释文档的文本文件。指定您需要的本地化类型，只需移除对应行前面的注释符号（＃）即可，建议选择帶UTF-8的項：

    $ nano /etc/locale.gen 
    $ locale-gen 
    $ echo LANG=en_US.UTF-8 > /etc/locale.conf 


### **主机名**

要设置 hostname，将其添加 到 /etc/hostname, myhostname 是需要的主机名:

    $ echo myhostname > /etc/hostname 

### **Root 密码**
设置 root 密码:
    $ passwd 

### **用户管理**

    $ pacman -S zsh 
    $ chsh -s /bin/zsh  #设置zsh为默认shell 
    $ useradd -m -g users -G wheel -s /bin/zsh archie 
    $ passwd <user>   # 设置密码 






### **Grub**

UEFI：

    $ pacman -S dosfstools grub efibootmgr 
    $ grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=arch_grub --recheck 
    $ grub-mkconfig -o /boot/grub/grub.cfg 



### **Microcode**

安装intel-ucode

    # pacman -S intel-ucode

运行下面命令就可以重新生成配置文件启用微指令更新。

    # grub-mkconfig -o /boot/grub/grub.cfg

### **重启**

    $ exit    # 退回安装环境 
    $ umount -R /mnt 
    $ reboot    # 重启 

记得移除安装介质





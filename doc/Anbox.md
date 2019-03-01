
# 想在 Archlinux 上運行安卓程序

[Anbox](http://anbox.io)(Android in a box) 是一个在 LXC 容器中运行完整 Andoird 的项目。这是一篇在 ArchLinux 上安装使用 Anbox 的踩坑笔记。

### 安装

安装 [AUR/anbox-git](https://aur.archlinux.org/pkgbase/anbox-git/)、[AUR/anbox-modules-dkms-git](https://aur.archlinux.org/packages/anbox-modules-dkms-git/)、[AUR/anbox-image](https://aur.archlinux.org/packages/anbox-image) 及其依赖。 也可以在 <https://build.kasei.im/> 下载作者编译的二进制包。

### Anbox container manager

```shell
sudo systemctl start anbox-container-manager.service
```

1. Anbox 利用 lxc 管理容器，所以首先确保你的 lxc 能够使用。可以利用 lxc-checkconfig 命令检查。
2. lxc 配置文件在 /var/lib/anbox/containers/default/config。
3. lxc 日志在 /var/lib/anbox/logs/container.log。

### 网络配置

感谢 [zhsj](https://zhsj.me/) 老师的提示。Anbox 依赖网桥 anboxbr0 联网。在原始的 snap 发行版本中依赖一个脚本 [anbox-bridge.sh](https://github.com/anbox/anbox/blob/master/scripts/anbox-bridge.sh) 进行配置。AUR/anbox-git 没有打包这个脚本。可以在 Arch 上使用这个脚本，也可以手动配置。如果使用上游的配置脚本，dnsmasq 的部分会出问题，可以删除脚本中的相应部分，随后手动配置 DHCP。

### Anbox session manager

```shell
systemctl --user restart anbox-session-manager.service
# 如需查看调试信息
ANBOX_LOG_LEVEL=debug anbox session-manager
```

1. 作者在 HD4000/i5-3230m(mesa 17.0.3) 上无法启动，但在 GT740M(nvidia 378.13) 上可以使用。怀疑与 GL 版本有关。

   ```shell
   # HD4000/i5-3230m(mesa 17.0.3)
   OpenGL core profile version string: 3.3 (Core Profile) Mesa 17.0.3
   OpenGL core profile shading language version string: 3.30
   OpenGL ES profile version string: OpenGL ES 3.0 Mesa 17.0.3
   OpenGL ES profile shading language version string: OpenGL ES GLSL ES 3.00
   # GT740M(nvidia 378.13)
   OpenGL core profile version string: 4.5.0 NVIDIA 378.13
   OpenGL core profile shading language version string: 4.50 NVIDIA
   OpenGL ES profile version string: OpenGL ES 3.2 NVIDIA 378.13
   OpenGL ES profile shading language version string: OpenGL ES GLSL ES 3.20
   ```

2. 有人称加上 –gles-driver=host 可以解决一些问题。Anbox 在 nvidia 上会强制使用这个参数。

### 开始使用

```shell
anbox launch --package=org.anbox.appmgr --component=org.anbox.appmgr.AppViewActivity
```





- refences
    - https://forum.manjaro.org/t/running-android-applications-on-arch-using-anbox/53332
    - https://kasei.im/2017/04/anbox-on-archlinux.html
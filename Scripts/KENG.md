# 问题列表

#### "ps -ax|grep xxx" 中因 grep 本身程序出现的进程号。
出现位置： ~/.Scripts/DSDSS.sh
解决方案： 具体原因具体对待，以后需要寻找更加科学的方法了。由于是 grep 自己的原因，所以再加一个 "grep -v grep"

#### 字符串的比较
实例： ~/.Scripts/DSfani.sh
    mean=`ydcv ${word}` 
    if [ "$mean" = "$condition" ]
发现并不能比较 

#### shell 脚本中的管道运用
实例： ~/.Scripts/DSfani.sh
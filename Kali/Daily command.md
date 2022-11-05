## `ls` command
which means to list the contents of the current directory

    ls -l       \\show file details
    ls -a       \\show hidden folders
    ls -lh      \\Human-readable display
    —sort=size  \\sort by size
    —sort=time  \\sort by time
    pwd         \\view the current directory name

## `cd` command
Indicates entering the current directory

    cd.         \\enter the current directory
    cd..        \\return to the upper directory

## `cat` command
means to view the contents of the file

    cat /etc/resolv.conf    \\view DNS configuration files
    more                    \\view more file content
    less                    \\view file contents without showing hidden files
    tail -20                \\view the latest 20 lines of the file
    watch -n 2 tail -20     \\view the latest content of the file every 2 seconds
`watch`command is a real-time monitoring tool

## `rm` command

    rm -r       \\delete folder
    rm          \\delete file
    
## `cp` command
    cp -r       \\copy folder
    cp          \\copy file
    
## `top` command
Generally used for process management

      k：[number]            \\kill process PID
      kill [number]          \\kill process PID
      ps -ef                 \\View process details
      ps aux                 \\Another way to display process information
      
6）grep [关键字] [地址]在指定路径查找文件
7）ifconfig查看网卡信息
      ifconfig [网卡名称] down关闭网卡
      ifconfig [网卡名称] up打开网卡
      macchanger -m [六位地址] [网卡名称]
      临时修改网卡地址，关闭下进行
      iwconfig查看网卡链接状态
      ping [地址]查看链接状态
8）netstat pantu查看tcp链接
9）｜管道
netstat -pantu｜egrep -v’关键字|关键字’
查看链接不包含‘关键字’以及‘关键字’内容
｜awk‘{print $5}’｜cut -d ‘:’ -f｜sort｜uniq
或者只显示第5列以及分块面：前内容并排序查重>[文件名]输出文件为文件名
—————————————————
命令｜命令=》顺序执行命令
命令&命令=》依次执行命令
命令｜｜命令=》左命令不成功执行右命令,反之
命令&&命令=》左命令成功执行右命令，反之
—————————————————
10）mount挂载
        mount -o loop [iso镜像] [地址]
11）dmesg 查看系统message文件
12）find /-name [名称]查找文件
        find. -name“关键字” —exec cp
        查找当前目录关键字文件执行拷贝
        whereis [文件名]数据库查找文件名文件
        whereis -b [文件名]数据库查找bat文件
        updatedb更新数据库
13）echo“你好！银翼杀手！”终端显示

15）shell脚本编写：
️vi 文件名.sh（进入）
️#！/bin/bash（必须调用脚本包头）
️chmod +x 文件名.sh（赋予脚本权限）
️ls -l 文件名.sh（查看脚本root权限）
️./ 文件名.sh（执行脚本）

[back to Kali](https://github.com/pro1tocol/Linux-Novice-Function-1.0.1/tree/main/Kali)

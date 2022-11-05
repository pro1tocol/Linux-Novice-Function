## `ls` command
which means to list the contents of the current directory

    ls -l       \\show file details
    ls -a       \\show hidden folders
    ls -lh      \\Human-readable display
    —sort=size  \\Sort by size
    —sort=time  \\Sort by time
    pwd         \\View the current directory name

## `cd` command
Indicates entering the current directory

    cd.         \\enter the current directory
    cd..        \\Return to the upper directory

3）cat查看文件内容
      cat /etc/resolv.conf查看DNS配置文件
      more查看更多文件内容
      less查看文件内容但不显示隐藏文件
      tail -20查看文件最新20行内容
      watch -n 2 tail -20每2秒查看文件最新内容
4）rm删除文件
      rm -r删除文件夹
      cp拷贝文件
      cp -r拷贝文件夹
5）top命令：进程管理
      输入k：杀掉进程PID
      ps -ef查看进程详细信息
      ps aux另种方式显示进程信息
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
14）vim使用：
：set nu添加行号                      o插入行
：wq保存                                   w复制
：q不保存退出                          p粘贴
：wq！强制保存退出
15）shell脚本编写：
️vi 文件名.sh（进入）
️#！/bin/bash（必须调用脚本包头）
️chmod +x 文件名.sh（赋予脚本权限）
️ls -l 文件名.sh（查看脚本root权限）
️./ 文件名.sh（执行脚本）

[back to Kali](https://github.com/pro1tocol/Linux-Novice-Function-1.0.1/tree/main/Kali)

1、ip在线状态
#!/bin/bash
for ip in `seq 1 255`
do
	{
	ping -c 1 192.168.1.$ip > /dev/null 2>&1
	if [ $? -eq 0 ] 
	then
	echo "192.168.1.$ip is up"
	else
	echo "192.168.1.$ip is down"
	done
	}&
done
wait
2、批量添加20个用户属于class组
#!/bin/bash
groupadd class
for i in `seq 1 20`
do
	useradd -g class -s /sbin/nologin std$i
done
3、随机数
echo $[RANDOM%10+1] //生成1-10的随机数
echo $RANDOM|md5sum|cut -c 1-32 //生成32位的随机字符串
4、
1. 主：binlog线程——记录下所有改变了数据库数据的语句，放进master上的binlog中；

2. 从：io线程——在使用start slave 之后，负责从master上拉取 binlog 内容，放进 自己的relay log中；

3. 从：sql执行线程——执行relay log中的语句；
5、从文件中读取
#!/bin/bash
#reading data from a file
count=1
cat test|while read line
do
	echo "Line $count: $line"
	count=$[ $count + 1 ]
done
echo "Finished processing the file"
6、电子表格插入数据库
#!/bin/bash
#read file and create INSERt statements for MYSQL
outfile='members.sql'
IFS=','
while read lname fname address city state zip
do
	cat >> $outfile << EOF
	INSERT INTO members (lname,fname,address,city,state,zip) VALUES ('$lname','$fname','$address','$city','$state','$zip');
EOF
done < ${1}
$
7、要加到开机启动脚本/etc/rc.local里	添加开机启动服务
	/etc/init.d		添加系统服务
	/etc/profile	添加环境变量
8、你认为在系统调优方面都包括那些工作，以Linux为例，请简明阐述，并举一些参数为例。
答案：
Linux系统调优可以通过这几个方面来做，比如文件系统优化（分区调优，格式化时根据存储文件特性，指定合适的块大小，noatime，日志隔离，软raid，有效使用/dev/shm，关闭不必要的服务）、内核参数优化（net.ipv4.tcp_syncookies = 1， net.ipv4.tcp_max_tw_buckets = 65535， net.ipv4 .tcp_tw_recycle = 1， net.ipv4.tcp_tw_r = 1）
9、nginx切割日志脚本
#! /bin/bash
## 假设nginx的日志存放路径为/data/logs/
d=`date -d "-1 day" +%Y%m%d` 
logdir="/data/logs"
nginx_pid="/usr/local/nginx/logs/nginx.pid"
cd $logdir
for log in `ls *.log`
do
    mv $log $log-$d
done
/bin/kill -HUP `cat $nginx_pid`
	写完脚本，添加任务计划
	0 0 * * * /bin/bash /usr/local/sbin/nginx_log_rotate.sh
	
10、
每个被chkconfig 管理的服务需要在对应的init.d 下的脚本加上两行或者更多行的注释。 
第一行告诉 chkconfig 缺省启动的运行级以及启动和停止的优先级。如果某服务缺省不在任何运行级启动，那么使用 - 代替运行级。 
第二行对服务进行描述，可以用 跨行注释。 


三.好,开始正题。自己写个脚本（只是演示，所以超简单！）

[root@VM_48_191_centos ~]# cat 1.sh 

#运行这个脚本，不管是否有123.txt，都会创建它并且向里面以累加的方式写入1

#!/bin/bash

#

#description: a demo          对这个脚本的描述，实际没什么意义

#chkconfig:2345 88 77         在2345级别下会去找S881.sh这个文件，在通过软链接，到达/etc/init.d/1.sh启动这个服务，在016级别下以K771.sh这个文件，在通过软链接到/etc/init.d/1.sh关闭这个“服务，所以说这个88和77其实可以随意写，即使两个脚本写一样的88和77也不会冲突，因为到rc2.d下它的命名规则都是启动（S881.sh）或者停止（K771.sh），脚本名唯一，那么就不冲突。

echo "1" >> /root/123.txt





把这个脚本赋予权限并且copy到/etc/init.d下：

chmod a+x 1.sh 

cp 1.sh  /etc/init.d/

添加到系统服务：

chkconfig --add 1.sh



然后执行下：

[root@VM_48_191_centos ~]# service 1.sh start
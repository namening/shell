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



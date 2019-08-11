MySQL5.7.27安装

一、下载
https://dev.mysql.com/downloads/mysql/5.7.html#downloads
按照自己电脑位数下载相应安装包


二、安装

1. 解压到想要安装的目录

		例如我解压到如下位置 E:\mysql-5.7.27

2. 新建一个my.ini 。位置与bin目录同级。

	编辑该my.ini文件并输入以下内容：

		[client]

		port=8888
		[mysql]
		default-character-set=utf8
		[mysqld]
		#skip-grant-tables
		port=8888
		bind-address=0.0.0.0
		character-set-server=gbk
		#解压目录
		basedir=E:\mysql-5.7.27
		#解压目录下data目录
		datadir=E:\mysql-5.7.27\data
		default-storage-engine=INNODB
		#sql-mode="STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
		sql-mode="STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION"
		max_connections=120
		query_cache_size=16M
		tmp_table_size=45M
		thread_cache_size=8
		myisam_max_sort_file_size=100G
		myisam_sort_buffer_size=64M
		key_buffer_size=32M
		read_buffer_size=64K
		read_rnd_buffer_size=256K
		sort_buffer_size=256K
		innodb_flush_log_at_trx_commit=1
		innodb_log_buffer_size=3498K
		innodb_buffer_pool_size=400M
		innodb_log_file_size=175M
		innodb_thread_concurrency=8
		max_allowed_packet = 8M
		event_scheduler = on
		group_concat_max_len = 2048
		performance_schema = off
		innodb_file_per_table = 1
		server-id=1


3.配置环境变量

1）右键单击我的电脑->属性->高级系统设置(高级)->环境变量

      点击【系统变量】下的新建按钮

      输入变量名：MYSQL_HOME

      输入变量值：E:\mysql-5.7.27

      即为mysql的自定义解压目录【安装目录】。

2）选择系统变量中的Path

      点击编辑按钮

      在变量值中添加变量值：;%MYSQL_HOME%\bin

      注意是在原有变量值后面加上这个变量，用;隔开，不能删除原来的变量值[与java等配置类似]
	  
	  
4.以管理员身份运行cmd

5.在cmd进入mysql的安装路径，并输入mysqld -install
	
	这条命令含义是安装mysql服务。
	成功会提示"Service successfully installed"
	
	
6.检测服务界面中的mysql服务的路径

	当出现：启动Mysql后找不到服务或出现找不到指定文件。  错误信息是：windows无法启动mysql服务。
	
	解决方法是：
	* 主要服务的路径不正确，需要进入注册表cmd-->regedit-->HKEY_LOCAL_MACHINE-->SYSTEM-->CurrentControlSet-->services-->Mysql
	* 修改ImagePath为mysql所安装的路径下的mysqld即可

三、测试MySQL

1. cmd中继续输入mysqld --initialize --console初始化

2. 继续在cmd输入net start mysql，如果没有执行第一步骤会提示服务无法启动，并且错误码是3534
执行第一步骤服务启动成功。

3. 使用mysql -u root -p 进行登录

第一次登陆没有密码直接按回车，报：ERROR 1045:Access denied for user 'root'@localhost (use password:NO)

解决方法为：

（1）在my.ini文件，在[mysqld]下添加skip-grant-tables，保存退出，在服务界面中重新启动mysql服务 ;

（2）回到cmd，重新进入mysql，成功。

（3）再修改密码：

		use mysql ;

		update user set password=password('123456') where user='root';

或者

		update mysql.user set password=password('123456') where user='root';

发现命令执行报错，ERROR 1054 (42S22): Unknown column 'password' in 'field list'

原因：查看mysql.user表发现确实没有password字段，在mysql5.7.27 版本中密码字段应该是authentication_string，
所以修改密码方法是：
update mysql.user set authentication_string=password('123qwe') where user='root' and Host ='localhost';  


四：将skip-grant-tables注释掉

之前无密码登录是在my.ini文件[mysqld]下添加skip-grant-tables配置，才进行了密码登录，由于这个配置skip-grant-tables不应该存在my.ini中，应该注释掉。

重启mysql服务，使用mysql -u root -p 进行登录,进行任何操作的时候，都会提示：

如：
		
		mysql> show databases;
		ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.
		mysql> use test;
		ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.



原因分析：
这个主要是由一个参数控制的 default_password_lifetime，default_password_lifetime这个值在>=5.7.11版本默认值应该是0.

然后

	show variables like 'default_password_lifetime';
	+---------------------------+-------+
	| Variable_name             | Value |
	+---------------------------+-------+
	| default_password_lifetime | 360     |
	+---------------------------+-------+
	1 row in set (0.00 sec)
	--------------------- 


哈哈，这里这个值是360，使用

		alter user user() identified by "123456";

进行修改密码即可。

五：常用的几个命令

1： net stop mysql 含义是停止数据库服务，执行之后在服务界面服务已经被停止了。

	E:\mysql-5.7.27\bin>net stop mysql
	MySQL 服务正在停止..
	MySQL 服务已成功停止。
2： sc delete mysql，删除服务，执行之后在服务界面mysql服务就看不到了。
没事别闲的蛋疼这种执行命令，可以自己写个bat脚本执行。

六：他人使用Navicat不能访问Mysql的问题。

 当用Navicat配置远程连接Mysql数据库时遇到如下报错信息，
 报错信息 ：1130 - Host XXX is not allowed to connect to this MySQL server
 这是由于Mysql配置了不支持远程连接引起的。
 
 解决方案：
 (1)增加一条user='root' ,host='%'的语句。

 或者执行

		update user set host = '%' where user ='root';

将Host设置为通配符%
 
 我采用保留原始数据方式新增一条数据的方式：

		 delete from user where user ='root' and Host='%';
		 INSERT INTO user(`Host`, `User`, `Select_priv`, `Insert_priv`, `Update_priv`, `Delete_priv`, `Create_priv`, `Drop_priv`, `Reload_priv`, `Shutdown_priv`, `Process_priv`, `File_priv`, `Grant_priv`, `References_priv`, `Index_priv`, `Alter_priv`, `Show_db_priv`, `Super_priv`, `Create_tmp_table_priv`, `Lock_tables_priv`, `Execute_priv`, `Repl_slave_priv`, `Repl_client_priv`, `Create_view_priv`, `Show_view_priv`, `Create_routine_priv`, `Alter_routine_priv`, `Create_user_priv`, `Event_priv`, `Trigger_priv`, `Create_tablespace_priv`, `ssl_type`, `ssl_cipher`, `x509_issuer`, `x509_subject`, `max_questions`, `max_updates`, `max_connections`, `max_user_connections`, `plugin`, `authentication_string`, `password_expired`, `password_last_changed`, `password_lifetime`, `account_locked`) VALUES ('%', 'root', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', '', '', '', '', 0, 0, 0, 0, 'mysql_native_password', 0x2A43433730323639443135303845393845423737443243303830324433313243353938414630423333, 'N', '2019-7-23 14:49:37', NULL, 'N');

 我的INSERT INTO语句是用

		SELECT * from user where user ='root' and Host='localhost';

导出来的。

 (2)执行完之后，需要执行

		flush privileges; 
刷新权限生效。

 (3)别人使用navicat 成功就能连接至mysql。


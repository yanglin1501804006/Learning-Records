# Windows 下安装RabbitMQ服务器及基本配置 #

RabbitMQ是一个在AMQP协议标准基础上完整的，可复用的企业消息系统。它遵循Mozilla Public License开源协议，采用 Erlang 实现的工业级的消息队列(MQ)服务器，Rabbit MQ 是建立在Erlang OTP平台上。

安装RabbitMQ服务器必须首先安装 Erlang 运行环境。


<font color=#0099ff size=4 face="黑体">一：安装Erlang</font>

安装Erlang 时要注意安装的RabbityMQ 所依赖的Erlang版本，根据RabbitMQ的要求选择一个版本，这里我要安装的RabbitMQ的版本是 3.7.14 ，其实官方网站上3.7.7~3.7.14之间的版本，他们依赖的Erlang版本范围是20.3.x~21.3.x(这个范围参考官网https://www.rabbitmq.com/which-erlang.html说明)，这里我选择版本是OTP 21.3其[下载地址](https://www.cnblogs.com/ericli-ericli/p/5902270.html) 。下载Erlang安装包后直接安装就可以了。


设置ERLANG_HOME 环境变量

![image](https://github.com/yanglin1501804006/Learning-Records/blob/master/RabbitMQ/images/erlang.png)


	变量名      ERLANG_HOME
	
	变量值      E:\mall_software\erlang21.3\bin\erl.exe

我这里是默认安装所以Erlang的安装路径在 E:\mall_software\erlang21.3\bin\erl.exe

(图片中的变量值应该是E:\mall_software\erlang21.3\bin\erl.exe，我的那个图显示不了才这么截图)

	注意：如果之前安装了Erlang的其他版本，需要卸载后在进行重新安装和设置。


<font color=#0099ff size=4 face="黑体">二：安装RabbitMQ</font>

可以在RabbitMQ的官方网站下载最新版本的RabbitMQ服务器安装程序，[RabbitMQ下载地址](http://www.rabbitmq.com/install-windows.html)， 这里我下载的是官方推荐的最新版本rabbitmq-server-3.7.14.exe， 然后点击安装。

RabbitMQ安装好后是作为windows service 运行在后台。

![image](https://github.com/yanglin1501804006/Learning-Records/blob/master/RabbitMQ/images/rabbitmq_server.png)


设置RabbitMQ环境变量
windows7不能改变环境变量对话框的大小，这里就不截图啦。

	变量名    RABBITMQ_SERVER
	
	变量值    E:\mall_software\rabbitmq3.7.14\rabbitmq_server-3.7.14

然后在系统的path变量中添加

		%RABBITMQ_SERVER%\sbin;

这样就可以在windows administrator启动的CMD窗口操控RabbitMQ服务了。不需要每次都定位到：
E:\mall_software\rabbitmq3.7.14\rabbitmq_server-3.7.14\sbin>目录下了。


<font color=#0099ff size=4 face="黑体">三：安装 rabbitmq_management</font>

先用命令查看一下RabbtitMQ的所有插件：

	C:\Users\***> rabbitmq-plugins list
	Listing plugins with pattern ".*" ...
	 Configured: E = explicitly enabled; e = implicitly enabled
	 | Status: * = running on rabbit@your_username
	 |/
	[  ] rabbitmq_amqp1_0                  3.7.14
	[  ] rabbitmq_auth_backend_cache       3.7.14
	[  ] rabbitmq_auth_backend_http        3.7.14
	[  ] rabbitmq_auth_backend_ldap        3.7.14
	[  ] rabbitmq_auth_mechanism_ssl       3.7.14
	[  ] rabbitmq_consistent_hash_exchange 3.7.14
	[  ] rabbitmq_event_exchange           3.7.14
	[  ] rabbitmq_federation               3.7.14
	[  ] rabbitmq_federation_management    3.7.14
	[  ] rabbitmq_jms_topic_exchange       3.7.14
	[  ] rabbitmq_management               3.7.14
	[  ] rabbitmq_management_agent         3.7.14
	[  ] rabbitmq_mqtt                     3.7.14
	[  ] rabbitmq_peer_discovery_aws       3.7.14
	[  ] rabbitmq_peer_discovery_common    3.7.14
	[  ] rabbitmq_peer_discovery_consul    3.7.14
	[  ] rabbitmq_peer_discovery_etcd      3.7.14
	[  ] rabbitmq_peer_discovery_k8s       3.7.14
	[  ] rabbitmq_random_exchange          3.7.14
	[  ] rabbitmq_recent_history_exchange  3.7.14
	[  ] rabbitmq_sharding                 3.7.14
	[  ] rabbitmq_shovel                   3.7.14
	[  ] rabbitmq_shovel_management        3.7.14
	[  ] rabbitmq_stomp                    3.7.14
	[  ] rabbitmq_top                      3.7.14
	[  ] rabbitmq_tracing                  3.7.14
	[  ] rabbitmq_trust_store              3.7.14
	[  ] rabbitmq_web_dispatch             3.7.14
	[  ] rabbitmq_web_mqtt                 3.7.14
	[  ] rabbitmq_web_mqtt_examples        3.7.14
	[  ] rabbitmq_web_stomp                3.7.14
	[  ] rabbitmq_web_stomp_examples       3.7.14


然后用下列命令安装rabbitmq_management插件，这款插件是可以可视化的方式查看RabbitMQ 服务器实例的状态，以及操控RabbitMQ服务器。

	C:\Users\***>rabbitmq-plugins enable rabbitmq_management
	Enabling plugins on node rabbit@RC0006305:
	rabbitmq_management
	The following plugins have been configured:
	  rabbitmq_management
	  rabbitmq_management_agent
	  rabbitmq_web_dispatch
	Applying plugin configuration to rabbit@RC0006305...
	The following plugins have been enabled:
	  rabbitmq_management
	  rabbitmq_management_agent
	  rabbitmq_web_dispatch
	
	started 3 plugins.


看到这个就表示成功了。

现在我们在浏览器中输入 http://localhost:15672 可以看到一个登录界面：

![image](https://github.com/yanglin1501804006/Learning-Records/blob/master/RabbitMQ/images/rabbitmq_login.png)


	port = 15672 是rabbitmq的默认端口号

这里可以使用默认账号guest/guest登录。至于这里面的细节百度详情。

在浏览器中输入 http://localhost:15672/api/ 就可以看到 RabbitMQ Management HTTP API 文档。


<font color=#0099ff size=4 face="黑体">四：管理rabbitmq_management的用户</font>

命令

	rabbitmqctl list_users 

**1. 查看一下现rabbitmq_management注册用户**

	C:\Users\***>rabbitmqctl list_users
	Listing users ...
	user    tags
	guest   [administrator]

发现现在只有一个用户guest，并且它的tag是administrator.

**2. 那么在命令行下创建一个用户，创建用户的命令合是：**

	rabbitmqctl add_user [username] [password]

现在创建一个username=rabbit1 password=rabbit1的用户, 命令如下：

	rabbitmqctl add_user rabbit1 rabbit1

创建成功了：

	C:\Users\***>rabbitmqctl add_user rabbit1 rabbit1
	Adding user "rabbit1" ...

现在看下有多少用户，跑一下命令：

	C:\Users\***>rabbitmqctl list_users
	Listing users ...
	user    tags
	rabbit1 []
	guest   [administrator]

发现用户列表里多了一个用户 rabbit1,但是tag是空的。使用命令给rabbit设置tag，设置tag的命令格式：

	rabbitmqctl set_user_tags [tag1] [tag2] ...

一次可以给一个用户设置多个tag，也可以设置一个

	C:\Users\***>rabbitmqctl set_user_tags rabbit1 administrator none
	Setting tags for user "rabbit1" to [administrator, none] ...

现在rabbit1 有两个tag了一个是administrator ,一个是none 。

有5个tag可供选择，分别是：administrator ，monitoring，policymaker，management和none 有兴趣的同学可以到[这里](http://www.rabbitmq.com/management.html)了解各个tag的含义，其实这里的tag代表的是权限，administrator是最高权限，none表示不能访问，这里administrator和none的组合，权限应该是向高看齐，忽略none，用的是administrator的权限。我们用rabbit1/rabbit1 登录rabbitmq_management。

![image](https://github.com/yanglin1501804006/Learning-Records/blob/master/RabbitMQ/images/rabbitmq_management.png)


有了rabbitmq_management这个可视化插件，很多事情都可以在这个插件里干，包括创建用户，创建交换机（Exchange)和创建队列（Queque）。


该文就到此结束了，简单介绍了RabbitMQ安装和使用，要想使用rabbitmq_management插件的高级配置，可参考官网学习。
		






























































 
#windows下安装NodeJS和配置NPM#
  Node.js 是一个基于 Chrome V8 引擎的 JavaScript 运行环境。Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型，使其轻量又高效。 Node.js 的使用包管理器 npm来管理所有模块的安装、配置、删除等操作，使用起来非常方便，但是想要配置好npm的使用环境还是稍微有点复杂，下面跟着我一起来学习在windows系统上配置NodeJS和NPM吧.


<font color=#0099ff size=4 face="黑体">1:下载NodeJS</font>

下载一个LTS（长期支持版本）版本，比如

[https://nodejs.org/dist/v10.16.0/node-v10.16.0-x64.msi](长期支持版本)

[https://nodejs.org/dist/v8.9.4/node-v8.9.4-x64.msi](长期支持版本) 我这里安装的是这个版本。

老版本可以在[这里](https://nodejs.org/dist/)下载。


<font color=#0099ff size=4 face="黑体">2：安装</font>

安装到add to path的时候，点开那个add path选项前面的+号，我们看到，会主动把NodeJS和NPM这两个模块的命令路径添加到系统路径里，对于我们来说就非常方便了。下边默认安装即可。

<font color=#0099ff size=4 face="黑体">3：测试node和npm</font>

在CMD窗口依次输入如下命令可以相应版本号。

	C:\Users\yangl-**>node -v
	v8.9.4
	C:\Users\yangl-**>npm -v
	5.6.0

如果正确输出版本号，说明我们的NodeJS和NPM就安装好了。

<font color=#0099ff size=4 face="黑体">4：配置NodeJS和NPM</font>

 NPM安装的模块并不会安装到NodeJS的程序目录，会下载到C:\Users\yangl-**\目录下，如果不修改npm的模块安装目录，那么它默认情况下都会安装到这里，随着你测试开发各种不同的项目，安装的模块越来越多，那么这个文件夹的体积会越来越大。

* <font color="red" size=3 face="黑体">第一步</font>是修改NPM的缓存目录和全局目录路径，将对应的模块目录改到D盘nodejs的安装目录
  
		在本地安装目录E:\mall_software\nodejs8.9.4下创建两个目录，分别是node_cache和node_global，这是用来放安装过程的缓存文件以及最终的模块配置位置。

	配置完成后，执行下面这两个命令：

		npm config set prefix "E:\mall_software\nodejs8.9.4\node_global"

		npm config set cache "E:\mall_software\nodejs8.9.4\node_cache"

	命令含义是将npm的全局模块目录和缓存目录配置到我们刚才创建的那两个目录。

	然后我们打开cmd命令行界面，在使用命令安装刚才的cluster模块，命令如下：

		npm install cluster -g

	然后打开刚才创建的node_global目录，可以看到此时cluster目录就安装到这个目录底下了。

* <font color="red" size=3 face="黑体">第二步</font>是配置npm和nodejs的环境变量，这样nodejs才能正确地调用对应的模块

		NODE_PATH
		变量值填：E:\mall_software\nodejs8.9.4\node_modules\

	此时还需要修改一些nodejs默认的模块调用路径，因为模块的安装位置变了，如果nodejs的命令还到原来的位置去找，肯定是找不到安装的模块了。我们在环境变量窗口，选择Path，然后点击右下角的编辑，然后选择npm那个。点击右边的编辑，将其修改为：E:\mall_software\nodejs8.9.4\node_global\，配置保存即可。


<font color=#0099ff size=4 face="黑体">5：测试node和npm配置</font>

打开一个新的cmd窗口，先输入命令：

		node

进入nodejs的交互式命令控制台，然后输入：

	require('cluster')

	> require('cluster')
	EventEmitter {
	  domain:
	   Domain {
	     domain: null,
	     _events: { error: [Function: debugDomainError] },
	     _eventsCount: 1,
	     _maxListeners: undefined,
	     members: [] },
	  _events: {},
	  _eventsCount: 0,
	  _maxListeners: undefined,
	  isWorker: false,
	  isMaster: true,
	  Worker:
	   { [Function: Worker]
	     super_:
	      { [Function: EventEmitter]
	        EventEmitter: [Circular],
	        usingDomains: true,
	        defaultMaxListeners: [Getter/Setter],
	        init: [Function],
	        listenerCount: [Function] } },
	  workers: {},
	  settings: {},
	  SCHED_NONE: 1,
	  SCHED_RR: 2,
	  schedulingPolicy: 1,
	  setupMaster: [Function],
	  fork: [Function],
	  disconnect: [Function] }
	>

如果能正常输出cluster模块的信息，说明上面的所有配置就算生效了。

PS:我们可以将npm的模块下载仓库从默认的国外站点改为国内的站点，这样下载模块的速度才能比较快，只需要一个命令即可，命令是：

	npm --registry https://registry.npm.taobao.org install cluster

上面的命令是临时使用国内一家npm源的地址来安装cluster模块。如果感兴趣的话，可以测试一下使用国内站点和不使用该站点的下载速度。

如果想一直使用这个源的地址，那么可以使用下面这个命令来配置。

	npm install -g cnpm --registry=registry_url

registry_url指的是国内提供的一些npm仓库地址，常用的有：

	https://registry.npm.taobao.org
	http://r.cnpmjs.org/

这两个都可以使用。配置好国内源后，安装一个较大的模块express（npm install express -g），只用了不到6秒多一点，速度提升还是非常可观的。至此，nodejs和npm在windows上的配置就全部完毕。






一、准备工作

               1、确定电脑上已经成功安装jdk7.0以上版本

                2、win7操作系统

                3、maven安装包            下载地址：http://maven.apache.org/download.cgi

二、解压Maven安装包

                在上述地址中下载最新的Maven版本，解压到指定目录（此处根据自己的需要），本人解压到了D:\apache-maven-3.5.4目录下，里面有bin、lib
               
                conf等文件夹。

三、配置Maven环境变量

              在我的电脑-------属性-------高级系统设置---------环境变量---------系统变量--------新建

                变量名：M2_HOME
                变量值：D:\apache-maven-3.5.4
                
                找到Path在环境变量值尾部加入：;%M2_HOME%\bin;  //前面注意分号  

四、检查jdk和maven的环境变量是否配置成功

      打开dos窗口运行命令mvn -v,出现如下信息所示的信息说明安装成功；
      
      Apache Maven 3.5.4 (1edded0938998edf8bf061f1ceb3cfdeccf443fe; 2018-06-18T02:33:1
4+08:00)
Maven home: D:\apache-maven-3.5.4\bin\..
Java version: 1.8.0_65, vendor: Oracle Corporation, runtime: C:\Program Files\Ja
va\jdk1.8.0_65\jre
Default locale: zh_CN, platform encoding: GBK
OS name: "windows 7", version: "6.1", arch: "amd64", family: "windows"

五、修改本地仓库位置（如果不想修改本地仓库位置则这一步骤省略即可）
Maven会将下载的类库（jar包）放置到本地的一个目录下（一般默认情况下maven在本机的仓库位于C:\用户\用户名称\.m2.\repository），如果想重新定义这个目录的位置就需要修改Maven本地仓库的配置：

             1、在自己喜欢的位置创建文件夹，此处本人创建的位置是（D:\apache-maven-3.5.4\repo）

             2、在安装Maven的目录下找到conf文件夹，在文件夹中找到settings.xml文件，复制settings.xml文件放于D:\apache-maven-3.5.4\repo下（网上也有说settings.xml放在D:\apache-maven-3.5.4下与D:\apache-maven-3.5.4\repo文件夹同一目录下）
             
             3、修改settings.xml文件
             标签localRepository中为自己指定的本地仓库的位置，以后使用maven下载的jar和配置文件都在指定的这个目录下。
             <localRepository>D:/apache-maven-3.5.4/repo</localRepository>
             
              4、在安装Maven的目录下找到conf文件夹，在文件夹中找到settings.xml文件，与3中配置一样：（注意两个地方的settings.xml都要修改）
              
              依据该配置，Maven就会将下载的类库保存到F:/Maven/repo中
              
              5、实验一下我们刚才做的事情产生作用没有，控制台输入：mvn help:system
              
               执行完该命令之后，在D:\apache-maven-3.5.4\repo下面会出现很多文件，这些文件就maven从中央仓库下载到本地仓库的文件。
               
               
               
               PS：windows系统中目录之间是“\” .
             
             
             
             
             
             
             
             
             

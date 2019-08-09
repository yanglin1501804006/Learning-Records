# git clone速度太慢的解决办法 #

原因：git clone特别慢是因为github.global.ssl.fastly.net域名被限制了。
只要找到这个域名对应的ip地址，然后在hosts文件中加上ip–>域名的映射，刷新DNS缓存便可。

实施：

1:在网站 https://www.ipaddress.com/ 分别搜索：

    github.global.ssl.fastly.net
    github.com

得到ip:

  ![image](https://github.com/yanglin1501804006/Learning-Records/blob/master/Git/images/github.global.ssl.fastly.net .png)

  ![image](https://github.com/yanglin1501804006/Learning-Records/blob/master/Git/images/github.com.png)

2:打开hosts文件

   *  Windows上的hosts文件路径在C:\Windows\System32\drivers\etc\hosts
   *  Linux的hosts文件路径在：sudo vim /etc/hosts


3:在hosts文件末尾添加两行(对应上面查到的ip)

    151.101.185.194 github.global-ssl.fastly.net
    192.30.253.112 github.com
    
4:保存更新DNS

   *  Winodws系统的做法：打开CMD，输入ipconfig /flushdns
   *  Linux的做法：在终端输入sudo /etc/init.d/networking restart

5:完成，试试git clone这条命令速度,简直下载快的飞起，可以尝试下载SpringFramework代码或者SpringBoot代码

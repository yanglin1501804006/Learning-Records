git remote add origin git@github.com:yanglin1501804006/Spring-source-code-analysis.git

git remote add origin https://github.com/yanglin1501804006/Spring-source-code-analysis.git


Git 提示fatal: remote origin already exists 错误解决办法

1、先删除远程 Git 仓库

$ git remote rm origin

2、再添加远程 Git 仓库
如果执行 git remote rm origin 报错的话，我们可以手动修改gitconfig文件的内容

$ vi .git/config

把 [remote “origin”] 那一行删掉就好了。



Git上传本地项目到github上：
https://www.cnblogs.com/sdcs/p/8270029.html



@echo off

::停止服务
::%redis_path%redis-server --service-stop --service-name redis   --port 6379

::卸载服务
::%redis_path%redis-server --service-uninstall --service-name redis  --port 6379

::也可使用如下方式进行停止服务和卸载服务


sc stop redis
sc delete redis

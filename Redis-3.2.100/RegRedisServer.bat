@echo off
set currpath=%~dp0
set redis_path=%currpath%

::if语句，若路径不存在，则关闭系统
if not exist %redis_path% (
echo %redis_path%
echo redis path does not exist ...
::exit
goto userexit
)


echo Registering redis service：%RegisterRedisService
%redis_path%redis-server --service-install redis.windows-service.conf --service-name redis --loglevel verbose  --port 6379
::%redis_path%redis-server --service-install Redis  redis.windows-service.conf --loglevel verbose   --port 6379
sc start redis

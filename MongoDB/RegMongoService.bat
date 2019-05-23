@echo off
set currpath=%~dp0
set mongo_path=%currpath%

::if语句，若路径不存在，则关闭系统
if not exist %mongo_path% (
echo %mongo_path%
echo mongo path does not exist ...
::exit
goto userexit
)

echo %mongo_path%
 
echo Registering mongo service:%MongoDB Server
%mongo_path%bin\mongod --bind_ip 127.0.0.1 --port 27017 --config D:\MongoDB-4.0.9\bin\mongod.cfg --serviceName "MongoDB" --install

sc start MongoDB 
@echo off
set currpath=%~dp0
set mysql_path=%currpath%\bin\


::if语句，若路径不存在，则关闭系统
if not exist %mysql_path% (
echo %mysql_path%
echo mysql path does not exist ...
::exit
goto userexit
)


echo Registering nms service：%RegisteNmsService
"%mysql_path%mysqld" --install MySQL_5.7.27 --defaults-file="%currpath%my.ini"

sc start MySQL_5.7.27
@echo off
setlocal
cd /d "%~dp0"

set "APP_URL=http://localhost:8080/cinema/"

start "Cinema Tomcat" cmd /k "mvn cargo:run"

echo [start] Ready: %APP_URL%
start "" "%APP_URL%"
exit /b 0

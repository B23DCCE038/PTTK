@echo off
setlocal
cd /d "%~dp0"

set "DB_CONTAINER=cinema-mysql"

docker compose up -d
if errorlevel 1 (
    echo [db] ERROR: "docker compose up -d" failed. Is Docker Desktop running?
    pause
    exit /b 1
)

echo [db] Ready: localhost:3306 (database "cinema", user "cinema", password "cinema")
exit /b 0

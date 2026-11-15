@echo off
setlocal
cd /d "%~dp0"

call mvn package
if errorlevel 1 (
    echo.
    echo [build] BUILD FAILED - see the Maven output above.
    pause
    exit /b 1
)

echo.
echo [build] OK: target\cinema.war
echo [build] Note: run stop.bat before "mvn clean" - Tomcat lives in target\cargo.
exit /b 0

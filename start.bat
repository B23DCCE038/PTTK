@echo off
setlocal
cd /d "%~dp0"

set "APP_URL=http://localhost:8080/cinema/"
set "APP_PORT=8080"

rem --- already running? -------------------------------------------------------
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $c=New-Object Net.Sockets.TcpClient; $c.Connect('127.0.0.1',%APP_PORT%); $c.Close(); exit 0 } catch { exit 1 }"
if not errorlevel 1 (
    echo [start] Port %APP_PORT% is already serving; not starting a second Tomcat.
    echo [start] Opening %APP_URL%
    start "" "%APP_URL%"
    exit /b 0
)

rem --- launch Tomcat in its own console window -------------------------------
echo [start] Launching Tomcat in the "Cinema Tomcat" window ...
start "Cinema Tomcat" cmd /k "mvn cargo:run"

rem --- wait for the port, then for the web app -------------------------------
echo [start] Waiting for %APP_URL% ...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ok=$false; for($i=0;$i -lt 60;$i++){ try { $c=New-Object Net.Sockets.TcpClient; $c.Connect('127.0.0.1',%APP_PORT%); $c.Close(); $ok=$true; break } catch { Start-Sleep -Seconds 2 } }; if(-not $ok){ exit 1 }; for($i=0;$i -lt 30;$i++){ try { Invoke-WebRequest -UseBasicParsing -Uri '%APP_URL%' -TimeoutSec 5 | Out-Null; exit 0 } catch { if($_.Exception.Response){ exit 0 } }; Start-Sleep -Seconds 2 }; exit 2"

if errorlevel 2 (
    echo [start] WARNING: port %APP_PORT% is open but %APP_URL% does not answer.
    echo [start] Check the "Cinema Tomcat" window for a deployment error.
    echo [start] A JSP 500 on the first page usually means MySQL is not running - start-db.bat.
    exit /b 1
)
if errorlevel 1 (
    echo [start] WARNING: Tomcat did not open port %APP_PORT% within ~120 s.
    echo [start] Check the "Cinema Tomcat" window. Hints from code\README.md:
    echo [start]   - if Tomcat fails on a very new JDK, set JAVA_HOME to a JDK 21 and retry
    echo [start]   - if the port is taken: mvn cargo:run -Dcargo.servlet.port=8081
    exit /b 1
)

echo [start] Ready: %APP_URL%
start "" "%APP_URL%"
exit /b 0

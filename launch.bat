@echo off
REM Cam Tablo Creator launcher (basit - debug friendly).
REM Cift tikla calisir. Hata olursa pause sayesinde terminal kapanmaz.

cd /d "%~dp0"

echo ===================================================
echo   Cam Tablo Creator
echo ===================================================
echo.
echo Klasor: %CD%
echo.

REM Node check
where node >nul 2>&1
if errorlevel 1 (
  echo HATA: Node bulunamadi. Yeniden install yap:
  echo   iwr -useb https://www.flowiqa.com/install/etsy-cam-tablo.ps1 ^| iex
  echo.
  pause
  exit /b 1
)

REM dist/server.js check
if not exist "dist\server.js" (
  echo HATA: dist\server.js yok - kurulum bozuk. Yeniden install yap.
  echo.
  pause
  exit /b 1
)

REM Update check (opsiyonel - silent fail OK)
echo Yeni surum kontrol ediliyor...
set REMOTE_VERSION=
for /f "tokens=*" %%v in ('node -e "fetch('https://www.flowiqa.com/api/version?app=etsy-cam-tablo',{signal:AbortSignal.timeout(3000)}).then(r=^>r.json()).then(j=^>console.log(j.version^|^|'')).catch(()=^>console.log(''))" 2^>nul') do set REMOTE_VERSION=%%v
set LOCAL_VERSION=
if exist "data\.version" set /p LOCAL_VERSION=<data\.version
if not "%REMOTE_VERSION%"=="" (
  if not "%LOCAL_VERSION%"=="%REMOTE_VERSION%" (
    echo   Yeni surum: %LOCAL_VERSION% -^> %REMOTE_VERSION%
    echo   ^(launch.bat ile auto-update v1.3'te eklenir, simdilik manuel reinstall^)
  ) else (
    echo   Guncel: %LOCAL_VERSION%
  )
)
echo.

REM CDP browser baslat (arka planda)
echo CDP browser aciliyor...
start "EPC Browser" /MIN cmd /c "node launch-browser.js"
timeout /t 2 /nobreak >nul

REM Server baslat ve tarayicida ac
echo Server baslatiliyor: http://localhost:3001
echo.
echo ^(Server kapatmak icin: bu pencereyi kapat veya Ctrl+C^)
echo.

REM 3 saniye sonra tarayici ac
start "" /b cmd /c "timeout /t 3 /nobreak >nul && start http://localhost:3001"

REM Server'i foreground'da calistir (terminal acik kalir, hata gorunur)
node dist\server.js

echo.
echo Server kapandi.
pause

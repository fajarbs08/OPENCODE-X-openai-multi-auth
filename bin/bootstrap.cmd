@echo off
setlocal

for %%I in ("%~dp0..") do set "ROOT=%%~fI"
set "LOCAL_DIR=%ROOT%\.local"
set "CONFIG_DIR=%ROOT%\.personal\home\.config\opencode"

where npm >nul 2>nul
if errorlevel 1 (
    echo npm tidak ditemukan. Install Node.js + npm terlebih dahulu. 1>&2
    exit /b 1
)

echo Installing local OpenCode CLI...
call npm install --prefix "%LOCAL_DIR%"
if errorlevel 1 exit /b %errorlevel%

echo Installing OpenCode multi-account plugin...
call npm install --prefix "%CONFIG_DIR%"
if errorlevel 1 exit /b %errorlevel%

echo.
echo Selesai. Langkah berikutnya:
echo   1. %ROOT%\bin\opencode-personal.cmd auth login
echo   2. Tambah akun lain dengan command yang sama
echo   3. Jalankan %ROOT%\bin\opencode-personal.cmd run "task" --model=openai/gpt-5.2 --variant=medium

endlocal

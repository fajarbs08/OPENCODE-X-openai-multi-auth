@echo off
setlocal

for %%I in ("%~dp0..") do set "ROOT=%%~fI"
call "%ROOT%\bin\opencode-personal.cmd" %*
set "STATUS=%ERRORLEVEL%"

endlocal & exit /b %STATUS%

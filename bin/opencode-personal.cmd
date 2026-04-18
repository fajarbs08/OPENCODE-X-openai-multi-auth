@echo off
setlocal

for %%I in ("%~dp0..") do set "ROOT=%%~fI"

set "HOME=%ROOT%\.personal\home"
set "OPENCODE_CONFIG=%HOME%\.config\opencode\opencode.json"

if not defined OPENCODE_OPENAI_STRATEGY set "OPENCODE_OPENAI_STRATEGY=sticky"
if not defined OPENCODE_OPENAI_SESSION_REEVAL_MS set "OPENCODE_OPENAI_SESSION_REEVAL_MS=0"
if not defined OPENCODE_OPENAI_USAGE_REFRESH_MS set "OPENCODE_OPENAI_USAGE_REFRESH_MS=30000"
if not defined BROWSER set "BROWSER=chrome"

if defined OPENCODE_BIN (
    call "%OPENCODE_BIN%" %*
    set "STATUS=%ERRORLEVEL%"
    endlocal & exit /b %STATUS%
)

if exist "%ROOT%\.local\node_modules\.bin\opencode.cmd" (
    call "%ROOT%\.local\node_modules\.bin\opencode.cmd" %*
    set "STATUS=%ERRORLEVEL%"
    endlocal & exit /b %STATUS%
)

echo OpenCode binary tidak ditemukan. Jalankan .\bin\bootstrap.cmd atau set OPENCODE_BIN ke binary opencode Anda. 1>&2
endlocal & exit /b 1

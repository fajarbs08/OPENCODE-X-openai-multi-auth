$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$selfMainPs1 = [System.IO.Path]::GetFullPath((Join-Path $Root 'bin/opencode.ps1'))
$selfMainCmd = [System.IO.Path]::GetFullPath((Join-Path $Root 'bin/opencode.cmd'))
$selfPersonalPs1 = [System.IO.Path]::GetFullPath((Join-Path $Root 'bin/opencode-personal.ps1'))
$selfPersonalCmd = [System.IO.Path]::GetFullPath((Join-Path $Root 'bin/opencode-personal.cmd'))
$env:HOME = Join-Path $Root '.personal/home'
$env:OPENCODE_CONFIG = Join-Path $env:HOME '.config/opencode/opencode.json'

if (-not $env:OPENCODE_OPENAI_STRATEGY) {
    $env:OPENCODE_OPENAI_STRATEGY = 'sticky'
}

if (-not $env:OPENCODE_OPENAI_SESSION_REEVAL_MS) {
    $env:OPENCODE_OPENAI_SESSION_REEVAL_MS = '0'
}

if (-not $env:OPENCODE_OPENAI_USAGE_REFRESH_MS) {
    $env:OPENCODE_OPENAI_USAGE_REFRESH_MS = '30000'
}

if (-not $env:BROWSER) {
    $env:BROWSER = 'chrome'
}

if ($env:OPENCODE_BIN) {
    & $env:OPENCODE_BIN @args
    exit $LASTEXITCODE
}

$localCmd = Join-Path $Root '.local/node_modules/.bin/opencode.cmd'
if (Test-Path $localCmd) {
    & $localCmd @args
    exit $LASTEXITCODE
}

$localPs1 = Join-Path $Root '.local/node_modules/.bin/opencode.ps1'
if (Test-Path $localPs1) {
    & $localPs1 @args
    exit $LASTEXITCODE
}

$command = Get-Command opencode -ErrorAction SilentlyContinue
if ($command) {
    $resolvedSource = [System.IO.Path]::GetFullPath($command.Source)
    if ($resolvedSource -notin @($selfMainPs1, $selfMainCmd, $selfPersonalPs1, $selfPersonalCmd)) {
        & $resolvedSource @args
        exit $LASTEXITCODE
    }
}

Write-Error 'OpenCode binary tidak ditemukan. Jalankan ./bin/bootstrap (Linux/macOS), ./bin/bootstrap.ps1 (Windows PowerShell), atau .\bin\bootstrap.cmd (Windows Command Prompt), atau set OPENCODE_BIN ke binary opencode Anda.'

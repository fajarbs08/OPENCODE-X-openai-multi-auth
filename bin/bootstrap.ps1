$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$LocalDir = Join-Path $Root '.local'
$ConfigDir = Join-Path $Root '.personal/home/.config/opencode'

if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Error 'npm tidak ditemukan. Install Node.js + npm terlebih dahulu.'
}

Write-Host 'Installing local OpenCode CLI...'
npm install --prefix $LocalDir

Write-Host 'Installing OpenCode multi-account plugin...'
npm install --prefix $ConfigDir

Write-Host ''
Write-Host 'Selesai. Langkah berikutnya:'
Write-Host "  1. $Root/bin/opencode-personal.ps1 auth login"
Write-Host '  2. Tambah akun lain dengan command yang sama'
Write-Host "  3. Jalankan $Root/bin/opencode-personal.ps1 run \"task\" --model=openai/gpt-5.2 --variant=medium"

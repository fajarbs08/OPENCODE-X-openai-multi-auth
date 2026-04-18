# Panduan Setup

Bahasa: [English](./setup.md) | [Indonesia](./setup.id.md)

## Prasyarat

- Node.js + npm
- Browser desktop untuk login OAuth
- Git jika Anda ingin clone, commit, atau push repository ini
- VS Code jika Anda ingin workflow editor yang sama seperti pada screenshot

## Apakah Harus Install OpenCode Dulu?

Tidak.

Repository ini memang dibuat supaya Anda **tidak perlu**:

- install `opencode` secara global
- install plugin `opencode-openai-multi-auth` secara manual sebelumnya

Script bootstrap akan memasang keduanya secara lokal di dalam repository ini.

## Detail Instalasi Plugin

Dependency plugin yang dipakai setup ini:

- `opencode-openai-multi-auth@5.0.6`
- `@opencode-ai/plugin@1.4.7`

Dideklarasikan di:

- `.personal/home/.config/opencode/package.json`

Di-install ke:

- `.personal/home/.config/opencode/node_modules/`

Dimuat oleh:

- `.personal/home/.config/opencode/opencode.json`

Kalau perlu, Anda bisa memasang dependency plugin saja dengan:

```bash
npm install --prefix ./.personal/home/.config/opencode
```

## Dukungan Platform

- Linux: gunakan `./bin/bootstrap` dan `./bin/opencode-personal`
- macOS: gunakan `./bin/bootstrap` dan `./bin/opencode-personal`
- Windows PowerShell: gunakan `./bin/bootstrap.ps1` dan `./bin/opencode-personal.ps1`
- Windows Command Prompt: gunakan `.\bin\bootstrap.cmd` dan `.\bin\opencode-personal.cmd`

Linux dan macOS adalah alur dokumentasi utama. Wrapper Windows disediakan sebagai alternatif setara.

## Instalasi per OS

### Linux dan macOS

Jalankan dari root repository ini:

```bash
./bin/bootstrap
```

### Windows PowerShell

```powershell
./bin/bootstrap.ps1
```

### Windows Command Prompt

```bat
.\bin\bootstrap.cmd
```

Script ini akan memasang:

- OpenCode CLI lokal ke `.local/`
- plugin `opencode-openai-multi-auth` ke `.personal/home/.config/opencode/`

Jadi setelah bootstrap selesai, Anda bisa langsung memakai wrapper lokal tanpa perlu install `opencode` system-wide.

## Login Akun per OS

### Linux dan macOS

```bash
./bin/opencode-personal auth login
```

### Windows PowerShell

```powershell
./bin/opencode-personal.ps1 auth login
```

### Windows Command Prompt

```bat
.\bin\opencode-personal.cmd auth login
```

Untuk menambah akun lain, jalankan command yang sama lalu pilih `Add Another OpenAI Account`.

## Alur Pertama Kali yang Disarankan

1. Jalankan bootstrap sesuai OS Anda.
2. Login dengan akun ChatGPT pertama.
3. Login lagi untuk menambahkan akun kedua.
4. Jalankan prompt sederhana untuk verifikasi setup.
5. Mulai pakai model dan variant yang sesuai kebutuhan harian Anda.

## Contoh Command Harian

Unix shell:

```bash
./bin/opencode-personal run "review this codebase" --model=openai/gpt-5.2 --variant=medium
./bin/opencode-personal run "fix PHPStan issues" --model=openai/gpt-5.2-codex --variant=high
```

Windows PowerShell:

```powershell
./bin/opencode-personal.ps1 run "review this codebase" --model=openai/gpt-5.2 --variant=medium
./bin/opencode-personal.ps1 run "fix PHPStan issues" --model=openai/gpt-5.2-codex --variant=high
```

Windows Command Prompt:

```bat
.\bin\opencode-personal.cmd run "review this codebase" --model=openai/gpt-5.2 --variant=medium
.\bin\opencode-personal.cmd run "fix PHPStan issues" --model=openai/gpt-5.2-codex --variant=high
```

## Default Runtime

Wrapper `bin/opencode-personal` otomatis mengatur:

```bash
HOME=<repo>/.personal/home
OPENCODE_CONFIG=<repo>/.personal/home/.config/opencode/opencode.json
OPENCODE_OPENAI_STRATEGY=sticky
OPENCODE_OPENAI_SESSION_REEVAL_MS=0
OPENCODE_OPENAI_USAGE_REFRESH_MS=30000
```

## Override Opsional

Jika ingin override sementara:

```bash
OPENCODE_OPENAI_STRATEGY=round-robin ./bin/opencode-personal run "task"
OPENCODE_OPENAI_STRATEGY=hybrid ./bin/opencode-personal run "task"
OPENCODE_BIN=/usr/local/bin/opencode ./bin/opencode-personal run "task"
```

## Lokasi State Lokal

- config: `.personal/home/.config/opencode/opencode.json`
- akun: `.personal/home/.config/opencode/openai-accounts.json`
- session binding: `.personal/home/.config/opencode/openai-multi-auth-session-bindings.json`
- instalasi CLI lokal: `.local/`

File akun dan session ini sengaja di-ignore oleh git.

## Keamanan GitHub

File sensitif yang sengaja di-ignore:

- `.personal/home/.config/opencode/openai-accounts.json`
- `.personal/home/.config/opencode/openai-multi-auth-session-bindings.json`
- folder cache dan `node_modules`

Sebelum push, cek cepat:

```bash
git status
```

Pastikan file akun atau token tidak pernah muncul di staging.

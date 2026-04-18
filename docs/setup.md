# Setup Guide

Language: [English](./setup.md) | [Indonesia](./setup.id.md)

## Prerequisites

- Node.js + npm
- A desktop browser for OAuth login
- Git if you want to clone, commit, or push the repository
- VS Code if you want the same editor workflow shown in the screenshots

## Do You Need to Install OpenCode First?

No.

This repository is designed so you do **not** need:

- a global `opencode` installation
- a preinstalled `opencode-openai-multi-auth` plugin

The bootstrap script will install both locally inside this repository.

## Platform Support

- Linux: use `./bin/bootstrap` and `./bin/opencode-personal`
- macOS: use `./bin/bootstrap` and `./bin/opencode-personal`
- Windows PowerShell: use `./bin/bootstrap.ps1` and `./bin/opencode-personal.ps1`
- Windows Command Prompt: use `.\bin\bootstrap.cmd` and `.\bin\opencode-personal.cmd`

Linux and macOS are the primary documented workflow. Windows wrappers are included as equivalent alternatives.

## Installation by OS

### Linux and macOS

Run this from the repository root:

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

The script installs:

- the local OpenCode CLI into `.local/`
- the `opencode-openai-multi-auth` plugin into `.personal/home/.config/opencode/`

So after bootstrap, you can use the local wrappers directly without installing `opencode` system-wide.

## Account Login by OS

### Linux and macOS

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

To add more accounts, run the same command again and choose `Add Another OpenAI Account`.

## Recommended First-Time Flow

1. Run the bootstrap script for your OS.
2. Log in with the first ChatGPT account.
3. Log in again and add the second account.
4. Run a simple prompt to verify the setup.
5. Start using your preferred model and variant in daily work.

## Daily Command Examples

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

The `bin/opencode-personal` wrapper automatically sets:

```bash
HOME=<repo>/.personal/home
OPENCODE_CONFIG=<repo>/.personal/home/.config/opencode/opencode.json
OPENCODE_OPENAI_STRATEGY=sticky
OPENCODE_OPENAI_SESSION_REEVAL_MS=0
OPENCODE_OPENAI_USAGE_REFRESH_MS=30000
```

## Optional Overrides

If you want to override behavior temporarily:

```bash
OPENCODE_OPENAI_STRATEGY=round-robin ./bin/opencode-personal run "task"
OPENCODE_OPENAI_STRATEGY=hybrid ./bin/opencode-personal run "task"
OPENCODE_BIN=/usr/local/bin/opencode ./bin/opencode-personal run "task"
```

## Where Local State Lives

- config: `.personal/home/.config/opencode/opencode.json`
- accounts: `.personal/home/.config/opencode/openai-accounts.json`
- session bindings: `.personal/home/.config/opencode/openai-multi-auth-session-bindings.json`
- local CLI install: `.local/`

The account and session files are intentionally ignored by git.

## GitHub Safety

Sensitive files intentionally ignored:

- `.personal/home/.config/opencode/openai-accounts.json`
- `.personal/home/.config/opencode/openai-multi-auth-session-bindings.json`
- cache directories and `node_modules`

Before pushing, do a quick check:

```bash
git status
```

Make sure account or token files never appear in staging.

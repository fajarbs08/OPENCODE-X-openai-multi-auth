# OpenCode Shareable Setup: Rotate by Reset

Bahasa: [English](./README.md) | [Indonesia](./README.id.md)

This repository is a **safe-to-share** OpenCode + ChatGPT OAuth multi-account setup.

Its main goals are:

- portable, with no hard dependency on `/opt/fajarlabs/AI`
- safe to push to GitHub
- default behavior tuned for **rotate by reset**
- still practical for day-to-day OpenCode coding workflows

## OS Support

- Linux: supported
- macOS: supported
- Windows: supported with PowerShell and Command Prompt wrappers

Notes:

- Linux and macOS use `bin/opencode` and `bin/bootstrap`
- Windows PowerShell users can use `bin/opencode.ps1`, `bin/opencode-personal.ps1`, and `bin/bootstrap.ps1`
- Windows Command Prompt users can use `bin/opencode.cmd`, `bin/opencode-personal.cmd`, and `bin/bootstrap.cmd`
- VS Code terminal PATH setup is included for Linux, macOS, and Windows

## How Rotation Works

This setup enables the following defaults:

- `OPENCODE_OPENAI_STRATEGY=sticky`
- `OPENCODE_OPENAI_SESSION_REEVAL_MS=0`
- `OPENCODE_OPENAI_USAGE_REFRESH_MS=30000`

In practice, that means:

- session-to-account bindings are reevaluated on every request
- usage snapshots are refreshed every 30 seconds
- the plugin can prioritize the account with the **nearest reset** when selecting again
- once one account is limited, another available account can be used

This is better suited for a "use the account that recovers fastest" workflow than plain per-request rotation.

## What This Repo Gives You

- an isolated OpenCode `HOME` inside the repository
- a GitHub-safe structure that avoids committing live account tokens
- local bootstrap scripts for dependency installation
- Unix wrappers for Linux and macOS
- PowerShell and Command Prompt wrappers for Windows
- a prebuilt OpenCode config with GPT-5 family OAuth presets
- defaults tuned for reset-oriented account reuse
- bilingual documentation for sharing with teams or clients

## Feature Summary

- multi-account ChatGPT OAuth workflow through `opencode-openai-multi-auth`
- rotation behavior optimized for the account with the nearest reset
- local config isolation so this setup does not pollute your main machine config
- repo-safe `.gitignore` for account files, session bindings, cache, and `node_modules`
- OpenCode CLI installed locally through project dependencies
- VS Code terminal PATH integration
- cross-OS entrypoints for Linux, macOS, Windows PowerShell, and Windows CMD
- easy runtime overrides through environment variables

## Folder Structure

```text
opencode-share-reset-rotate/
├── README.md
├── README.id.md
├── .gitignore
├── bin/
│   ├── bootstrap.cmd
│   ├── bootstrap
│   ├── bootstrap.ps1
│   ├── opencode.cmd
│   ├── opencode
│   ├── opencode-personal.cmd
│   ├── opencode-personal
│   ├── opencode-personal.ps1
│   └── opencode.ps1
├── .vscode/
│   └── settings.json
├── .local/
│   └── package.json
├── .personal/
│   └── home/
│       └── .config/
│           └── opencode/
│               ├── .gitignore
│               ├── AGENTS.md
│               ├── opencode.json
│               └── package.json
└── docs/
    ├── setup.md
    └── setup.id.md
```

## Quick Start

1. Enter this folder.
2. Install local dependencies:

```bash
./bin/bootstrap
```

On Windows PowerShell:

```powershell
./bin/bootstrap.ps1
```

On Windows Command Prompt:

```bat
.\bin\bootstrap.cmd
```

3. Log in with your first account:

```bash
./bin/opencode-personal auth login
```

On Windows PowerShell:

```powershell
./bin/opencode-personal.ps1 auth login
```

On Windows Command Prompt:

```bat
.\bin\opencode-personal.cmd auth login
```

Choose `ChatGPT Plus/Pro (Codex Subscription)`.

4. Add another account:

```bash
./bin/opencode-personal auth login
```

Choose `Add Another OpenAI Account`.

5. Run a quick test:

```bash
./bin/opencode-personal run "write hello world to test.txt" --model=openai/gpt-5.2 --variant=medium
```

On Windows PowerShell:

```powershell
./bin/opencode-personal.ps1 run "write hello world to test.txt" --model=openai/gpt-5.2 --variant=medium
```

On Windows Command Prompt:

```bat
.\bin\opencode-personal.cmd run "write hello world to test.txt" --model=openai/gpt-5.2 --variant=medium
```

## Typical Daily Usage

Unix shell:

```bash
./bin/opencode-personal run "summarize this repository" --model=openai/gpt-5.2 --variant=medium
./bin/opencode-personal run "fix the failing test" --model=openai/gpt-5.2-codex --variant=high
OPENCODE_OPENAI_STRATEGY=hybrid ./bin/opencode-personal run "refactor this module"
```

Windows PowerShell:

```powershell
./bin/opencode-personal.ps1 run "summarize this repository" --model=openai/gpt-5.2 --variant=medium
./bin/opencode-personal.ps1 run "fix the failing test" --model=openai/gpt-5.2-codex --variant=high
$env:OPENCODE_OPENAI_STRATEGY='hybrid'; ./bin/opencode-personal.ps1 run "refactor this module"
```

Windows Command Prompt:

```bat
.\bin\opencode-personal.cmd run "summarize this repository" --model=openai/gpt-5.2 --variant=medium
.\bin\opencode-personal.cmd run "fix the failing test" --model=openai/gpt-5.2-codex --variant=high
set OPENCODE_OPENAI_STRATEGY=hybrid && .\bin\opencode-personal.cmd run "refactor this module"
```

## Runtime Defaults

These values are applied automatically by the wrappers unless you override them:

- `OPENCODE_OPENAI_STRATEGY=sticky`
- `OPENCODE_OPENAI_SESSION_REEVAL_MS=0`
- `OPENCODE_OPENAI_USAGE_REFRESH_MS=30000`
- `OPENCODE_CONFIG=<repo>/.personal/home/.config/opencode/opencode.json`

## What This Repo Does Not Include

- live account tokens
- exported session bindings
- bundled plugin source code or `node_modules`
- automatic GitHub remote creation
- a custom account manager implementation; it relies on the upstream plugin

## VS Code

If you open this folder in VS Code, the integrated terminal automatically adds `./bin` to `PATH`, so you can run:

```bash
opencode
```

## Files Intentionally Excluded

This repository intentionally ignores:

- `openai-accounts.json`
- `openai-multi-auth-session-bindings.json`
- OpenCode cache
- npm cache
- `node_modules`

That keeps the repository safe to publish, as long as you keep `.gitignore` intact.

## Important Notes

- This setup expects `opencode-openai-multi-auth@5.0.6`
- The local OpenCode CLI is installed through `.local/package.json`
- If you want to use another binary, set `OPENCODE_BIN=/path/to/opencode`
- The actual account rotation logic is provided by the upstream plugin, while this repo packages a portable, safer sharing layout around it

See [docs/setup.md](./docs/setup.md) for the full setup guide.

## Credit

- Shared by [Fajar Budi Setiawan](https://fajarlabs.com)
- This repository wraps and documents a shareable setup around OpenCode and the MIT-licensed [`opencode-openai-multi-auth`](https://github.com/dkraemerwork/opencode-openai-multi-auth) workflow.

# dotfiles

My dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

Supports **WSL** (Ubuntu), **Termux** (Android), and **Windows** (PowerShell).

## What's Managed

| File | Description | Platforms |
|---|---|---|
| `~/.bashrc` | Shell config (history, aliases, git shortcuts, oh-my-posh) | WSL, Termux |
| `~/.inputrc` | Readline config (case-insensitive completion, history search) | WSL, Termux |
| `~/.gitconfig` | Git user, credential helper | All |
| `~/.config/oh-my-posh/oddrationale.omp.json` | Custom Dracula prompt theme | All |
| `~/.termux/*` | Colors, properties, font | Termux only |
| `~/OneDrive/.../Microsoft.PowerShell_profile.ps1` | PowerShell profile (PSReadLine, aliases) | Windows only |

### Bootstrap Scripts (`run_once_`)

Automatically install packages on first `chezmoi apply`:

- **WSL:** `brew install` — fnm, oh-my-posh, pnpm, ripgrep, uv
- **Termux:** `pkg install` — git, neovim, oh-my-posh, openssh, termux-api
- **Windows:** `scoop install` — 7zip, fnm, gh, git, JetBrainsMono-NF, neovim, oh-my-posh, uv

### Externals (`.chezmoiexternal.toml`)

- **Termux:** JetBrains Mono Nerd Font (downloaded, not stored in git)

## Quick Start

### WSL (Ubuntu)

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install chezmoi and apply
brew install chezmoi
chezmoi init oddrationale/dotfiles --apply
```

### Termux (Android)

```bash
pkg install chezmoi
chezmoi init git@github.com:oddrationale/dotfiles.git --apply
```

### Windows (PowerShell)

```powershell
# Install Scoop (if needed)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.dev | iex

# Install chezmoi and apply
scoop install chezmoi
chezmoi init oddrationale/dotfiles --apply
```

## First-Time Prompts

During `chezmoi init`, you'll be asked:

- **Your full name** (default: Dariel Dato-on)
- **Git email** (default: GitHub noreply address)

These are stored in `~/.config/chezmoi/chezmoi.toml` and won't be asked again.

## Daily Usage

```bash
# Pull latest changes and apply
chezmoi update

# See what would change
chezmoi diff

# Edit a managed file (opens in source dir)
chezmoi edit ~/.bashrc

# Add a new file to chezmoi
chezmoi add ~/.some-config

# Push changes
chezmoi cd
git add -A && git commit -m "description" && git push
exit
```

## Platform Detection

Automatic via `.chezmoi.toml.tmpl`:

| OS | Context | How |
|---|---|---|
| Linux | `wsl` | `.chezmoi.os == "linux"` |
| Android | `termux` | `.chezmoi.os == "android"` |
| Windows | `windows` | `.chezmoi.os == "windows"` |

Templates use `{{ .context }}` to conditionally include platform-specific config.

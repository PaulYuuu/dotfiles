[![Test dotfiles](https://img.shields.io/github/actions/workflow/status/PaulYuuu/dotfiles/testDotfiles.yml?label=CI&style=for-the-badge&color=A3BE8C)](https://github.com/PaulYuuu/dotfiles/actions/workflows/testDotfiles.yml)
![GitHub License](https://img.shields.io/github/license/PaulYuuu/dotfiles?style=for-the-badge&color=EBCB8B)
[![Last Commit](https://img.shields.io/github/last-commit/PaulYuuu/dotfiles?style=for-the-badge&color=8FBCBB)](https://github.com/PaulYuuu/dotfiles/commits/main)
[![Nord Theme](https://img.shields.io/badge/theme-nord-5E81AC?style=for-the-badge)](https://www.nordtheme.com/)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-B48EAD?style=for-the-badge)](https://github.com/PaulYuuu/dotfiles)
[![chezmoi](https://img.shields.io/badge/managed%20with-chezmoi-88C0D0?style=for-the-badge)](https://www.chezmoi.io/)

# Dotfiles

Personal dotfiles managed with chezmoi for macOS and Linux systems.

## Important Notice

**Do not use this repository directly.** This repository contains personal configurations that require:
- Bitwarden CLI for secret management
- age encryption for sensitive files
- Personal data and credentials

However, ephemeral systems (non-Fedora Linux distributions like RHEL/CentOS) can use this repository with limited functionality, as sensitive configurations are automatically excluded.

## Features

- Cross-platform support (macOS and Linux)
- Platform-specific configurations with automatic detection
- Age encryption for sensitive files
- Template-based configuration with personal data and Nord theme colors
- Modular shell configuration (zsh and nushell)
- Automated setup scripts with enhanced terminal output (using gum)
- Centralized visual configuration (fonts, colors, themes)

## Requirements

### For Personal Systems (macOS or Fedora)

- chezmoi (version 2.63.1 or compatible)
- age (for encryption)
- Bitwarden CLI (for secret management)
- gum (for enhanced terminal output)
- jq (for JSON processing)

### For Ephemeral Systems (RHEL, CentOS, etc.)

- chezmoi
- gum (required for bootstrap and setup scripts)

## Installation

### Personal Systems

1. Install dependencies:
   ```bash
   # macOS
   brew install age jq bitwarden-cli chezmoi gum

   # Fedora
   sudo dnf install -y age jq chezmoi gum
   # Install Bitwarden CLI from https://bitwarden.com/help/cli/
   ```

2. Initialize chezmoi with this repository:
   ```bash
   chezmoi init PaulYuuu
   ```

3. Review changes before applying:
   ```bash
   chezmoi diff
   ```

4. Apply dotfiles:
   ```bash
   chezmoi apply
   ```

### Ephemeral Systems

For ephemeral systems, sensitive configurations are automatically excluded:

1. Install gum (required for setup scripts):
   ```bash
   # CentOS Stream / RHEL
   sudo dnf config-manager --set-enabled crb
   sudo dnf install -y epel-release
   sudo dnf install -y chezmoi gum
   ```

2. Initialize and apply:
   ```bash
   chezmoi init PaulYuuu
   chezmoi apply
   ```

## Repository Structure

- `.chezmoiroot` - Defines source root as `home/`
- `.chezmoi.toml.tmpl` - Core configuration with platform detection
- `.chezmoidata/` - Template variables (user, git, terminal, visual settings)
- `.chezmoiscripts/` - Setup scripts using gum for enhanced output
- `.chezmoiexternals/` - External resource management
- `.chezmoiignore.tmpl` - Platform-specific ignore rules
- `.chezmoiremove` - Files to remove from target directory

## Platform Detection

The repository automatically detects the system type:

- **Personal systems**: macOS or Fedora Linux with username "yvanyo"
- **Ephemeral systems**: Non-Fedora Linux distributions

Ephemeral systems automatically exclude:
- Encrypted files
- Personal configurations
- Cloud service integrations
- Most application configs

## Development

### Quick Start with Just

This repository uses [Just](https://github.com/casey/just) for common tasks:

```bash
just           # List all available commands
just check     # Run all pre-commit checks
just test      # Build and test in container
just diff      # Show pending changes
just apply     # Apply configuration
```

See all commands with `just --list`.

### Pre-commit Hooks

This repository uses pre-commit hooks for code quality:

```bash
pre-commit run --all-files
# Or use: just check
```

Hooks include:
- **TOML**: Format and lint with taplo
- **YAML**: Deep validation with yamllint
- **Shell**: Format with shfmt, check with shellcheck
- **GitHub Actions**: Validate with actionlint
- **EditorConfig**: Enforce consistent style
- **Security**: Secret detection with gitleaks
- **Spelling**: Typo detection
- **Commits**: Conventional commit linting

### Continuous Integration

Automated testing runs on:
- Pull requests to main branch
- Weekly schedule (Sundays)
- Manual workflow dispatch

Tests validate:
- Multi-architecture compatibility (amd64/arm64)
- Ephemeral system detection and configuration
- External binary downloads
- Script execution in CentOS Stream 10 container

Dependencies are automatically updated:
- **Pre-commit hooks**: Monthly via pre-commit.ci
- **GitHub Actions**: Monthly via Dependabot
- **Bot PRs**: Auto-merged after tests pass

### Making Changes

1. Edit files in the chezmoi source directory:
   ```bash
   chezmoi edit ~/.config/app/config
   # Or: just edit ~/.config/app/config
   ```

2. Review changes:
   ```bash
   just diff
   # Or: chezmoi diff
   ```

3. Apply changes:
   ```bash
   just apply
   # Or: chezmoi apply
   ```

4. Test locally (optional):
   ```bash
   just test  # Run in Podman container
   ```

## Included Configurations

- Shell: zsh, nushell
- Terminals: ghostty, kitty, rio (all using Nord theme)
- Editors: helix, neovim, vscode, zed
- CLI tools: atuin, bat, eza, git, gum, ripgrep, starship
- Development: claude, direnv, npm, mise
- Desktop (Linux): niri, fcitx5, sddm
- System: SSH, homebrew (macOS)

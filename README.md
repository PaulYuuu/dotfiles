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
- Template-based configuration with personal data
- Modular shell configuration (zsh and nushell)
- Automated setup scripts for system packages and preferences

## Requirements

### For Personal Systems (macOS or Fedora)

- chezmoi (version 2.63.1 or compatible)
- age (for encryption)
- Bitwarden CLI (for secret management)
- jq (for JSON processing)

### For Ephemeral Systems (RHEL, CentOS, etc.)

- chezmoi only

## Installation

### Personal Systems

1. Install dependencies:
   ```bash
   # macOS
   brew install age jq bitwarden-cli chezmoi

   # Fedora
   sudo dnf install -y age jq chezmoi
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

For ephemeral systems, sensitive configurations are automatically excluded. Simply initialize and apply:

```bash
chezmoi init
chezmoi apply
```

## Repository Structure

- `.chezmoiroot` - Defines source root as `home/`
- `.chezmoi.toml.tmpl` - Core configuration with platform detection
- `.chezmoidata/` - Template variables (user, git, terminal settings)
- `.chezmoiscripts/` - Setup scripts for Darwin and Linux
- `.chezmoiexternals/` - External resource management (fonts, binaries)
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

### Pre-commit Hooks

This repository uses pre-commit hooks for code quality:

```bash
pre-commit run --all-files
```

Hooks include:
- YAML and TOML syntax checking
- Line ending normalization
- Trailing whitespace removal
- Secret detection (gitleaks)
- Spell checking (typos)
- Commit message linting (conventional commits)

### Making Changes

1. Edit files in the chezmoi source directory:
   ```bash
   chezmoi edit ~/.config/app/config
   ```

2. Review changes:
   ```bash
   chezmoi diff
   ```

3. Apply changes:
   ```bash
   chezmoi apply
   ```

## Included Configurations

- Shell: zsh, nushell
- Terminals: ghostty, kitty, rio
- Editors: helix, vscode, zed
- CLI tools: atuin, bat, eza, git, ripgrep, starship
- Development: claude, direnv, npm
- System: SSH, homebrew (macOS)

## License

MIT License - see LICENSE file for details.

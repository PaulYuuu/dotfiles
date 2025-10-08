# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a chezmoi dotfiles repository managing configuration files across macOS and Linux systems. Uses age encryption for sensitive files and platform detection for ephemeral/personal system differentiation.

## Key Commands

```bash
# Chezmoi operations
chezmoi status        # Check pending changes
chezmoi diff          # Show diff of pending changes
chezmoi apply         # Apply changes to home directory
chezmoi update        # Update from remote and apply
chezmoi add <file>    # Add file to chezmoi management
chezmoi edit <file>   # Edit managed file

# Development
pre-commit run --all-files    # Run linters and checks
```

## Architecture

### Directory Structure
- `home/` - Source root (defined in `.chezmoiroot`)
  - All files deploy to `~/`
  - `.tmpl` files are processed as templates
  - `.age` files are encrypted
  - `.chezmoiscripts/` contains run-once and apply scripts

### Platform Detection (`.chezmoi.toml.tmpl`)
- **Ephemeral systems**: Non-Fedora Linux (skips encryption, personal configs)
- **Personal systems**: macOS or Fedora with username "yvanyo"

### Template Variables
- `.isEphemeral` - Whether system is ephemeral
- `.isPersonal` - Whether system is personal
- `.chezmoi.os` - Operating system (darwin/linux)
- `.chezmoi.username` - Current username

Data files in `home/.chezmoidata/` (user.yaml, git.yaml, terminal.yaml) provide additional variables.

### File Naming Conventions
- `dot_config` → `~/.config`
- `private_dot_ssh` → `~/.ssh` (mode 0700)
- `executable_*` → executable file
- `*.tmpl` → template processed file
- `*.age` → encrypted file

## Pre-commit Hooks

- YAML syntax, line endings, trailing whitespace
- Secret detection (gitleaks)
- Spell checking (typos, excludes .age files)
- Commit message linting (conventional commits)

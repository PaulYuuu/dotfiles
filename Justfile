# List all available commands
default:
  @just --list

# Run pre-commit checks on all files
check:
  pre-commit run --all-files

# Show chezmoi health status
doctor:
  chezmoi doctor

# Show pending changes
diff:
  chezmoi diff

# Show status of managed files
status:
  chezmoi status

# Apply configuration
apply:
  chezmoi apply

# Update from remote and apply
update:
  chezmoi update

# Build test image
build:
  podman build -t dotfiles-c10s .

# Run local image test
test: build
  podman run --rm -v "$(pwd):/dotfiles:ro" dotfiles-c10s

# Clean up test image
clean:
  podman rmi --ignore dotfiles-10s

# Add a file to chezmoi management
add FILE:
  chezmoi add {{FILE}}

# Edit a managed file
edit FILE:
  chezmoi edit {{FILE}}

# Verify chezmoi state
verify:
  chezmoi verify

#!/bin/bash
set -euo pipefail

echo "Setting up third-party repositories…"

# Enable RPM Fusion repositories
for repo in free nonfree; do
  sudo dnf install -y "https://download1.rpmfusion.org/${repo}/fedora/rpmfusion-${repo}-release-$(rpm -E %fedora).noarch.rpm"
done

# Enable COPR repositories
for repo in skoved/vivid errornointernet/quickshell; do
  sudo dnf copr enable -y "${repo}" >/dev/null 2>&1
done

# Add Terra repository
if ! rpm -q terra-release &>/dev/null; then
  sudo dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
fi

# Add VS Code repository
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo tee /etc/yum.repos.d/vscode.repo >/dev/null <<'EOR'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOR

# Add Gemfury repository
sudo tee /etc/yum.repos.d/fury.repo >/dev/null <<'EOR'
[carapace]
name=Gemfury Carapace Repo
baseurl=https://yum.fury.io/rsteube/
enabled=1
gpgcheck=0

[nushell]
name=Gemfury Nushell Repo
baseurl=https://yum.fury.io/nushell/
enabled=1
gpgcheck=0
EOR

echo "Third-party repositories configured."

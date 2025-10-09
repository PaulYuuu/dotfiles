#!/bin/bash
set -euo pipefail

sudo mkdir -p /etc/systemd/logind.conf.d

sudo tee /etc/systemd/logind.conf.d/99-lid-suspend.conf >/dev/null <<'EOF'
[Login]
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
LidSwitchIgnoreInhibited=yes
EOF

sudo systemctl restart systemd-logind

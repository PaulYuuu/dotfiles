#!/bin/bash

set -e

# Allow users in 'wheel' group to manage NetworkManager connections.
sudo tee /etc/polkit-1/rules.d/49-nmcli.rules >/dev/null <<'EOF'
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 &&
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
EOF

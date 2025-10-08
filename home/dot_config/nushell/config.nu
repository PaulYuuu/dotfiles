# Modular Nushell Configuration

source ($nu.default-config-dir | path join "conf.d" "00_utils.nu")

# Core configuration
source ($nu.default-config-dir | path join "conf.d" "01_environment.nu")
source ($nu.default-config-dir | path join "conf.d" "02_history.nu")

# Tool integrations
source ($nu.default-config-dir | path join "conf.d" "03_integrations.nu")

# User interface and experience
source ($nu.default-config-dir | path join "conf.d" "04_aliases.nu")
source ($nu.default-config-dir | path join "conf.d" "05_keybindings.nu")
source ($nu.default-config-dir | path join "conf.d" "06_prompt.nu")

# Private configuration
source ($nu.default-config-dir | path join "conf.d" "98_bitwarden.nu")
source ($nu.default-config-dir | path join "conf.d" "99_private.nu")

# Zoxide interactive menu for directory navigation
#
# To use this menu:
# 1. Copy the zoxide_menu definition to your config.nu menus section
# 2. Copy the keybinding definition to your config.nu keybindings section
# 3. Restart nushell

# Zoxide menu definition
export def zoxide_menu [] {
    {
      name: zoxide_menu
      only_buffer_difference: true
      marker: "| "
      type: {
          layout: columnar
          page_size: 20
      }
      style: {
          text: green
          selected_text: green_reverse
          description_text: yellow
      }
      source: { |buffer, position|
          zoxide query -ls $buffer
          | parse -r '(?P<description>[0-9]+) (?P<value>.+)'
      }
    }
}

# Keybinding definition (Ctrl+O to open zoxide menu)
export def zoxide_keybinding [] {
    {
      name: zoxide_menu
      modifier: control
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: [
        { send: menu name: zoxide_menu }
      ]
    }
}

# Additional keybinding (Alt+E to edit command)
export def edit_keybinding [] {
    {
      name: edit
      modifier: alt
      keycode: char_e
      mode: [emacs, vi_normal, vi_insert]
      event: [
        { send: OpenEditor }
      ]
    }
}

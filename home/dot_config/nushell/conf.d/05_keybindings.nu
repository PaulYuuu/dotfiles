# Use emacs editing mode (most default keybindings work automatically)
$env.config.edit_mode = "emacs"

# Add zoxide menu and additional keybindings
$env.config.menus = ($env.config.menus | append {
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
})

$env.config.keybindings = ($env.config.keybindings | append [
    {
        name: zoxide_menu
        modifier: control
        keycode: char_o
        mode: [emacs, vi_normal, vi_insert]
        event: [
            { send: menu name: zoxide_menu }
        ]
    }
    {
        name: edit_command
        modifier: alt
        keycode: char_e
        mode: [emacs, vi_normal, vi_insert]
        event: [
            { send: OpenEditor }
        ]
    }
    {
        name: clear_line
        modifier: control
        keycode: char_u
        mode: [emacs, vi_normal, vi_insert]
        event: [
            { edit: Clear }
        ]
    }
    {
        name: kill_to_end
        modifier: control
        keycode: char_k
        mode: [emacs, vi_normal, vi_insert]
        event: [
            { edit: CutToEnd }
        ]
    }
])

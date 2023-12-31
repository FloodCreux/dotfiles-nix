local wezterm = require 'wezterm'

local config = {}

config.font = wezterm.font('JetBrains Mono', { weight = 'Bold' })
config.font_size = 13

config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

config.enable_tab_bar = false

config.window_frame = {
    font = wezterm.font('JetBrains Mono', { weight = 'Medium' }),
    font_size = 10,
}

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.text_background_opacity = 0.75

-- config.colors = wezterm.color.get_builtin_schemes()['Catppuccin Macchiato']
config.color_scheme = 'Catppuccin Macchiato'

config.window_decorations = 'RESIZE'

return config

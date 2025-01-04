local wezterm = require 'wezterm'
local config = wezterm.config_builder()


config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 15
config.max_fps = 120
return config

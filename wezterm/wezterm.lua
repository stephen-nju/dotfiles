--[[
Author: zhubin
Date: 2023-04-12 09:10:15
FilePath: \wezterm\wezterm.lua
Description: 

Copyright (c) 2023 by ${git_name}, All Rights Reserved. 
--]]
local wezterm = require("wezterm")
local keybindings = require("config.key-bindings")
local launch_menu = require("config.launch-menu")
local ssh_domains = require("config.ssh-domains")
local shell = require("config.shell")
require("config.right-status").setup()
require("config.notify").setup()
require("config.tab-title").setup()

-- [[ font with fallback ]]
-- local function font_with_fallback(name, params)
--   local names = { name }
--   return wezterm.font_with_fallback(names, params)
-- end

return {
   -- fonts
   font = wezterm.font_with_fallback({"Consolas","MesloLGM NF","Hack Nerd Font Mono"}),
   font_size = 12,
   front_end = "OpenGL",

   -- colour scheme
   color_scheme = "Catppuccin Frappe",
   -- background

   -- scroll bar
   enable_scroll_bar = true,
   tab_bar_at_bottom = true,

   -- status
   status_update_interval = 1000,

   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = true,
   use_fancy_tab_bar = false,
   tab_max_width = 25,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   -- window
   window_padding = {
      left = 5,
      right = 10,
      top = 12,
      bottom = 7,
   },
   window_frame = {
      active_titlebar_bg = "#090909",
      font = wezterm.font("Consolas", { weight = 'Bold' }),
      font_size = 12,
   },
   automatically_reload_config = true,
   inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
   -- window_background_opacity = 0.9,
   
   window_close_confirmation = "NeverPrompt",

   -- keybindings
   disable_default_key_bindings = true,
   keys = keybindings,

   -- mousebindings
   mouse_bindings = {
      -- Ctrl-click will open the link under the mouse cursor
      {
         event = { Up = { streak = 1, button = "Left" } },
         mods = "CTRL",
         action = wezterm.action.OpenLinkAtMouseCursor,
      },
	  	{

			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = wezterm.action({
				CompleteSelectionOrOpenLinkAtMouseCursor = "Clipboard",
			}),
		},
   },


   -- shells
   default_prog = shell,
   launch_menu = launch_menu,

   -- ssh
   ssh_domains = ssh_domains,
}

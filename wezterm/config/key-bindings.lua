--[[
Author: zhubin
Date: 2023-04-12 09:10:15
FilePath: \wezterm\config\key-bindings.lua
Description: 

Copyright (c) 2023 by ${git_name}, All Rights Reserved. 
--]]
local wezterm = require("wezterm")

return {

   {
      key = [[\]],
      mods = "CTRL",
      action = wezterm.action({
         SplitVertical = { domain = "CurrentPaneDomain" },
      }),
   },
   {
      key = "q",
      mods = "CTRL",
      action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
   },
   {
      key = "h",
      mods = "CTRL|ALT",
      action = wezterm.action({ ActivatePaneDirection = "Left" }),
   },
   {
      key = "l",
      mods = "CTRL|ALT",
      action = wezterm.action({ ActivatePaneDirection = "Right" }),
   },
   {
      key = "k",
      mods = "CTRL|ALT",
      action = wezterm.action({ ActivatePaneDirection = "Up" }),
   },
   {
      key = "j",
      mods = "CTRL|ALT",
      action = wezterm.action({ ActivatePaneDirection = "Down" }),
   },
   {
      key = "h",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
   },
   {
      key = "l",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
   },
   {
      key = "k",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
   },
   {
      key = "j",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
   },
   {
      key = "w",
      mods = "CTRL|ALT",
      action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
   },
   {
      key = "Tab",
      mods = "CTRL",
      action = wezterm.action({ ActivateTabRelative = 1 }),
   },
   {
      key = "Tab",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ ActivateTabRelative = -1 }),
   }, -- standard copy/paste bindings
   {
      key = "x",
      mods = "CTRL",
      action = "ActivateCopyMode",
   },
   {
      key = "v",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ PasteFrom = "Clipboard" }),
   },
   {
      key = "c",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
   },
   {
      key = "F",
      mods = "SHIFT|CTRL",
      action = wezterm.action.Search({ CaseInSensitiveString = "" }),
   },
   {
      key = "x",
      mods = "CTRL|SHIFT",
      action = wezterm.action_callback(function(win, pane)
         wezterm.background_child_process({
            "pwsh",
            "-c",
            "x11",
         })
      end),
   },
}

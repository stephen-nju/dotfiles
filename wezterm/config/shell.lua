--[[
Author: zhubin
Date: 2023-04-12 09:10:15
FilePath: \wezterm\config\shell.lua
Description: 

Copyright (c) 2023 by ${git_name}, All Rights Reserved. 
--]]
local get_os_name = require("utils.get_os_name")

if get_os_name.get_os_name() == "Windows" then
   return { "pwsh" }
else
   return { "fish" }
end

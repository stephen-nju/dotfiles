--[[
Author: zhubin
Date: 2023-04-03 11:45:18
FilePath: \nvim\lua\user\lsp\settings\python-lsp-server.lua
Description: 

Copyright (c) 2023 by ${git_name}, All Rights Reserved. 
--]]

return {
    settings = {
        pylsp = {
            plugins = {
              pycodestyle = {
                ignore = {'W391'},
                maxLineLength = 120
              },
			  rope_autoimport={
			  enabled=true
			  }
            }
          }

    },
  }

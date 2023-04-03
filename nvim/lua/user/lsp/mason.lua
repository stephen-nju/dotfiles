--[[
Author: zhubin
Date: 2023-04-03 09:18:28
FilePath: \nvim\lua\user\lsp\mason.lua
Description: 

Copyright (c) 2023 by ${git_name}, All Rights Reserved. 
--]]
local servers = {
  -- clangd = {},
  -- gopls = {},
  --pyright = {}  
  -- rust_analyzer = {},
  -- tsserver = {},

  -- sumneko_lua = {
    -- Lua = {
      -- workspace = { checkThirdParty = false },
      -- telemetry = { enable = false },
    -- },
  -- },
}


local settings = {
	ui = {
		border = "none",
	},
	
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)

require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = false,
})

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end


-- setup_handers :Registers the provided {handlers}, to be called by mason when an installed server supported by lspconfig is ready to be set up.
-- 统一mason调用已安装的服务，类似get installed server
mason_lspconfig.setup_handlers {
  function(server_name)
    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server_name)
    require('lspconfig')[server_name].setup {
      capabilities = require("user.lsp.handlers").capabilities,
      on_attach = require("user.lsp.handlers").on_attach,
      settings = conf_opts,
    }
  end,
}



--local opts = {}

--for _, server in pairs(servers) do
--	opts = {
--		on_attach = require("user.lsp.handlers").on_attach,
--		capabilities = require("user.lsp.handlers").capabilities,
--	}
--
--	server = vim.split(server, "@")[1]
--
--	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
--	if require_ok then
--		opts = vim.tbl_deep_extend("force", conf_opts, opts)
--	end
--
--	lspconfig[server].setup(opts)
--end
--
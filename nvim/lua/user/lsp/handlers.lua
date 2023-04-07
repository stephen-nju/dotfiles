local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = fasle, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end



local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "<leader>fm", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
	keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	
end

local function diagnose_keymap(_, bufnr)
    vim.keymap.set({ "n" }, "]d", vim.diagnostic.goto_next, { buffer = bufnr })
    vim.keymap.set({ "n" }, "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
    if OK_TELESCOPE then
        vim.keymap.set(
            { "n" },
            "<leader>df",
            "<Cmd>Telescope diagnostics<Cr>",
            { buffer = bufnr }
        )
        vim.keymap.set({ "n" }, "<leader>lds", function()
            TELESCOPE_BUILTIN.lsp_document_symbols()
        end, { buffer = bufnr })
        vim.keymap.set({ "n" }, "<leader>ldw", function()
            TELESCOPE_BUILTIN.lsp_dynamic_workspace_symbols()
        end, { buffer = bufnr })
    end
end

local function set_autocmds(client, _) -- (client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        local group = vim.api.nvim_create_augroup(
            "lsp_document_highlight",
            { clear = true }
        )
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
            group = group,
            buffer = 0,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved" }, {
            group = group,
            buffer = 0,
            callback = vim.lsp.buf.clear_references,
        })
    end
end


M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.documentFormattingProvider = false
	end
	--设置不同的map
	lsp_keymaps(bufnr)

	set_autocmds(client,bufnr)
	
	diagnose_keymap(client,bufnr)
	
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
	  -- Create a command `:Format` local to the LSP buffer
--	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--		vim.lsp.buf.format()
--	  end, { desc = 'Format current buffer with LSP' })
end



return M

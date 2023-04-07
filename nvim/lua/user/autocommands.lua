-- Set syntax/indents for non-standard file types
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.pyi', command = 'set syntax=python'})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.sk', command = 'set syntax=skull filetype=skull'})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.test', command = 'set syntax=mypyc_test_cases filetype=mypyc_test_cases'})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.c', command = 'set syntax=c filetype=c'})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.h', command = 'set syntax=c filetype=c'})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.ll', command = 'set syntax=llvm filetype=llvm'})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = 'Dockerfile.*', command = 'set syntax=dockerfile filetype=dockerfile'})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {pattern = '*.py', command = 'set commentstring=#\\ %s'})


local change_cwd_to_curr_file = vim.api.nvim_create_augroup(
    "au_all_files",
    { clear = true }
)
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = change_cwd_to_curr_file,
    pattern = "*",
    command = "lcd %:p:h",
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Save when exiting insert mode
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
        pattern = { "*" },
        command = "silent! wall",
        nested = true,
    })
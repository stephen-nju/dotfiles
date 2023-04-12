-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'find files' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'find help' })
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').grep_string, { desc = 'find string' })
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').live_grep, { desc ='find char' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'find diagnostics' })
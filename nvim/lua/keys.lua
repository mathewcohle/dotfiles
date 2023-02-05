local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- [[ FZF ]]
map('n', '<C-p>', ':Files<CR>', opts)
map('n', '<C-b>', ':Buffers<CR>', opts)
map('n', '<Leader>fc', ':Commits<CR>', opts)
map('n', '<Leader>fb', ':BCommits<CR>', opts)
map('n', '<Leader>ft', ':Tags<CR>', opts)

-- [[Buffers]]
map('n', '<Leader>q', '<cmd>quit<cr>', {desc = 'Quit'})
map('n', '<Leader>w', '<cmd>write<cr>', {desc = 'Write'})

-- [[Movement]]
--              [[Windows]]
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)


-- [[LSP]]
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

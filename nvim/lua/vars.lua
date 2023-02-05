local g = vim.g

--[[ vars.lua ]]
g.t_co = 256
g.background = "dark"

-- Update the packpath
local packer_path = vim.fn.stdpath('config') .. '/site'
vim.o.packpath = vim.o.packpath .. ',' .. packer_path 

-- FZF
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git" '

g.fzf_buffers_jump = true
-- g.fzf_tags_command = 'ctags -R .'
g.fzf_layout = {window={width=0.9, height=0.8}}


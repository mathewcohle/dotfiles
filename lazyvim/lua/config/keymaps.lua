-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Remove default mappings
vim.api.nvim_del_keymap("n", "<leader>qq")
vim.api.nvim_del_keymap("n", "<leader>ww")
vim.api.nvim_del_keymap("n", "<leader>wd")
vim.api.nvim_del_keymap("n", "<leader>w-")
vim.api.nvim_del_keymap("n", "<C-s>")
vim.api.nvim_del_keymap("i", "<C-s>")
vim.api.nvim_del_keymap("x", "<C-s>")
vim.api.nvim_del_keymap("s", "<C-s>")

-- Define new mappings
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Files" })
map("n", "<C-b>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })

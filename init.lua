-- init.lua n(eo)vim config file

-- Set global variables
vim.g.mapleader = " " -- set <leader> to space bar

-- Set vim options
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.hlsearch = true

-- Set keymaps
-- vim.api.nvim_set_keymap("n", "<leader>", "<Plug>(easymotion-bd-jk)", { noremap = true })
vim.keymap.set("i", "jk", "<esc>", { silent = true })  -- sets noremap automatically


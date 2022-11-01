-- settings configuration for nvim

-- Set global variables
vim.g.mapleader = " "

-- Set vim options
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- Set keymaps
vim.api.nvim_set_keymap("n", "<leader>", "<Plug>(easymotion-bd-jk)", { noremap = true })
vim.keymap.set("i", "kj", "<esc>", { silent = true })  -- sets noremap automatically


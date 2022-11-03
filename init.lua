-- init.lua n(eo)vim config file

-- inspired by https://github.com/ojroques/dotfiles/blob/master/nvim/.config/nvim/init.lua


-------------------- INIT ----------------------------------
local fmt = string.format
local paq_dir = fmt('%s/site/pack/paqs/start/paq-nvim', vim.fn.stdpath('data'))
if vim.fn.empty(vim.fn.glob(paq_dir)) > 0 then
  vim.api.nvim_echo({{'Paq package manager is being installed'}}, false, {})
  vim.fn.system {'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', paq_dir}
  return
end

-------------------- PLUGINS -------------------------------
require 'paq' {
--  {'hrsh7th/cmp-buffer'};
--  {'hrsh7th/cmp-nvim-lsp'};
--  {'hrsh7th/cmp-omni'};
--  {'hrsh7th/cmp-path'};
--  {'hrsh7th/nvim-cmp'};
--  {'junegunn/fzf'};
--  {'junegunn/fzf.vim'};
--  {'kylechui/nvim-surround'};
--  {'l3mon4d3/luasnip'};
--  {'lervag/vimtex'};
  {'lukas-reineke/indent-blankline.nvim'};
--  {'navarasu/onedark.nvim'};
  {'ellisonleao/gruvbox.nvim'};
  -- {'neovim/nvim-lspconfig'};
  {'nvim-treesitter/nvim-treesitter'};
  {'nvim-treesitter/nvim-treesitter-context'};
  {'nvim-treesitter/nvim-treesitter-textobjects'};
  {'savq/paq-nvim'};
--  {'tpope/vim-unimpaired'};
  {'nvim-lualine/lualine.nvim'};
  {'kyazdani42/nvim-web-devicons'};  -- required for lauline
}

-------------------- PLUGIN SETUP --------------------------
---- fzf and fzf.vim
--vim.g['fzf_action'] = {['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit'}
--vim.g['fzf_layout'] = {window = {width = 0.8, height = 0.8}}
--vim.g['fzf_preview_window'] = {'up:50%:+{2}-/2', 'ctrl-/'}
--vim.keymap.set('n', '<leader>/', '<cmd>History/<CR>')
--vim.keymap.set('n', '<leader>;', '<cmd>History:<CR>')
--vim.keymap.set('n', '<leader>f', '<cmd>Files<CR>')
--vim.keymap.set('n', '<leader>r', '<cmd>Rg<CR>')
--vim.keymap.set('n', 's', '<cmd>Buffers<CR>')

-- indent-blankline.nvim
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

-- -- nvim-cmp
-- local cmp = require('cmp')
-- local menu = {buffer = '[Buf]', nvim_lsp = '[LSP]', omni = '[Omni]', path = '[Path]'}
-- local widths = {abbr = 80, kind = 40, menu = 40}
-- cmp.setup {
--   completion = {keyword_length = 2},
--   formatting = {
--     format = function(entry, item)
--       item.menu = item.menu or menu[entry.source.name]
--       for k, width in pairs(widths) do
--         if #item[k] > width then item[k] = fmt('%s...', string.sub(item[k], 1, width)) end
--       end
--       return item
--     end,
--   },
--   mapping = {
--     ['<Tab>'] = function(fb) if cmp.visible() then cmp.select_next_item() else fb() end end,
--     ['<S-Tab>'] = function(fb) if cmp.visible() then cmp.select_prev_item() else fb() end end,
--   },
--   preselect = require('cmp.types').cmp.PreselectMode.None,
--   snippet = {expand = function(args) require('luasnip').lsp_expand(args.body) end},
--   sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'omni'}, {name = 'path'}, {name = 'buffer'}}),
-- }
--
-- nvim-surround
-- require('nvim-surround').setup {}
-- nvim-treesitter-context
require('treesitter-context').setup {mode = 'topline'}

-- -- onedark.nvim
-- local colors = require('onedark.palette').dark
-- require('onedark').setup {
--   code_style = {comments = 'none'},
--   highlights = {TreesitterContext = {bg = colors.bg1, fmt = 'italic'}},
-- }
-- require('onedark').load()

-- gruvbox.nvim theme
require('gruvbox').setup()
vim.cmd("colorscheme gruvbox")

-- -- vimtex
-- vim.g['vimtex_quickfix_mode'] = false
-- -- lualine.nvim
  require('lualine').setup {
    options = {
      theme = 'gruvbox'
    }
  }

-------------------- OPTIONS -------------------------------
local indent, width = 2, 80
-- vim.opt.colorcolumn = tostring(width)   -- Line length marker
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}  -- Completion options
vim.opt.cursorline = true               -- Highlight cursor line
vim.opt.expandtab = true                -- Use spaces instead of tabs
vim.opt.ignorecase = true               -- Ignore case
-- vim.opt.inccommand = ''                 -- Disable substitution preview
vim.opt.list = true                     -- Show invisible characters
vim.opt.mouse = ''                      -- Disable mouse
vim.opt.number = true                   -- Show line numbers
vim.opt.pumheight = 12                  -- Max height of pop-up menu
vim.opt.relativenumber = true           -- Show relative line numbers
vim.opt.scrolloff = 6                   -- Lines of context
vim.opt.shiftround = true               -- Round indent
vim.opt.shiftwidth = indent             -- Size of an indent
vim.opt.sidescrolloff = 12              -- Columns of context
vim.opt.smartcase = true                -- Do not ignore case with capitals
vim.opt.smartindent = true              -- Insert indents automatically
vim.opt.splitbelow = true               -- Put new windows below current
vim.opt.splitright = true               -- Put new windows right of current
vim.opt.tabstop = indent                -- Number of spaces tabs count for
vim.opt.termguicolors = true            -- True color support
vim.opt.textwidth = width               -- Maximum width of text
-- vim.opt.updatetime = 100                -- Delay before swap file is saved
-- vim.opt.wildmode = {'list:longest'}     -- Command completion options
vim.opt.wrap = true                     -- enable line wrap

-------------------- KEYMAPS -------------------------------
-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal mode settings --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
-- keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
-- keymap("v", "p", '"_dP', opts)

-- Insert mode settings --
-- Press jk to return to normal mode
keymap("i", "jk", "<ESC>", opts)

-------------------- TREE-SITTER ---------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = {"c", "lua", "go", "help"},
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


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
  {'neovim/nvim-lspconfig'};
  {'hrsh7th/cmp-buffer'};
  {'hrsh7th/cmp-nvim-lsp'};
  {'hrsh7th/cmp-omni'};
  {'hrsh7th/cmp-path'};
  {'hrsh7th/nvim-cmp'};
  {'nvim-lua/plenary.nvim'};
  {'nvim-telescope/telescope.nvim'};
--  {'junegunn/fzf'};
--  {'junegunn/fzf.vim'};
  {'kylechui/nvim-surround'};
  {'l3mon4d3/luasnip'};
  {'saadparwaiz1/cmp_luasnip'};
--  {'lervag/vimtex'};
  {'folke/which-key.nvim'};
  {'lukas-reineke/indent-blankline.nvim'};
--  {'navarasu/onedark.nvim'};
  {'mickael-menu/zk-nvim'};
  {'ellisonleao/gruvbox.nvim'};
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

-- which-key.nvim
require("which-key").setup {
    plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  }, 
}

-- Telescope config
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
  --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}


-- indent-blankline.nvim
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

-- zk-nvim
require("zk").setup({
  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope" or "fzf"
  picker = "telescope",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

-- nvim-cmp
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
      }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- nvim-surround
require('nvim-surround').setup {}
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
vim.o.background = "dark" -- "dark" or "light" for mode
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

-- Close buffers
-- keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
-- keymap("v", "p", '"_dP', opts)

-- Insert mode settings --
-- Press jk to return to normal mode
keymap("i", "jk", "<ESC>", opts)

-- which-key mappings
local wk = require("which-key")

-------------------- TREE-SITTER ---------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = {"c", "lua", "toml", "yaml", "markdown", "markdown-inline", "go", "help"},
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

-------------------- LSP CONFIG ----------------------------
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['golangci_lint_ls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['markdown'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['toml'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}


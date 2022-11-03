-- init.lua n(eo)vim config file

-- inspired by https://github.com/ojroques/dotfiles/blob/master/nvim/.config/nvim/init.lua

require "keymaps"

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
  {'hrsh7th/cmp-buffer'};
  {'hrsh7th/cmp-nvim-lsp'};
  {'hrsh7th/cmp-omni'};
  {'hrsh7th/cmp-path'};
  {'hrsh7th/nvim-cmp'};
  {'junegunn/fzf'};
  {'junegunn/fzf.vim'};
  {'kylechui/nvim-surround'};
  {'l3mon4d3/luasnip'};
  {'lervag/vimtex'};
  {'lukas-reineke/indent-blankline.nvim'};
  {'navarasu/onedark.nvim'};
  {'neovim/nvim-lspconfig'};
  {'nvim-treesitter/nvim-treesitter'};
  {'nvim-treesitter/nvim-treesitter-context'};
  {'nvim-treesitter/nvim-treesitter-textobjects'};
  {'savq/paq-nvim'};
  {'tpope/vim-unimpaired'};
  {'nvim-lualine/lualine.nvim'};
  {'kyazdani42/nvim-web-devicons'};
}

-------------------- PLUGIN SETUP --------------------------
-- fzf and fzf.vim
vim.g['fzf_action'] = {['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit'}
vim.g['fzf_layout'] = {window = {width = 0.8, height = 0.8}}
vim.g['fzf_preview_window'] = {'up:50%:+{2}-/2', 'ctrl-/'}
vim.keymap.set('n', '<leader>/', '<cmd>History/<CR>')
vim.keymap.set('n', '<leader>;', '<cmd>History:<CR>')
vim.keymap.set('n', '<leader>f', '<cmd>Files<CR>')
vim.keymap.set('n', '<leader>r', '<cmd>Rg<CR>')
vim.keymap.set('n', 's', '<cmd>Buffers<CR>')
-- indent-blankline.nvim
require('indent_blankline').setup {char = '┊'}
-- nvim-cmp
local cmp = require('cmp')
local menu = {buffer = '[Buf]', nvim_lsp = '[LSP]', omni = '[Omni]', path = '[Path]'}
local widths = {abbr = 80, kind = 40, menu = 40}
cmp.setup {
  completion = {keyword_length = 2},
  formatting = {
    format = function(entry, item)
      item.menu = item.menu or menu[entry.source.name]
      for k, width in pairs(widths) do
        if #item[k] > width then item[k] = fmt('%s...', string.sub(item[k], 1, width)) end
      end
      return item
    end,
  },
  mapping = {
    ['<Tab>'] = function(fb) if cmp.visible() then cmp.select_next_item() else fb() end end,
    ['<S-Tab>'] = function(fb) if cmp.visible() then cmp.select_prev_item() else fb() end end,
  },
  preselect = require('cmp.types').cmp.PreselectMode.None,
  snippet = {expand = function(args) require('luasnip').lsp_expand(args.body) end},
  sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'omni'}, {name = 'path'}, {name = 'buffer'}}),
}
-- nvim-surround
require('nvim-surround').setup {}
-- nvim-treesitter-context
require('treesitter-context').setup {mode = 'topline'}
-- onedark.nvim
local colors = require('onedark.palette').dark
require('onedark').setup {
  code_style = {comments = 'none'},
  highlights = {TreesitterContext = {bg = colors.bg1, fmt = 'italic'}},
}
require('onedark').load()
-- vimtex
vim.g['vimtex_quickfix_mode'] = false
-- lualine.nvim
require('lualine').setup {
  options = { theme = 'onedark' }
}

-------------------- OPTIONS -------------------------------
local indent, width = 2, 80
vim.opt.colorcolumn = tostring(width)   -- Line length marker
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}  -- Completion options
vim.opt.cursorline = true               -- Highlight cursor line
vim.opt.expandtab = true                -- Use spaces instead of tabs
vim.opt.ignorecase = true               -- Ignore case
vim.opt.inccommand = ''                 -- Disable substitution preview
vim.opt.list = true                     -- Show invisible characters
vim.opt.mouse = ''                      -- Disable mouse
vim.opt.number = true                   -- Show line numbers
vim.opt.pumheight = 12                  -- Max height of pop-up menu
vim.opt.relativenumber = true           -- Show relative line numbers
vim.opt.report = 0                      -- Always report changed lines
vim.opt.scrolloff = 6                   -- Lines of context
vim.opt.shiftround = true               -- Round indent
vim.opt.shiftwidth = indent             -- Size of an indent
vim.opt.shortmess = 'atToOFc'           -- Prompt message options
vim.opt.sidescrolloff = 12              -- Columns of context
vim.opt.signcolumn = 'yes'              -- Show sign column
vim.opt.smartcase = true                -- Do not ignore case with capitals
vim.opt.smartindent = true              -- Insert indents automatically
vim.opt.splitbelow = true               -- Put new windows below current
vim.opt.splitright = true               -- Put new windows right of current
vim.opt.tabstop = indent                -- Number of spaces tabs count for
vim.opt.termguicolors = true            -- True color support
vim.opt.textwidth = width               -- Maximum width of text
vim.opt.updatetime = 100                -- Delay before swap file is saved
vim.opt.wildmode = {'list:longest'}     -- Command completion options
vim.opt.wrap = false                    -- Disable line wrap

-------------------- LSP -----------------------------------
local cmp_cap = require('cmp_nvim_lsp').default_capabilities()
for _, ls in ipairs({'bashls', 'clangd', 'gopls', 'pylsp'}) do
  require('lspconfig')[ls].setup {capabilities = cmp_cap}
end
vim.keymap.set('n', '<space>,', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<space>;', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action)
vim.keymap.set('n', '<space>d', vim.lsp.buf.definition)
vim.keymap.set('n', '<space>f', vim.lsp.buf.format)
vim.keymap.set('n', '<space>h', vim.lsp.buf.hover)
vim.keymap.set('n', '<space>i', vim.lsp.buf.implementation)
vim.keymap.set('n', '<space>m', vim.lsp.buf.rename)
vim.keymap.set('n', '<space>r', vim.lsp.buf.references)
vim.keymap.set('n', '<space>s', vim.lsp.buf.document_symbol)

-------------------- TREE-SITTER ---------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = {"c", "lua", "go", "help"},
  highlight = {enable = true},
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['aa'] = '@parameter.outer', ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer', ['if'] = '@function.inner',
      },
    },
    move = {
      enable = true,
      goto_next_start = {[']a'] = '@parameter.inner', [']f'] = '@function.outer'},
      goto_previous_start = {['[a'] = '@parameter.inner', ['[f'] = '@function.outer'},
    },
  },
}



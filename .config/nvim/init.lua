-- General settings
vim.o.mouse = ""
vim.o.colorcolumn = "80"
vim.o.title = true

-- Formatting and wrapping of comments
vim.o.textwidth = 80
vim.o.formatoptions = "qjcn"

-- Allow unsaved changes in non-open windows
vim.o.hidden = true

-- Yank to and put from system clipboard
vim.o.clipboard = "unnamed"

-- Indentation!
-- Copy the previous indentation on autoindenting
vim.o.copyindent = true

-- Show trailing whitespace
vim.o.list = true
vim.o.listchars="tab:»·,trail:·"

vim.o.wildmode = "longest,list,full"

-- Use , as the leader key (must happen before plugin init)
vim.g.mapleader = ","

-- Bind "q" to close a quickfix window
vim.cmd[[autocmd BufWinEnter quickfix nnoremap <buffer> q :cclose<CR>]]

-- Allow for persistent undo
vim.o.undofile = true

-- Smart search (i.e. ignore case if no upper case characters)
vim.o.ignorecase = true
vim.o.smartcase = true

--------------------------------------------------------------------------------
---- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Colorscheme
vim.cmd.colorscheme "onelight"

-- Set <leader> key
vim.g.mapleader = " "

-- Core settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("config") .. "/undodir"
vim.fn.mkdir(vim.opt.undodir:get()[1], "p")

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Nerd Font toggle
vim.g.have_nerd_font = false

-- Lazy.nvim setup with custom icons
require("lazy").setup("plugins", {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Copy and paste
map('v', '<C-c>', '"+y', opts)         -- Ctrl+C: copy selected
map('v', '<C-v>', '"+p', opts)         -- Ctrl+V in visual mode, Ctrl+Shift+V in insert mode

-- File explorer toggle
map('n', '<C-d>', '<cmd>NvimTreeToggle<CR>', opts)

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)

-- Clear search highlight
map('n', '<Esc><Esc>', ':nohlsearch<CR>', opts)

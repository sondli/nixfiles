local opt = vim.opt

-- Appearance
opt.termguicolors = true
opt.scrolloff = 8
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false
opt.guicursor = "n-v-c-i:block"
opt.signcolumn = "yes"
opt.colorcolumn = "120"
opt.conceallevel = 0
opt.background = "dark"
opt.winborder = "rounded"

-- Splits
opt.splitbelow = true
opt.splitright = true
opt.winwidth = 10
opt.winminwidth = 10
opt.equalalways = false

-- Search
opt.hlsearch = false
opt.incsearch = true

-- Indentation
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Misc
opt.autoread = true
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.clipboard = "unnamed"
opt.visualbell = true
opt.errorbells = false

local opt = vim.opt

-- Basic settings
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 8

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Visual settings
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.completeopt = "menuone,noinsert,noselect"
opt.showmode = false
opt.pumheight = 10
opt.pumblend = 10

-- File handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true -- Neovim handles the directory automatically now
opt.updatetime = 300
opt.timeoutlen = 500
opt.ttimeoutlen = 0
opt.autoread = true

-- Behavior settings
opt.hidden = true
opt.backspace = "indent,eol,start"
opt.iskeyword:append("-")
opt.mouse = "a"
opt.clipboard:append("unnamedplus")

-- Folding settings (Driven by Treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- Split behavior
opt.splitbelow = true
opt.splitright = true

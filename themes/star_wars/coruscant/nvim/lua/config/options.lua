local opt = vim.opt

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.shiftround = true
opt.smartindent = true
opt.virtualedit = "block"
opt.undofile = true
opt.undolevels = 10000
opt.autowrite = true
opt.confirm = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.grepprg = "rg --vimgrep"

-- Interface
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.linebreak = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.smoothscroll = true
opt.list = true
opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
opt.laststatus = 3
opt.showmode = false
opt.pumheight = 10
opt.conceallevel = 2
opt.winborder = "single"
opt.winminwidth = 5

-- Windows
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

-- Folds use treesitter when a parser is available
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.foldlevel = 99

-- Behaviour
opt.timeoutlen = 300
opt.updatetime = 200
opt.jumpoptions = "view"
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.formatoptions = "jcroqlnt"
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Share the system clipboard (deferred: starting the provider is slow)
vim.schedule(function() opt.clipboard = "unnamedplus" end)

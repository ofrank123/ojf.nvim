-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.rnu = true

vim.opt.cindent = true
vim.opt.cino="(0,w1,l1,Ws"

vim.opt.wrap = true

-- Backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Nice Colors :)
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50 -- ~.* Fast *.~

-- Popups
vim.opt.pumheight = 7

-- Leader key
vim.g.mapleader = " "

-- reload files when changed on disk
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.cmd([[autocmd FileType * set formatoptions-=ro]])

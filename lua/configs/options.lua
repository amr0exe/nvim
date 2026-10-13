-- gutter space
vim.opt.signcolumn = "yes"

-- mouse support
vim.opt.mouse = 'a'

-- tab-indent
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- indent-helpers
vim.opt.autoindent = true

-- fix for nonewline errors
vim.opt.fixendofline = true
vim.opt.endofline = true
vim.opt.binary = false
vim.opt.fillchars = ({ eob = "." })

-- fix for one yank == one paste
--vim.keymap.set('x', 'p', '"_dP"')

-- misc
vim.opt.smoothscroll = true
vim.opt.winborder = "rounded"
vim.opt.swapfile = false

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

-- put statusline at top: filename + diagnostic counts (configs/winbar.lua)
vim.opt.winbar = [[%{%v:lua.require'configs.winbar'.render()%}]]
-- hide the bottom statusline
vim.opt.laststatus = 0
-- hide the bottom command-line row when idle
vim.opt.cmdheight = 0

-- fix for one yank == one paste
--vim.keymap.set('x', 'p', '"_dP"')

-- misc
vim.opt.smoothscroll = true
vim.opt.winborder = "rounded"
vim.opt.swapfile = false

-- Ghostty config syntax highlighting
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*/ghostty/config", "ghostty/config" },
    callback = function()
        vim.bo.filetype = "conf"
    end,
})

-- split separator
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ff6600", bg = "NONE" })
    end,
})
vim.opt.fillchars = { vert = "#" }

-- set the leader key to space
vim.g.mapleader = " "

-- for <Esc> to jj 
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

-- for closing buffer with <leader>x
-- bp switches the window to previous buffer
-- | chains command, 
-- bd # deletes the buffer that used to be on this window
vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>bp | bd #<CR>", { noremap = true, silent = true })

-- move between buffers
vim.keymap.set('n', '<tab>', ':bnext<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<s-tab>', ':bprevious<cr>', { noremap = true, silent = true })

-- for errors/hover
vim.keymap.set("n", "E", function()
    vim.diagnostic.open_float()
end, { noremap = true, silent = true, desc = "Show diagnostics info" }
)

-- LSP restart(ts_ls)
vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart ts_ls<CR>", {
  desc = "Restart ts_ls LSP server"
})

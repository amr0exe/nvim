local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
    {
        "kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            })
        end
    }
})

-- for moving between buffers
vim.keymap.set("n", "<TAB>", function ()
    vim.fn.VSCodeNotify("workbench.action.nextEditor")
end, { silent = true })

vim.keymap.set("n", "<S-TAB>", function ()
    vim.fn.VSCodeNotify("workbench.action.previousEditor")
end, { silent = true })

-- for accepting suggestions
vim.keymap.set("i", "<C-l>", function ()
   vim.fn.VSCodeNotify("editor.action.inlineSuggest.commit")
end, { silent = true })

-- Top window bar: filename + live LSP diagnostic counts.
-- Referenced from options.lua via vim.opt.winbar.

local M = {}

local severities = {
    { level = vim.diagnostic.severity.ERROR, hl = "DiagnosticError", label = "E" },
    { level = vim.diagnostic.severity.WARN,  hl = "DiagnosticWarn",  label = "W" },
    { level = vim.diagnostic.severity.INFO,  hl = "DiagnosticInfo",  label = "I" },
    { level = vim.diagnostic.severity.HINT,  hl = "DiagnosticHint",  label = "H" },
}

function M.render()
    local buf = vim.api.nvim_get_current_buf()
    local counts = vim.diagnostic.count(buf)

    local parts = { "%f %m" }
    local diag = {}
    for _, s in ipairs(severities) do
        local n = counts[s.level]
        if n and n > 0 then
            table.insert(diag, ("%%#%s# %s:%d "):format(s.hl, s.label, n))
        end
    end

    if #diag > 0 then
        table.insert(parts, "%=")
        table.insert(parts, table.concat(diag, ""))
    end

    return table.concat(parts, " ")
end

return M

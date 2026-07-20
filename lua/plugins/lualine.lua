return {
    {
        "nvim-lualine/lualine.nvim",
        enabled = false,
        config = function()
            require("lualine").setup({
                options = {
                    theme = "iceberg_dark",
                    section_separators = {'|', '|'},
                    component_separators = {'|', '|'}
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch'},
                    lualine_c = {
                        { 'filename', path = 1},
                    },
                    lualine_x = {
                        'searchcount',
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            sections = { "error", "warn", "info", "hint" },
                            diagnostics_color = {
                                error = "DiagnosticError",
                                warn  = "DiagnosticWarn",
                                info  = "DiagnosticInfo",
                                hint  = "DiagnosticHint",
                            },
                            update_in_insert = false,
                            colored = true,
                        }
                    },
                    lualine_y = { 'filetype', 'location'},
                    lualine_z = { 'progress'}
                }
            })
        end
    }
}

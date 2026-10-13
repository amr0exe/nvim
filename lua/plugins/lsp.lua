return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ui = {
                border = "rounded",
            },
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = { "gopls" },
        },
    },

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    {
        "saghen/blink.cmp",
        version = "*", -- use the release tag, requires prebuilt binaries
        dependencies = "rafamadriz/friendly-snippets",
        opts = {
            keymap = {
                preset = "default",
                ["<C-l>"] = { "accept", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                documentation = { auto_show = true },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
        },
        opts_extend = { "sources.default" },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/lazydev.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)        -- go_to_def
                    vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts)      -- code_actions
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)    -- goto implementation
                    vim.keymap.set("n", "grr", vim.lsp.buf.references, opts)       -- references of used
                    vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)           -- rename symbol package project-wide
                    vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, opts) -- lsp-signature help from inside_function
                end
            })

            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            vim.lsp.enable({ "lua_ls", "gopls" })

            -- .tf detection is content-based (terraform vs TinyFugue), and oil opens new
            -- files empty, so the buffer gets "tf". Re-detect once there's content to write.
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = "*.tf",
                callback = function(args)
                    local ft = vim.filetype.match({ buf = args.buf, filename = vim.api.nvim_buf_get_name(args.buf) })
                    if ft and ft ~= vim.bo[args.buf].filetype then
                        vim.bo[args.buf].filetype = ft
                    end
                end,
            })
        end,
    },
}

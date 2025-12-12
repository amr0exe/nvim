return {
    -- Autocompletion
    { "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "L3MON4D3/LuaSnip" },
            -- Snippets
            { "rafamadriz/friendly-snippets" },
        }
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        event = "VeryLazy",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            local lsp = require("lsp-zero")

            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
            end)

            -- Setup Mason
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pylsp",
                    "prismals",
                    "gopls",
                    "rust_analyzer",
                    "ts_ls",
                },
                automatic_installation = true,
                handlers = {
                    -- Default handler for all servers
                    function(server_name)
                        require('lspconfig')[server_name].setup({
                            on_attach = lsp.on_attach,
                            capabilities = lsp.get_capabilities(),
                        })
                    end,
                    -- Custom handler for rust_analyzer
                    rust_analyzer = function()
                        require('lspconfig').rust_analyzer.setup({
                            on_attach = lsp.on_attach,
                            capabilities = lsp.get_capabilities(),
                            root_dir = require("lspconfig.util").root_pattern("Cargo.toml", "rust-project.json"),
                            settings = {
                                ["rust-analyzer"] = {
                                    cargo = {
                                        allFeatures = true,
                                    },
                                    check = {
                                        command = "clippy",
                                    },
                                    procMacro = {
                                        enable = true,
                                    },
                                },
                            },
                        })
                    end,
                    -- Custom handler for ts_ls
                    ts_ls = function()
                        require('lspconfig').ts_ls.setup({
                            on_attach = lsp.on_attach,
                            capabilities = lsp.get_capabilities(),
                            root_dir = function(fname)
                                local util = require("lspconfig.util")
                                return util.root_pattern('tsconfig.json', 'package.json')(fname) or
                                    util.root_pattern('.git')(fname) or
                                    util.path.dirname(fname)
                            end,
                            single_file_support = false,
                        })
                    end,
                    -- Custom handler for gopls
                    gopls = function()
                        require('lspconfig').gopls.setup({
                            on_attach = lsp.on_attach,
                            capabilities = lsp.get_capabilities(),
                            root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
                        })
                    end,
                }
            })

            -- Setup servers not managed by mason
            require('lspconfig').hls.setup({
                cmd = { "haskell-language-server-wrapper", "--lsp" },
                on_attach = lsp.on_attach,
                capabilities = lsp.get_capabilities(),
            })

            require('lspconfig').clangd.setup({
                on_attach = lsp.on_attach,
                capabilities = lsp.get_capabilities(),
            })

            -- Setup nvim-cmp
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    -- { name = "buffer" },
                    { name = "path" },
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
            cmp.setup.filetype({'markdown', 'txt'}, {
                sources = {
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                }
            })
        end,
    },
}

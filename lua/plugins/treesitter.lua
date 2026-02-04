return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            vim.filetype.add({
                extension = {
                    axaml = "xml",
                },
            })

            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "rust", "go", "javascript", "typescript", "html", "css", "bash", "tsx", "markdown", "markdown_inline", "xml" },
                highlight = { enable = true, disable = { "xml" } },
                indent = { enable = true },
            })

            vim.treesitter.language.register('xml', { 'axaml' })
        end,
    },
}

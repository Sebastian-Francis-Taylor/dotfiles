require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua", "java", "bash", "python" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { "latex" },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
            },
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
            },
        },
    },
}

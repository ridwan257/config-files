local config_opt = {
    ensure_installed = {
        "lua", "python", "bash", "cpp", "julia", "r",
        "json", "yaml", "markdown"
    },
    highlight = { enable = true },
    indent = {
        enable = true,
        disable = { "python", "yaml", "sh", "bash" }
    },

    -- visually select code based on its syntax tree
    incremental_selection = {
        enable = true,
        keymaps = {
        -- init_selection    = "<CR>",  -- start the selection
        node_incremental  = "<CR>",  -- expand the selection to a larger syntax node
        scope_incremental = "<TAB>", -- expand to next outer scope (e.g., from inside a loop to the whole loop)
        node_decremental  = "<BS>",  -- shrink the selection
        }
    }
}

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup(config_opt)
    end
}

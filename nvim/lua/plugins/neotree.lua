return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.keymap.set('n', '<C-t>', ':Neotree toggle filesystem left<CR>', { desc = 'Toggle Neotree on left' })
        -- vim.keymap.set('n', '<C-t>', ':Neotree filesystem reveal left<CR>', {})
        require("neo-tree").setup({
            window = {
                width = 25
            }
        })
    end
}

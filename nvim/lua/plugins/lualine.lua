local config_opt = {
    options = {
        theme = 'catppuccin'
    }

}

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup(config_opt)
    end
}

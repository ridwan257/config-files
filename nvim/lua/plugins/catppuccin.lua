local config_opt = {
	transparent_background = true
}


return{
	"catppuccin/nvim", 
	name = "catppuccin", 
	priority = 1000,
	config = function()
		require("catppuccin").setup(config_opt)

		-- vim.cmd("colorscheme catppuccin-mocha")
	end 
}
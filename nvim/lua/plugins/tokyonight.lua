local config_opt = {
	style = "night",            -- or "night", "day", "moon", "strom"
	transparent = true,
	terminal_colors = true,     -- Enable terminal colors
	styles = {
		sidebars = "transparent", -- Transparent sidebars like NvimTree
		floats = "transparent",   -- Transparent floating windows
	},
}


return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup(config_opt)
		
		-- vim.cmd("colorscheme tokyonight")
	end
}
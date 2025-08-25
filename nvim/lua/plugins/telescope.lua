local config_opt = {
	pickers = {
		colorscheme = {
			enable_preview = true,
		}
	}
}

return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require("telescope").setup(config_opt)

		local builtin = require("telescope.builtin")

		-- File finder
		vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Find files" })

		-- Optional live grep
		-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	end
}
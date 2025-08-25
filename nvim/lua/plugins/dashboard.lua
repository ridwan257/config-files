return {
	
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
	require('dashboard').setup {
	  theme = 'doom',
	  hide = {
        statusline = true,
        tabline = false,
        winbar = false,
      },
	  config = {
	  	vertical_center = true,
		header = {
		  "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
		  "████╗  ██║██║   ██║██║████╗ ████║",
		  "██╔██╗ ██║██║   ██║██║██╔████╔██║",
		  "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
		  "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
		  "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
		},
		center = {
		  {
			icon = '  ',
			desc = 'New file',
			action = 'enew',
			key = 'n',
		  },
		  {
			icon = '  ',
			desc = 'Browse files',
			action = 'Telescope find_files',
			key = 'f',
		  },
		  {
			icon = '  ',
			desc = 'Colorscheme',
			action = 'Telescope colorscheme',
			key = 'c',
		  },
		  {
			icon = '  ',
			desc = 'Recent files',
			action = 'Telescope oldfiles',
			key = 'r',
		  },
		  {
			icon = '  ',
			desc = 'Edit config',
			action = 'edit ~/.config/nvim/lua/plugins/dashboard.lua',
			key = 'e',
		  },
		  {
			icon = '󰿅  ',
			desc = 'Quit',
			action = 'qa',
			key = 'q',
		  },
		},

		footer = {
		  "⚡ Your Neovim. Your kingdom. 🔥",
		}
	  }
	}
  end
}

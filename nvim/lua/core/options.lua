local opt = vim.opt



------------------------------------------------------
-- apply transparency to colorscheme
------------------------------------------------------
--  "TabLineFill", "TabLine", "TabLineSel", "StatusLine", "Visual"
-- "CursorLine",  "VertSplit", "LineNr", "CursorLineNr", "Pmenu",
--  "WinBar", "SignColumn", "NormalFloat", "FloatBorder"
local transparent_groups = {
  "Normal", "NormalNC", "EndOfBuffer"
}

local transparent_themes = {
	["default"] = true,
	["darkblue"] = true,
	["blue"] = true
}

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local theme = vim.g.colors_name
    -- if transparent_themes[theme] then
    for _, group in ipairs(transparent_groups) do
      vim.api.nvim_set_hl(0, group, {  })
    end
    -- end
  end,
})

vim.cmd("colorscheme darkblue")
------------------------------------------------------
-- Setup Backup files
------------------------------------------------------
-- enable persistent undo
opt.undofile = true
opt.undodir = vim.fn.expand("~/.local/share/nvim/undo//")

-- enable backup and swap files
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- opt.backupdir = vim.fn.expand("~/.local/state/nvim/backup//")
-- opt.directory = vim.fn.expand("~/.local/state/nvim/swap//")



------------------------------------------------------
-- Setup Terminals
------------------------------------------------------
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.scrolloff = 0
    vim.opt_local.sidescrolloff = 0
    vim.opt_local.cursorline = false
    vim.cmd("setlocal winhighlight=Normal:Normal")
  end,
})



---------------- here most off the copied from
-- https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua

------------------------------------------------------
-- basics
------------------------------------------------------
opt.backspace = "indent,eol,start"		 -- backspace correction
opt.clipboard:append("unnamedplus") 	 -- use system clipboard as default register
opt.cursorline = true
opt.number = true                      -- show absolute number on current line
opt.relativenumber = true              -- show relative line numbers
opt.cursorline = true                  -- Highlight current line
opt.wrap = false                       -- Don't wrap lines
opt.scrolloff = 10                     -- Keep 10 lines above/below cursor 
opt.sidescrolloff = 8                  -- Keep 8 columns left/right of cursor
vim.g.mapleader = " "									 -- Set <leader> to space
vim.g.maplocalleader = " "             -- Set local leader key (NEW)
opt.mouse = "a"												 -- enable mouse in all modes


------------------------------------------------------
-- Cursor settings
------------------------------------------------------
-- opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait1000-blinkof700-blinkon500-Cursor/lCursor,sm:block-blinkwait400-blinkoff300-blinkon400"
-- opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait1000-blinkoff700-blinkon500-Cursor/lCursor,sm:block-blinkwait300-blinkoff250-blinkon300"
-- vim.api.nvim_set_hl(0, "CursorLine", { 
--   bg = "#3a3a3a",  -- your desired background color
--   blend = 90       -- 0 = opaque, 100 = fully transparent (depends on UI)
-- })

-- make cursor to default block
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.cmd("set guicursor=a:block")  -- Reset to block cursor on exit
    io.write("\27[2 q")                -- Properly write to stdout
    io.flush()
  end,
})

------------------------------------------------------
-- Indentation
------------------------------------------------------
opt.tabstop = 4                             -- Tab width
opt.shiftwidth = 4                          -- Indent width
opt.softtabstop = 4                         -- Soft tab stop
opt.expandtab = true                        -- Use spaces instead of tabs
opt.smartindent = true                      -- Smart auto-indenting
opt.autoindent = true                       -- Copy indent from current line

------------------------------------------------------
-- search settings
------------------------------------------------------
opt.ignorecase = true               -- Case insensitive search
opt.smartcase = true                -- Case sensitive if uppercase in search
opt.hlsearch = false                -- Don't highlight search results 
opt.incsearch = true                -- Highlight and jump to matches as you type your search


------------------------------------------------------
-- visual settings
------------------------------------------------------
opt.termguicolors = true                       -- Enable 24-bit colors
opt.signcolumn = "yes"                         -- Always show sign column
opt.colorcolumn = "100"                        -- Show column at 100 characters
opt.showmatch = true                           -- Highlight matching brackets
opt.matchtime = 2                              -- How long to show matching bracket; 0.2s delay for match highlight
opt.cmdheight = 1                              -- Command line height
-- code completion options
-- menuone → Show menu even if only 1 match
-- noinsert → Don’t auto-insert the first match
-- noselect → Don’t auto-select anything (you must explicitly choose)
opt.completeopt = "menuone,noinsert,noselect" 
opt.showmode = false                           -- Don't show mode in command line 
opt.pumheight = 10                             -- Popup menu height; 10 means slightly transparent.
opt.pumblend = 10                              -- Popup menu transparency; maximum number of autocomplete suggestions 
opt.winblend = 0                               -- Floating window transparency (e.g., LSP hover, Telescope preview); 0 = no transparency (fully opaque)
opt.conceallevel = 0                           -- Don't hide markup (for Markdown, JSON, LaTeX); 0 = don’t hide anything
opt.concealcursor = ""                         -- Don't hide cursor line markup 
opt.lazyredraw = true                          -- Don't redraw during macros
opt.synmaxcol = 300                            -- Syntax highlighting limit; Very long lines (like minified JSON or CSV) can slow Vim down



------------------------------------------------------
-- delay time to popups and keypress
------------------------------------------------------
vim.opt.updatetime = 300         -- how fast events like CursorHold or LSP diagnostics trigger; 300 ms
vim.opt.timeoutlen = 600         -- Wait 0.6 sec for next key in a mapping
vim.opt.ttimeoutlen = 0          -- Wait time for terminal key codes, like <Esc>
-- vim.opt.autoread = true          -- Auto reload files changed outside vim
vim.opt.autowrite = false        -- Don't auto save


------------------------------------------------------
-- Behavior settings
------------------------------------------------------
-- Allow hidden buffers
-- If true: Vim keeps the buffer “hidden” but loaded in memory when jump to another file with unsaved changes
-- If false: must save (:w) before switching files/buffers.
opt.hidden = true             				
opt.errorbells = false                  -- No error bells
opt.autochdir = false                   -- Don't auto change directory
-- treat dash as part of word
-- with this setting: "word-word" → treated as one word.
opt.iskeyword:append("-")               
-- opt.path:append("**")                   -- include subdirectories in search
-- Selection behavior
-- exclusive: don’t include the last character in visual selection
-- inclusive: include the last character under the cursor
opt.selection = "exclusive"             
opt.modifiable = true                   -- Allow buffer modifications
opt.encoding = "UTF-8"                  -- Set encoding


------------------------------------------------------
-- Code folding
------------------------------------------------------
opt.foldmethod = "expr"                             -- Use expression for folding
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
opt.foldlevel = 99                                  -- Start with all folds open


------------------------------------------------------
-- Split into panes
------------------------------------------------------
opt.splitbelow = true       -- Horizontal splits go below
opt.splitright = true       -- Vertical splits go right



------------------------------------------------------
-- Command-line completion
------------------------------------------------------
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })


------------------------------------------------------
-- Others
------------------------------------------------------
-- Better diff options
opt.diffopt:append("linematch:60")	-- improves diff accuracy by matching lines across blocks
opt.redrawtime = 10000					-- spend up to 10s rendering big files
opt.maxmempattern = 20000				-- regex use up to 20MB of memory











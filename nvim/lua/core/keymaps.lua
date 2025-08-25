slocal kmap = vim.keymap

kmap.set("i", '<C-s>', "<ESC>:w<CR>", {})
kmap.set("n", '<C-s>', ":w<CR>", {})

-- escape alternative
kmap.set("i", "jk", "<ESC>", {})

-- Clear highlights
kmap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Delete without yanking
kmap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Better J behavior
kmap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Center screen when jumping
kmap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
kmap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
kmap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
kmap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better indenting in visual mode
kmap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
kmap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Move lines up/down
kmap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
kmap.set("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
kmap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
kmap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })


------------------------------------------------------
-- tab management
------------------------------------------------------
kmap.set("n", "<leader>to", ":tabnew | Dashboard<CR>", { desc = "open new tab" })
kmap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "close current tab" })
kmap.set("n", "<leader>tn", ":tabn<CR>", { desc = "go to next tab" })
kmap.set("n", "<leader>tp", ":tabp<CR>", { desc = "go to prev tab" })
kmap.set("n", "<leader>tf", ":tabnew %<CR>", { desc = "duplicate tab" })
kmap.set('n', '<leader>tm', ':tabmove<CR>', { desc = 'Move tab' })
kmap.set('n', '<leader>t>', ':tabmove +1<CR>', { desc = 'Move tab right' })
kmap.set('n', '<leader>t<', ':tabmove -1<CR>', { desc = 'Move tab left' })

------------------------------------------------------
-- window management
------------------------------------------------------
-- window spliting and closing
kmap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
kmap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
kmap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
kmap.set("n", "<leader>wx", "<cmd>close<CR>", {desc = "Close current split" })

-- window navigation
kmap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
kmap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
kmap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
kmap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- window resizing
-- kmap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
-- kmap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
-- kmap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
-- kmap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })


















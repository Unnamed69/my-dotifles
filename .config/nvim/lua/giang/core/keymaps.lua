vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>1", "1gt", { desc = "Go to tab 1" }) -- go to tab 1
keymap.set("n", "<leader>2", "2gt", { desc = "Go to tab 2" }) -- go to tab 2
keymap.set("n", "<leader>3", "3gt", { desc = "Go to tab 3" }) -- go to tab 3
keymap.set("n", "<leader>4", "4gt", { desc = "Go to tab 4" }) -- go to tab 4
keymap.set("n", "<leader>5", "5gt", { desc = "Go to tab 5" }) -- go to tab 5
keymap.set("n", "<leader>6", "6gt", { desc = "Go to tab 6" }) -- go to tab 6
keymap.set("n", "<leader>7", "7gt", { desc = "Go to tab 7" }) -- go to tab 7
keymap.set("n", "<leader>8", "8gt", { desc = "Go to tab 8" }) -- go to tab 8
keymap.set("n", "<leader>9", "9gt", { desc = "Go to tab 9" }) -- go to tab 9
keymap.set("n", "<leader>0", ":tablast", { desc = "Go to last tab" }) -- go to tab 9

keymap.set("n", "U", "<C-R>", { desc = "Redo last change" })

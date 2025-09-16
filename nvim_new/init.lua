print("hello world")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.tabstop = 4

vim.opt.timeoutlen = 300
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.g.netrw_liststyle = 1 -- Use the long listing view

-- [[ Basic Keymaps ]]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})




-- [[ Packages ]]
vim.pack.add({ { src = "https://github.com/tpope/vim-fugitive"} })
vim.pack.add({ { src = "https://github.com/tpope/vim-vinegar"} })
vim.pack.add({ { src = "https://github.com/tpope/vim-unimpaired"} })
vim.pack.add({ { src = "https://github.com/tpope/vim-sleuth"} })

vim.pack.add({ { src = "https://github.com/ChrisBrowne/terminal-toggle.nvim"} })
require("terminal-toggle").setup()
vim.keymap.set({ "n", "t" }, "<C-z>", "<cmd>TerminalToggle<CR>", { desc = "Terminal toggle" })


vim.pack.add({ { src = "https://github.com/ibhagwan/fzf-lua" }, })
vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<CR>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>", { desc = "[S]earch [G]rep" })
vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua files<CR>", { desc = "[G]it [F]iles" })
vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua resume<CR>", { desc = "[S]earch [R]esume" })

vim.pack.add({ { src = "https://github.com/saghen/blink.cmp"} })
require('blink.cmp').setup({
		keymap = {
				preset = "default"
		}
})

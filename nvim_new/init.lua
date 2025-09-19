print("hello world")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
-- vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"
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

vim.opt.winborder = "rounded"

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

vim.g.netrw_liststyle = 1 -- Use the long listing view

vim.diagnostic.config({
  -- virtual_text = true,
  virtual_lines = { current_line = true },
})

-- [[ Basic Keymaps ]]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>")
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
local augroup = vim.api.nvim_create_augroup("chris.cfg", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Packages ]]
vim.pack.add({ { src = "https://github.com/folke/tokyonight.nvim" } })
require("tokyonight").setup({
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
})
vim.cmd.colorscheme("tokyonight-night")

vim.pack.add({ { src = "https://github.com/tpope/vim-fugitive" } })
vim.pack.add({ { src = "https://github.com/tpope/vim-vinegar" } })
vim.pack.add({ { src = "https://github.com/tpope/vim-unimpaired" } })
vim.pack.add({ { src = "https://github.com/tpope/vim-sleuth" } })
vim.pack.add({ { src = "https://github.com/j-hui/fidget.nvim" } })
require("fidget").setup({})

vim.pack.add({ { src = "https://github.com/ChrisBrowne/terminal-toggle.nvim" } })
require("terminal-toggle").setup()
vim.keymap.set({ "n", "t" }, "<C-z>", "<cmd>TerminalToggle<CR>", { desc = "Terminal toggle" })

vim.pack.add({ { src = "https://github.com/ibhagwan/fzf-lua" } })
local fzflua = require("fzf-lua")
fzflua.register_ui_select()
fzflua.setup({
  actions = {
    files = {
      true,
      ["ctrl-y"] = fzflua.actions.file_edit_or_qf,
    },
  },
})
vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<CR>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>", { desc = "[S]earch [G]rep" })
vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua files<CR>", { desc = "[G]it [F]iles" })
vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua resume<CR>", { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader><space>", "<cmd>FzfLua buffers<CR>", { desc = "Show buffers" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua blines<CR>", { desc = "Fuzzy find in buffer" })

vim.pack.add({ { src = "https://github.com/saghen/blink.cmp" } })
require("blink.cmp").setup({
  completion = {
    ghost_text = {
      enabled = true,
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },
})

vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    graphql = { "prettierd", "prettier" },
    md = { "prettierd", "prettier" },
    txt = { "prettierd", "prettier" },
  },
  format_on_save = { timeout_ms = 1500, lsp_format = "never" },
  formatters = {
    stylua = {
      args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
    },
  },
})

vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } })
vim.pack.add({ { src = "https://github.com/RRethy/vim-illuminate" } })
vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" } })
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "css",
    "scss",
    "typescript",
    "lua",
    "html",
    "javascript",
    "json",
    "lua",
    "php",
    "rust",
    "yaml",
    "vim",
    "toml",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>", -- set to `false` to disable one of the mappings
      node_incremental = "<CR>",
      scope_incremental = "<CR>",
      node_decremental = "<Tab>",
    },
  },
  indent = {
    enable = true,
  },
})

vim.lsp.enable({
  "ts_ls",
  "copilot",
  "tailwindcss",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set("i", "<C-k>", vim.lsp.completion.get, bufopts) -- open completion menu manually
    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

    local methods = vim.lsp.protocol.Methods
    -- https://github.com/neovim/neovim/blob/b2828af5b5aba044cd40594a519d2d9f5dbb69cb/runtime/lua/vim/lsp/protocol.lua?plain=1#L858
    if client:supports_method(methods.textDocument_completion) then
      -- print("this client supports text completion")
      -- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    if client:supports_method(methods.textDocument_inlineCompletion) then
      -- print("this client supports inline text completion")
      vim.lsp.inline_completion.enable(true)

      vim.keymap.set("i", "<Tab>", function()
        if not vim.lsp.inline_completion.get() then
          return "<Tab>"
        end
      end)
    end
  end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
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
vim.opt.spelllang = "en_gb"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

vim.g.netrw_liststyle = 1 -- Use the long listing view

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/nvim-mini/mini.surround" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  { src = "https://github.com/ChrisBrowne/terminal-toggle.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/RRethy/vim-illuminate" },
  { src = "https://github.com/tpope/vim-sleuth" },
  { src = "https://github.com/tpope/vim-vinegar" },
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>")
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<CR>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>", { desc = "[S]earch [G]rep" })
vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua files<CR>", { desc = "[G]it [F]iles" })
vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua resume<CR>", { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<CR>", { desc = "[S]earch [W]ord" })
vim.keymap.set("n", "<leader>s.", "<cmd>FzfLua oldfiles<CR>", { desc = "[S]earch Old files" })
vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua spell_suggest<CR>", { desc = "[S]pell [S]uggest" })
vim.keymap.set("n", "<leader><space>", "<cmd>FzfLua buffers<CR>", { desc = "Show buffers" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua blines<CR>", { desc = "Fuzzy find in buffer" })
vim.keymap.set({ "n", "t" }, "<C-z>", "<cmd>TerminalToggle<CR>", { desc = "Terminal toggle" })
vim.keymap.set("i", "<Tab>", function()
  if not vim.lsp.inline_completion.get() then
    return "<Tab>"
  end
end)

-- https://neovim.io/doc/user/lsp.html#_global-defaults
vim.keymap.set("n", "grd", "<Cmd>lua vim.lsp.buf.definition()<CR>zz", bufopts)

vim.lsp.enable({
  "ts_ls",
  "copilot",
  "tailwindcss",
  "rust_analyzer",
  "gopls",
})

local augroup = vim.api.nvim_create_augroup("chris.cfg", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    -- vim.keymap.set("i", "<C-k>", vim.lsp.completion.get, bufopts) -- open completion menu manually

    -- https://github.com/neovim/neovim/blob/b2828af5b5aba044cd40594a519d2d9f5dbb69cb/runtime/lua/vim/lsp/protocol.lua?plain=1#L858
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      -- print("this client supports text completion")
      -- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
      -- print("this client supports inline text completion, which is the case for copilot as that needs to complete multiline snippets")
      vim.lsp.inline_completion.enable(true)
    end
  end,
})

require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end)

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk)
    map("n", "<leader>hr", gitsigns.reset_hunk)

    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("n", "<leader>hS", gitsigns.stage_buffer)
    map("n", "<leader>hR", gitsigns.reset_buffer)
    map("n", "<leader>hp", gitsigns.preview_hunk)
  end,
})

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
    "go",
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
      scope_incremental = false,
      node_decremental = "<BS>",
    },
  },
  indent = {
    enable = true,
  },
})

require("tokyonight").setup({
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
})
vim.cmd.colorscheme("tokyonight-night")

require("fidget").setup({})

require("terminal-toggle").setup()

require("mini.surround").setup()

require("nvim-autopairs").setup()

require("fzf-lua").register_ui_select()
require("fzf-lua").setup({
  defaults = {
    keymap = {
      fzf = {
        ["ctrl-y"] = "accept",
      },
    },
  },
})

require("blink.cmp").setup({
  -- go here /home/topher/.local/share/nvim/site/pack/core/opt/blink.cmp
  -- and run `cargo build --release` to build the rust component
  fuzzy = { implementation = "prefer_rust_with_warning" },
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

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
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

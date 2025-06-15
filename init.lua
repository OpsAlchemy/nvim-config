-- Bootstrap lazy.nvim
vim.opt.rtp:prepend("~/.config/nvim/lazy/lazy.nvim")
vim.g.mapleader = " "
require("lazy").setup({
  -- Colorscheme
  { "catppuccin/nvim", name = "catppuccin" },

  -- File explorer
  { 
    "nvim-tree/nvim-tree.lua", 
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() 
      require("nvim-tree").setup()
    end,
  },

  -- Fuzzy finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- LSP Support
  "neovim/nvim-lspconfig",

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },
  

  -- Treesitter for syntax
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.mouse = "a"

-- Colorscheme
vim.cmd.colorscheme("catppuccin")

-- Telescope keymap
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")

-- Setup LSP (example for Python)
require("lspconfig").pyright.setup({})
require("lspconfig").clangd.setup({})
-- Setup cmp
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = { { name = "nvim_lsp" } },
})


-- Setup windowsYankSupport
vim.opt.clipboard = "unnamedplus"

vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = true,
}

-- Setup File Explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle File Explorer" })

-- Focus NvimTree
vim.keymap.set("n", "<leader>fe", "<C-w>h", { desc = "Focus NvimTree" })

-- Focus code (right split)
vim.keymap.set("n", "<leader>fc", "<C-w>l", { desc = "Focus code window" })

-- Open current file in NvimTree and reveal
vim.keymap.set("n", "<leader>fr", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal file in tree" })

-- Open terminal in horizontal split
vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("belowright 15split | terminal")  -- 15-line terminal
  vim.cmd("startinsert")                    -- auto-enter insert mode
end, { desc = "Open terminal below" })

-- Exit terminal mode easily (press Esc twice)
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Escape terminal mode" })


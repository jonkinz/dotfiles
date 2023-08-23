-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Shorten function name
-- local keymap = vim.api.nvim_set_keymap

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Insert --
-- Press jk fast to exit insert mode
map("i", "jk", "<ESC>", opts)
map("i", "kj", "<ESC>", opts)

-- Move text up and down
--map("v", "<a-j>", ":m .+1<cr>==", opts)
--map("v", "<a-k>", ":m .-2<cr>==", opts)
--map("v", "p", '"_dp', opts)

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- In insert mode, go the beginning of the line with ctrl b, the end with ctrl ^
map("i", "<C-b>", "<C-o>^", opts)
map("i", "<C-e>", "<C-o>$", opts)
-- map("n", "<C-x>", ":normal 0<CR>", opts)
-- map("i", "<C-D>", ":normal $<CR>", opts)

-- Terminal --
-- Better terminal navigation
-- map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- map("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true }) map("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true, desc = "Resume" })
-- :nnoremap <F5> "=strftime("%c")<CR>P
-- :inoremap <F5> <C-R>=strftime("%c")<CR>
map("n", "<F5>", ":pu=strftime('%c')<CR>", { noremap = true, silent = true, desc = "Add Date" })
map("i", "<F5>", "<C-R>=strftime('%c')<CR>", { noremap = true, silent = true, desc = "Add Date" })
-- map("n", "src", ":so %<CR>", { noremap = true, silent = false, desc = "Source File" })
map("n", "<Leader>sv", ":source $MYVIMRC<CR>", { noremap = true, silent = false, desc = "Source File" })

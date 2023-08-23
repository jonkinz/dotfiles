local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.dap.nlua" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/snippets/my-snippets" })
-- require("luasnip-snippets").load_snippets()

local dap = require("dap")
dap.configurations.c = dap.configurations.rust

-- local in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil

-- I've commented out the paste key, so ctrl v will paste from the system buffer, and p will paste from vim
-- I've commented out the paste key, so ctrl v will paste from the system buffer, and p will paste from vim
-- I've commented out the paste key, so ctrl v will paste from the system buffer, and p will paste from vim
-- if in_wsl then
--   vim.g.clipboard = {
--     name = "wsl_clipboard",
--     copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
--     paste = { ["+"] = { "nvimPaste" }, ["*"] = { "nvimPaste" } },
--     cache_enabled = true,
--   }
-- end

-- if in_wsl then
--   vim.g.clipboard = {
--     name = "wsl_clipboard",
--     copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
--     -- paste = { ["+"] = { "nvimPaste" }, ["*"] = { "nvimPaste" } },
--     paste = { ["+"] = { "win32yank -o --lf" }, ["*"] = { "win32yank -o --lf" } },
--     cache_enabled = true,
--   }
-- end

return function()
  local luasnip = require("luasnip")
  -- be sure to load this first since it overwrites the snippets table.
  luasnip.snippets = require("./luasnip-snippets").load_snippets()
end

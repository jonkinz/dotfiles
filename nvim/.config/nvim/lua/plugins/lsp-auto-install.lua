-- add pyright to lspconfig
-- add pyright to lspconfig
-- add pyright to lspconfig
-- add pyright to lspconfig
-- add pyright to lspconfig
-- add pyright to lspconfig
-- if true then
--   return {}
-- end
-- add pyright to lspconfig
return
-- add pyright to lspconfig
{
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      pyright = {},
    },
  },
}

if true then
  return {}
end
return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
  end,
}

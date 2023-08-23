if true then
  return {}
end
return {
  {
    "mattn/emmet-vim",
    setup = function() -- load stuff before the plugin is loaded
      vim.g.user_emmet_leader_key = "<c-m>"

      vim.g.user_emmet_settings = {
        indent_blockelement = 1,
      }
    end,
  },
}

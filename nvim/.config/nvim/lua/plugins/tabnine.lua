--notify.info cmp-tabnine: Cannot find installed TabNine. Please run install.sh
if true then
  return {}
end
return {
  -- add symbols-outline
  {
    "codota/tabnine",
    build = "./dl_binaries.sh",
    setup = {
      position = "right",
      disable_auto_comment = true,
      accept_keymap = "<Tab>",
      dismiss_keymap = "<C-]>",
      debounce_ms = 800,
      suggestion_color = { gui = "#808080", cterm = 244 },
      exclude_filetypes = { "TelescopePrompt" },
    },
  },
}

--
-- notify.info cmp-tabnine: Cannot find installed TabNine. Please run install.sh
--  cmp-tabnine: Cannot find installed TabNine. Please run install.sh
if true then
  return {}
end
return {
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
  },
}

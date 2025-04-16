-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.filetype.add {
  extension = {
    mcfunction = "mcfunction",
    mcmeta = "json",
    bolt = "bolt",
    jmc = "jmc",
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gdscript" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = false
  end,
  desc = "Set tabs to 4 chars in Go and GDScript files",
})

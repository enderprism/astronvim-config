-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

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

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = vim.api.nvim_create_augroup("TS_add_missing_imports", { clear = true }),
--   desc = "TS_add_missing_imports",
--   pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
--   callback = function()
--     vim.cmd [[TSToolsAddMissingImports]]
--     vim.cmd "write"
--   end,
-- })

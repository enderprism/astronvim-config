local char = "│"

---@type LazySpec
return {
  {
    "catppuccin",
    ---@type CatppuccinOptions
    opts = { term_colors = true },
  },
  {
    "folke/noice.nvim",
    opts = { lsp = { signature = { enabled = false } } }
  },
  {
    "epwalsh/obsidian.nvim",
    -- the obsidian vault in this default config  ~/obsidian-vault
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    -- event = { "bufreadpre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
    event = { "BufReadPre */Documents/Obsidian Vault/*.md" },
    opts = {
      dir = vim.env.HOME .. "/Documents/Obsidian Vault", -- specify the vault location. no need to call 'vim.fn.expand' here
    },
  },
  {
    "echasnovski/mini.indentscope",
    event = "User AstroFile",
    opts = function()
      return {
        options = { try_as_border = true },
        symbol = require("astrocore").plugin_opts("indent-blankline.nvim").context_char or char,
      }
    end,
  },
}

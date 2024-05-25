return {
  "folke/noice.nvim",
  opts = function(_, opts) require("noice").setup { lsp = { signature = { enabled = false } } } end,
}

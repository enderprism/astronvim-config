local char = "│"

---@type LazySpec
return {
  {
    "catppuccin",
    ---@type CatppuccinOptions
    opts = { term_colors = true, },
  },
  -- {
  --   "folke/noice.nvim",
  --   opts = { lsp = { signature = { enabled = false } } }
  -- },
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
  {
    "Mythos-404/xmake.nvim",
    lazy = true,
    event = "BufReadPost xmake.lua",
    config = true,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "b0o/blender.nvim",
    config = function()
      require("blender").setup {
        dap = { enabled = false, },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "grapp-dev/nui-components.nvim",
      "mfussenegger/nvim-dap", -- Optional, for debugging with DAP
      "LiadOz/nvim-dap-repl-highlights", -- Optional, for syntax highlighting in the DAP REPL
    },
  },
  -- {
  --   "NvChad/ui",
  --   opts = {
  --     base46 = { theme = "catppuccin" },
  --   },
  -- },
  --
  -- {
  --   "nvchad/base46",
  --   lazy = true,
  --   build = function()
  --     require("base46").load_all_highlights()
  --   end,
  -- },
  {
    "kblin/vim-fountain",
  },
  {
    "nvim-neorg/neorg",
    opts = {
      load = {
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/Neorg/"
            },
            default_workspace = "notes",
          },
        },
      }
    },
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
        },
      })
    end,
  },
}

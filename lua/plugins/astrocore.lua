-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

local function switch_terminal_mode()
  if vim.bo.buftype == "terminal" then
    if vim.fn.mode() == "n" then
      vim.cmd "startinsert"
    else
      vim.cmd "stopinsert"
    end
  end
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    rooter = {
      -- list of detectors in order of prevalence, elements can be:
      --   "lsp" : lsp detection
      --   string[] : a list of directory patterns to look for
      --   fun(bufnr: integer): string|string[] : a function that takes a buffer number and outputs detected roots
      detector = {
        "lsp", -- highest priority is getting workspace from running language servers
        { ".git", "_darcs", ".hg", ".bzr", ".svn" }, -- next check for a version controlled parent directory
        { "lua", "MakeFile", "package.json", "pyproject.toml", "xmake.lua" }, -- lastly check for known project root files
      },
      -- ignore things from root detection
      ignore = {
        servers = {"clangd"}, -- list of language server names to ignore (Ex. { "efm" })
        dirs = {}, -- list of directory patterns (Ex. { "~/.cargo/*" })
      },
      -- automatically update working directory (update manually with `:AstroRoot`)
      autochdir = true,
      -- scope of working directory to change ("global"|"tab"|"win")
      scope = "global",
      -- show notification on every working directory change
      notify = false,
    },
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        guifont = "JetBrainsMono NF,Noto_Color_Emoji:h12.5",
        scrolloff = 10,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        neovide_hide_mouse_when_typing = true,
        neovide_normal_opacity = 0.9,
        neovide_floating_corner_radius = 0.25,
        -- neovide_scroll_animation_length = 1.2,
        -- neovide_cursor_animation_length = 0.4,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        ["<S-Space>"] = { function() switch_terminal_mode() end, desc = "Switch terminal mode" },

        -- navigate buffer tabs with `H` and `L`
        L = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
      },
      i = {
        ["<C-BS>"] = { "<C-w>", desc = "Delete previous word" },
        ["<C-v>"] = { "<cmd> :normal! P <CR>", desc = "Paste" },
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
      },
      v = {
        ["<"] = { "<gv" },
        [">"] = { ">gv" },
      },
      t = {
        ["<S-Space>"] = { function() switch_terminal_mode() end, desc = "Switch terminal mode" },
      },
    },
  },
}

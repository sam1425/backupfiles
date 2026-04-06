-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  --"andweeb/presence.nvim",
  --{
  --"ray-x/lsp_signature.nvim",
  --event = "BufRead",
  --config = function() require("lsp_signature").setup() end,
  --},

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- disable plugins
  { "max397574/better-escape.nvim", enabled = false },
  { "brenoprata10/nvim-highlight-colors", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "goolord/alpha-nvim", enabled = false },
  { "andweeb/presence.nvim", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "stevearc/aerial.nvim", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  { "folke/todo-comments.nvim", enabled = false },
  { "windwp/nvim-ts-autotag", enabled = false },
  { "NMAC427/guess-indent.nvim", enabled = false },
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "sainnhe/gruvbox-material",
    lazy = false, -- Load immediately to prevent flashing
    priority = 1000,
    config = function()
      -- Configuration options
      vim.g.gruvbox_material_background = "hard" -- Choices: 'hard', 'medium', 'soft'
      vim.g.gruvbox_material_foreground = "mix" -- Choices: 'material', 'mix', 'original'

      -- Enable transparency
      vim.g.gruvbox_material_transparent_background = 1

      -- Optional: Better visual consistency for AstroNvim
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_better_performance = 1 -- Uses a pre-compiled version

      -- Apply the colorscheme
      vim.cmd.colorscheme "gruvbox-material"

      -- Force transparency override (safety net)
      local hl_groups = { "Normal", "NormalFloat", "SignColumn", "EndOfBuffer" }
      for _, group in ipairs(hl_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
      end
    end,
  },
}

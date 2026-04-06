-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

--@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
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
  { "ellisonleao/gruvbox.nvim", enabled = false },
  { "morhetz/gruvbox", enabled = false },
}

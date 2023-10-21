return {
  {
    "thePrimeagen/vim-be-good",
    cmd = "VimBeGood",
    config = function() require("VimBeGood").setup {} end,
  },
  {
    "ibhagwan/smartyank.nvim",
  },
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    dependencies = { "romgrk/fzy-lua-native" },
    config = function() require "user.wilder" end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "CursorHold", "CursorHoldI" },
    config = function() require "user.gitsigns" end,
  },
}

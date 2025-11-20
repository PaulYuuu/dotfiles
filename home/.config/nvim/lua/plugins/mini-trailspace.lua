return {
  "echasnovski/mini.trailspace",
  event = "BufReadPost",
  opts = {},
  keys = {
    { "<leader>T", "<cmd>lua MiniTrailspace.trim()<cr>", desc = "Trim trailing whitespace" },
  },
}

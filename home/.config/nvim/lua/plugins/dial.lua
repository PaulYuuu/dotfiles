return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>", function() return require("dial.map").inc_normal("default") end, mode = "n", expr = true, desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_normal("default") end, mode = "n", expr = true, desc = "Decrement" },
    { "<C-a>", function() return require("dial.map").inc_visual("default") end, mode = "v", expr = true, desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_visual("default") end, mode = "v", expr = true, desc = "Decrement" },
    { "g<C-a>", function() return require("dial.map").inc_gvisual("default") end, mode = "v", expr = true, desc = "g-Increment" },
    { "g<C-x>", function() return require("dial.map").dec_gvisual("default") end, mode = "v", expr = true, desc = "g-Decrement" },
  },
  config = function()
    require "configs.dial"
  end,
}

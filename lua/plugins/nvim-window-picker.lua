return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  config = function()
    require("window-picker").setup({
      filter_rules = {
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { "NvimTree", "neo-tree", "notify" },

          -- if the file type is one of following, the window will be ignored
          buftype = { "terminal" },
        },
      },
    })
  end,
}

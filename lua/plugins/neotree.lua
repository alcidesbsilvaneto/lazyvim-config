return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    enable_normal_mode_for_inputs = true,
    window = {
      mappings = {
        ["<CR>"] = "open_with_window_picker",
        ["l"] = "open_with_window_picker",
      },
    },
  },
}

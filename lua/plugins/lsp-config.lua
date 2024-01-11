return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {},
        tsserver = {
          settings = {
            workspace = {
              applyEdit = true,
              configuration = true,
              didChangeConfiguration = {
                dynamicRegistration = false,
              },
              didChangeWatchedFiles = {
                dynamicRegistration = true,
                relativePatternSupport = true,
              },
              inlayHint = {
                refreshSupport = true,
              },
            },
          },
        },
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}

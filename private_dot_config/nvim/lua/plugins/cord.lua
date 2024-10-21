-- https://github.com/vyfor/cord.nvim
return {
  {
    "vyfor/cord.nvim",
    build = "./build || .\\build",
    event = "VeryLazy",
    opts = {
      text = {
        viewing = "Viewing file",
        editing = "Editing file",
        file_browser = "Browsing files in Neotree",
        plugin_manager = "Managing plugins",
        lsp_manager = "Configuring LSP",
        vcs = "Commiting changes",
        workspace = "In workspace",
      },
      display = {
        show_repository = true,
        show_cursor_position = true,
      },
    }, -- calls require('cord').setup()
  },
}

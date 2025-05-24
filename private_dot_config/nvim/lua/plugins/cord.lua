-- https://github.com/vyfor/cord.nvim
return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    opts = {
      variables = {
        --   filename = "a file",
        problems = function()
          return #vim.diagnostic.get(0)
        end,
      },
      editor = {
        tooltip = "Neovim",
      },
      text = {
        default = nil,
        workspace = "In workspace - ${cursor_line}:${cursor_char}",
        viewing = "Viewing ${filetype} file",
        editing = "Editing ${filetype} file - ${problems} problems",
        file_browser = "Browsing files in ${name}",
        plugin_manager = "Managing plugins in ${name}",
        lsp = "Configuring LSP in ${name}",
        docs = "Reading ${name}",
        vcs = "Committing changes in ${name}",
        notes = "Taking notes in ${name}",
        debug = "Debugging in ${name}",
        test = "Testing in ${name}",
        diagnostics = "Fixing problems in ${name}",
        games = "Playing ${name}",
        dashboard = "Home",
      },
      -- variables = true,
    },
  },
}
-- return {
--   {
--     "vyfor/cord.nvim",
--     build = "./build || .\\build",
--     event = "VeryLazy",
--     opts = {
--       editor = {
--         tooltip = "Neovim",
--       },
--       display = {
--         show_repository = true,
--         show_cursor_position = true,
--       },
--       lsp = {
--         show_problem_count = true,
--       },
--       text = {
--         viewing = "Viewing file",
--         editing = "Editing file",
--         file_browser = "Browsing files in Neotree",
--         plugin_manager = "Managing plugins",
--         lsp_manager = "Configuring LSP",
--         vcs = "Commiting changes",
--         workspace = "In workspace",
--       },
--     }, -- calls require('cord').setup()
--   },
-- }

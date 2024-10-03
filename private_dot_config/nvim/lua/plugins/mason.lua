return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "css-lsp",
        "marksman",
        "shellcheck",
      },
    },
  },
}
-- return {
--   "williamboman/mason-lspconfig.nvim",
--   opts = {
--     ensure_installed = {
--       -- "eslint",
--     },
--   },
-- }

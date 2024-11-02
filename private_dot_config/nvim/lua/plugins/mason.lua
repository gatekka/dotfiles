return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "css-lsp",
        "flake8",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "shellcheck",
        "shfmt",
        "stylua",
        "typescript-language-server",
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

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- "stylua",
        -- "shfmt",
        -- "lua-language-server",
        "typescript-language-server",
        "shellcheck",
        "flake8",
        "html-lsp",
        "css-lsp",
        "marksman",
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

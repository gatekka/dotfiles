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
        "prettier",
        "shellcheck",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
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

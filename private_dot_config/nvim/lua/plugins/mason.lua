-- return {
--   {
--     "mason-org/mason.nvim",
--     opts = {
--       ui = {
--         icons = {
--           package_installed = "✓",
--           package_pending = "➜",
--           package_uninstalled = "✗",
--         },
--       },
--     },
--   },
-- }

return {
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
      "taplo",
      "typescript-language-server",

      -- Java Stuff
      -- "java-debug-adapter",
      -- "java-test",
      -- "jdtls",
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

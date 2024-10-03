return {
  {
    "Diogo-ss/five-server.nvim",
    cmd = { "FiveServer" },
    build = function()
      require("fs.utils.install")()
    end,
    opts = {
      notify = true,
      -- add other options
    },
    config = function(_, opts)
      require("fs").setup(opts)
    end,
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                isort = { enabled = true },
                black = { enabled = true },
                ruff = { enabled = true },
                mypy = { enabled = true },
                pycodestyle = { enabled = false, ignore = { "E501", "W503" } },
                spyder = { enabled = false },
                mccabe = { enabled = false },
                rope_autoimport = { enabled = false },
                flake8 = { enabled = false },
                yapf = { enabled = false },
                autopep8 = { enabled = false },
                pyflakes = { enabled = false },
              },
            },
          },
        },
      },
    },
  },
}

-- Installed via:
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim\
-- ~/.config/nvim/site/pack/packer/start/packer.nvim

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plug.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'junegunn/fzf' 
  use 'junegunn/fzf.vim' 

  use({
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({
            mappings = { basic=true, extra=false }
        })
    end
  })

  use 'neovim/nvim-lspconfig'
  use({
    'j-hui/fidget.nvim',
    config = function()
        require('fidget').setup({})
    end
  })

  use { "catppuccin/nvim", as = "catppuccin" }

  use({
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {}
    end
  })
      
end
)

-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)

   -- Where the plugins go
   -- You kinda need a plugin manager to manage the plugins, ykwim?? 
   use("wbthomason/packer.nvim")

    -- Lua functions
    use ("nvim-lua/plenary.nvim")

        --Color scheme
    use { "catppuccin/nvim", as = "catppuccin" }

    use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

    -- Maximizes the window with <leader>sm
    use ("szw/vim-maximizer") -- maximizes and restores the current window

    -- Helpful plugins
    use ("tpope/vim-surround") -- Surrounding words in something 
    use ("vim-scripts/ReplaceWithRegister") -- Better ? (Maybe) copying and cutting
    use ("nvim-tree/nvim-tree.lua")

    -- Commenting
    use("numToStr/Comment.nvim") -- Better neovim commenting

    -- Icons!! :)
    use ("kyazdani42/nvim-web-devicons")

    -- A better bar at the bottom of the screen
    use ("nvim-lualine/lualine.nvim")

    -- fuzzy finding w/ telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

    -- Autocompletion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths

    -- Snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion
    use("rafamadriz/friendly-snippets") -- useful snippets

    -- managing and installing lsp servers
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- Configuring the lsp servers
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    }) -- enhanced lsp uis
    use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

    -- Formatting and linting
    use ("jose-elias-alvarez/null-ls.nvim")
    use ("jayp0521/mason-null-ls.nvim")

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",

        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    use ("lewis6991/gitsigns.nvim")

    -- auto closing
    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

    --nvim terminal
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}   --use ('akinsho/toggleterm.nvim')

    use {'neoclide/coc.nvim', branch = 'release'}

    use {
        "startup-nvim/startup.nvim",
        requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
        config = function()
            require"startup".setup()
        end
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)


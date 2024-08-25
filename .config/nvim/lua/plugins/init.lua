return {
  -- PaperColor theme
  "NLKNguyen/papercolor-theme",

  -- OneDark theme
  "olimorris/onedarkpro.nvim",

  -- Add support for Fish scripting
  "dag/vim-fish",

  -- Jump everywhere
  {
    "ggandor/leap.nvim",
    config = function()
      local bufopts = { silent=true }
      vim.keymap.set("n", "<Space>", "<Plug>(leap-forward)", bufopts)
      vim.keymap.set("n", "<Leader><Space>", "<Plug>(leap-backward)", bufopts)
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },


  -- nvim-tree
  --{
  --  "kyazdani42/nvim-tree.lua",
  --  dependencies = "kyazdani42/nvim-web-devicons",
  --  config = function()
  --    vim.api.nvim_set_keymap("n", "<Leader>d", ":NvimTreeOpen<cr>", {noremap = true})
  --    require"nvim-tree".setup{
  --      filters = {
  --        dotfiles = true,
  --      },
  --      hijack_cursor = true,
  --      update_cwd = true,
  --    }
  --  end
  --},

  -- vim-tmux-navigator
  --"christoomey/vim-tmux-navigator",

  -- Universal search
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local bufopts = { noremap=true, silent=true }
      vim.api.nvim_set_keymap("n", "<Leader>t", ":Telescope find_files<cr>", bufopts)
      vim.api.nvim_set_keymap("n", "<Leader>a", ":Telescope live_grep<cr>", bufopts)
      vim.api.nvim_set_keymap("n", "<Leader>b", ":Telescope buffers<cr>", bufopts)
      vim.api.nvim_set_keymap("n", "<Leader>h", ":Telescope help_tags<cr>", bufopts)
      local actions = require "telescope.actions";
      require("telescope").setup({
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous
            }
          }
        }
      })
    end
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require"lualine".setup({
        options = {
          theme = "onelight",
        },
      })
    end
  },
}

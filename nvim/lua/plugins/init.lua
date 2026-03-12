return {
  -- theme
  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      require("bluloco").setup({
        style = "dark",
        transparent = false,
        italics = false,
      })
      vim.opt.termguicolors = true
      vim.cmd('colorscheme bluloco')
    end,
  },

  -- mason: install LSP servers
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  -- mason-lspconfig: mason - lspconfig bridge
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'ts_ls' },
      })
    end,
  },

  -- lspconfig: configure the servers
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('ts_ls', {})
      vim.lsp.enable('ts_ls')
    end,
  },

  -- nvim-cmp: autocomplete
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',   -- LSP source
      'hrsh7th/cmp-buffer',     -- current buffer source
      'hrsh7th/cmp-path',       -- paths source
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },
}

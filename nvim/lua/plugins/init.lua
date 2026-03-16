return {
  -- theme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "",          -- medium, the classic look
        italic = {
          strings = false,      -- no italics on strings, cleaner look
          comments = true,
          emphasis = true,
          operators = false,
          folds = true,
        },
        bold = true,
      })
      vim.o.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- mason: install LSP servers
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
      local registry = require('mason-registry')
      local tools = { 'prettier' }
      for _, tool in ipairs(tools) do
        if not registry.is_installed(tool) then
          vim.cmd('MasonInstall ' .. tool)
        end
      end
    end,
  },

  -- mason-lspconfig: mason - lspconfig bridge
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'ts_ls', 'gopls' },
        automatic_installation = false,
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
          ts_ls = function()
            require('lspconfig').ts_ls.setup({})
          end,
          gopls = function()
            require('lspconfig').gopls.setup({})
          end,
        }
      })
    end,
  },

  -- lspconfig: configure the servers
  {
    'neovim/nvim-lspconfig',
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

  -- conform: formatter
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescriptreact = { 'prettier' },
          json = { 'prettier' },
          css = { 'prettier' },
          html = { 'prettier' },
        },
      })
    end,
  },
}

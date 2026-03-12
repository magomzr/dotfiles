return {
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
}

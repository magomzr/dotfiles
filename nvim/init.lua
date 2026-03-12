-- Bootstrap lazy.nvim (auto instala si no existe)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

-- Cargar tu .vimrc existente
vim.cmd("source ~/.vimrc")

-- Cargar plugins
require("lazy").setup("plugins")

return {
  { "rebelot/kanagawa.nvim" },
  { "AlexvZyl/nordic.nvim" },
  {
    "daltonmenezes/aura-theme",
    lazy = false,
    priority = 1000,
    build = function(plugin)
      -- symlink the neovim subpackage so lazy.nvim can find colors/ and lua/
      local src = plugin.dir .. "/packages/neovim"
      for _, sub in ipairs({ "colors", "lua" }) do
        local from = src .. "/" .. sub
        local to = plugin.dir .. "/" .. sub
        if vim.fn.isdirectory(from) == 1 and vim.fn.isdirectory(to) == 0 then
          vim.uv.fs_symlink(from, to, { dir = true })
        end
      end
    end,
  },
  { "xero/miasma.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}

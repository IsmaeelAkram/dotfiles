return {
  {
    "esensar/nvim-dev-container",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      container_runtime = "docker",
      compose_command = "docker compose",
    },
  },
}

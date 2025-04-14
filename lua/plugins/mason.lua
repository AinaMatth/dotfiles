return {
    "williamboman/mason.nvim",
    cmd = {"Mason", "MasonInstall", "MasonUpdate" },
    opts = {
              PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  max_concurrent_installers = 10,
},
}

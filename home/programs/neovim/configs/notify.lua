local notify = require("notify")

notify.setup({
  timeout = 0,
  render = "minimal",
  minimum_width = 10,
  background_colour = "#000000",
})

vim.notify = notify

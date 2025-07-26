local notify = require("notify")

notify.setup({
  timeout = 0,
  render = "minimal",
  minimum_width = 10,
  max_width = 50,
  max_height = 3,
})

vim.notify = notify

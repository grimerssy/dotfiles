local ts = require("ts_context_commentstring.integrations.comment_nvim")

require("Comment").setup({
  pre_hook = ts.create_pre_hook(),
})

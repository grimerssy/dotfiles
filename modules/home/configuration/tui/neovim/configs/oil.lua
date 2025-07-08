vim.keymap.set("n", "-", vim.cmd.Oil)

require("oil").setup({
  skip_confirm_for_simple_edits = true,
  cleanup_delay_ms = 0,
  view_options = {
    show_hidden = true,
  },
})

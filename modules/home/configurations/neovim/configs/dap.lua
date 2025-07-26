local dap = require("dap")
local ui = require("dapui")

local map = vim.keymap.set

map("n", "<leader>db", dap.toggle_breakpoint)
map("n", "<leader>dB", function()
  vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
    dap.set_breakpoint(input)
  end)
end)
map("n", "<leader>dc", dap.continue)
map("n", "<leader>ds", dap.step_over)
map("n", "<leader>di", dap.step_into)
map("n", "<leader>do", dap.step_out)
map("n", "<leader>dr", dap.repl.open)
map("n", "<leader>dd", dap.disconnect)

ui.setup({})

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end

-- TODO: handle setup with docker cmd
require("dap-go").setup()

-- TODO: rust debugger when codelldb builds on aarch64-darwin
-- https://github.com/NixOS/nixpkgs/pull/211321

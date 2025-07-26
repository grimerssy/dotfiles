vim.api.nvim_create_autocmd("BufRead", {
  pattern = "Cargo.toml",
  callback = function()
    local crates = require("crates")

    crates.setup()

    local map = vim.keymap.set

    local function double(f)
      return function()
        f()
        f()
      end
    end

    local opts = { buffer = true }
    map("n", "<leader>s", [[:s/{.*version.*=.*\("[0-9\.]\+"\).*}/\1<CR>]], opts)

    map("n", "<leader>T", crates.toggle, opts)
    map("n", "<leader>R", crates.reload, opts)

    map("n", "fv", double(crates.show_versions_popup), opts)
    map("n", "ff", double(crates.show_features_popup), opts)
    map("n", "fd", double(crates.show_dependencies_popup), opts)

    map("n", "<leader>u", crates.update_crate, opts)
    map("n", "<leader>a", crates.update_all_crates, opts)
    map("n", "<leader>U", crates.upgrade_crate, opts)
    map("n", "<leader>A", crates.upgrade_all_crates, opts)

    map("v", "<leader>u", crates.update_crates, opts)
    map("v", "<leader>U", crates.upgrade_crates, opts)

    map("n", "<leader>x", crates.extract_crate_into_table, opts)
    map("n", "<leader>t", crates.expand_plain_crate_to_inline_table, opts)

    map("n", "<leader>h", crates.open_homepage, opts)
    map("n", "<leader>r", crates.open_repository, opts)
    map("n", "<leader>d", crates.open_documentation, opts)
    map("n", "<leader>c", crates.open_crates_io, opts)
  end,
})

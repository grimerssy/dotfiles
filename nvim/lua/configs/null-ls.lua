local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    code_actions.shellcheck,
    formatting.stylua.with({
      extra_args = {
        '--indent-type',
        'Spaces',
        '--indent-width',
        '2',
        '--quote-style',
        'AutoPreferSingle',
      },
    }),
    formatting.prettier.with({
      extra_args = {
        '--double-quote',
        '--jsx-double-quote',
      },
    }),
    formatting.jq,
    formatting.goimports,
    formatting.gofumpt,
    formatting.buf,
    formatting.rustfmt,
    formatting.mix,
    formatting.black,
    formatting.csharpier,
    formatting.trim_whitespace,
    diagnostics.codespell.with({
      extra_args = {
        '--check-filenames',
        '--ignore-words-list',
        'crate',
      },
    }),
    diagnostics.staticcheck,
    diagnostics.buf,
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- vim.lsp.buf.formatting_sync() -- nvim < 0.8
          vim.lsp.buf.format({ bufnr = bufnr }) -- nvim 0.8+
        end,
      })
    end
  end,
})

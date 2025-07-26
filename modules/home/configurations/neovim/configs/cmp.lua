local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

cmp.setup({
  preselect = cmp.PreselectMode.None,
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  window = {
    completion = {
      scrollbar = false,
      scrolloff = 4,
      col_offset = -2,
    },
    documentation = {
      max_height = 15,
      max_width = 60,
    },
  },
  formatting = {
    fields = { "kind", "abbr" },
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 30,
      ellipsis_char = "...",
      before = function(_, item)
        item.menu = ""
        return item
      end,
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
  }),
  -- TODO remove luasnip?
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
})

local plugin = {'hrsh7th/nvim-cmp'}

plugin.dependencies = {
  -- Sources
  -- {'quangnguyen30192/cmp-nvim-ultisnips'},
  { 'saadparwaiz1/cmp_luasnip' },
  {'zbirenbaum/copilot-cmp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-nvim-lsp'},

  -- Snippets
  { 'L3MON4D3/LuaSnip' }
  -- {'sirver/ultisnips'}
}

function plugin.config()
  local cmp = require('cmp')
  -- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

  local luasnip = require("luasnip")

  luasnip.config.setup({ enable_autosnippets = true, })

  require("luasnip.loaders.from_lua").lazy_load({
    paths = { vim.fn.stdpath("config") .. "/lua/snippets" }
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      -- ["<c-j>"] = cmp.mapping(
      --   function(fallback)
      --     cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
      --   end,
      --   { "i", "s" }
      -- ),
      -- ["<c-k>"] = cmp.mapping(
      --       function(fallback)
      --         cmp_ultisnips_mappings.jump_backwards(fallback)
      --       end,
      --       { "i", "s" }
      --     ),
      ["<c-j>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<c-k>"] = cmp.mapping(function(fallback)
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ['J'] = cmp.mapping.scroll_docs(4),
      ['K'] = cmp.mapping.scroll_docs(-4),
      ['<c-l>'] = cmp.mapping.confirm({ select = true }),
      ['<c-h>'] = cmp.mapping.abort(),
    },
    sources = {
      -- { name = "ultisnips", group_index=0},
      { name = "luasnip", group_index=0},
      { name = "copilot", group_index=1},
      { name = "nvim_lsp", group_index=1},
      { name = "path", group_index=2},
      { name = "buffer", keyword_length=2, group_index=2},
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    experimental = {
      ghost_text = true
    }
  })

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

end

return plugin

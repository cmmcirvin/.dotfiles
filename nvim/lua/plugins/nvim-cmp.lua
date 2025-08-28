local plugin = {'hrsh7th/nvim-cmp'}

plugin.dependencies = {
  -- Sources
  {'quangnguyen30192/cmp-nvim-ultisnips'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-nvim-lsp'},

  -- Snippets
  {'sirver/ultisnips'}
}

function plugin.config()
  local cmp = require('cmp')
  local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      ["<c-j>"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        end,
        { "i", "s" }
      ),
      ["<c-k>"] = cmp.mapping(
            function(fallback)
              cmp_ultisnips_mappings.jump_backwards(fallback)
            end,
            { "i", "s" }
          ),
      ['J'] = cmp.mapping.scroll_docs(4),
      ['K'] = cmp.mapping.scroll_docs(-4),
      ['<c-l>'] = cmp.mapping.confirm({ select = true }),
      ['<c-h>'] = cmp.mapping.abort(),
    },
    sources = {
      { name = "ultisnips", group_index=0},
      { name = "nvim_lsp", group_index=1},
      { name = "path", group_index=1},
      { name = "buffer", keyword_length=1, group_index=1},
      { name = "copilot", group_index=2},
    },
    snippet = {
      expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    experimental = {
      ghost_text = true
    }
  })

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

end

return plugin

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

  cmp.setup({
    mapping = {
      ["J"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        end,
        { "i", "s" }
      ),
      ["K"] = cmp.mapping(
            function(fallback)
              cmp_ultisnips_mappings.jump_backwards(fallback)
            end,
            { "i", "s" }
          ),
      ['L'] = cmp.mapping.scroll_docs(4),
      ['H'] = cmp.mapping.scroll_docs(-4),
      ['<S-CR>'] = cmp.mapping.confirm({ select = true }),
      ['<leader>e'] = cmp.mapping.abort(),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "ultisnips" },
      { name = "path" },
      { name = "buffer", keyword_length = 1},
    },
    snippet = {
      expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
  })

end

return plugin

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
      ['<leader>j'] = cmp.mapping.scroll_docs(4),
      ['<leader>h'] = cmp.mapping.scroll_docs(-4),
      ['L'] = cmp.mapping.confirm({ select = true }),
      ['H'] = cmp.mapping.abort(),
    },
    sources = {
      { name = "ultisnips", group_index=0},
      { name = "copilot", group_index=1},
      { name = "nvim_lsp", group_index=1},
      { name = "path", group_index=1},
      { name = "buffer", keyword_length=1, group_index=1},
    },
    snippet = {
      expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
  })

end

return plugin

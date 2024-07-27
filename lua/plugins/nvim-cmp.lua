local plugin = {'hrsh7th/nvim-cmp'}

plugin.dependencies = {
  -- Sources
  {'quangnguyen30192/cmp-nvim-ultisnips'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-nvim-lua'},
  {'hrsh7th/cmp-nvim-lsp'},
--  {'tzachar/cmp-ai'},

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
      ['<leader>c'] = cmp.mapping(
           cmp.mapping.complete({
             config = {
               sources = cmp.config.sources({
                 { name = 'cmp_ai' },
               }),
             },
           }),
           { "i", "s" }
      ),
      ['<S-CR>'] = cmp.mapping.confirm({ select = true }),
      ['<leader>e'] = cmp.mapping.abort(),
    },
    sources = {
        { name = "ultisnips" },
        { name = "gh_issues" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 1},
    },
    snippet = {
      expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
      end,
    },

  })

--  require('cmp_ai.config'):setup({
--    max_lines = 10,
--    provider = 'Ollama',
--    provider_options = {
--        model = 'codellama:7b-code',
--        options = {
--            temperature = 0.2,
--            num_predict = 15,
--            context = "",
--        }
--    },
--    notify = false,
--    run_on_every_keystroke = false,
--    ignored_file_types = {
--    },
--  })

end

return plugin

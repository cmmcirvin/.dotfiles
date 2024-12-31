local plugin = {"nvim-telescope/telescope.nvim"}

plugin.dependencies = {
  {'nvim-telescope/telescope-file-browser.nvim'},
  {'nvim-lua/plenary.nvim'}
}

function plugin.config()

  local select_one_or_multi = function(prompt_bufnr)
    local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
      require('telescope.actions').close(prompt_bufnr)
      for _, j in pairs(multi) do
        if j.path ~= nil then
          vim.cmd(string.format('%s %s', 'edit', j.path))
        end
      end
    else
      require('telescope.actions').select_default(prompt_bufnr)
    end
  end
  
  require('telescope').setup {
    defaults = {
      layout_strategy = 'flex',
      mappings = {
        i = {
          ['<S-CR>'] = select_one_or_multi,
        },
        n = {
          ['<S-CR>'] = select_one_or_multi,
          ['l'] = require('telescope.actions').toggle_selection,
          ['K'] = require('telescope.actions').preview_scrolling_up,
          ['J'] = require('telescope.actions').preview_scrolling_down,
          ['L'] = require('telescope.actions').preview_scrolling_right,
          ['H'] = require('telescope.actions').preview_scrolling_left,
        }
      },
    }
  }

  vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles)
  vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
  vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
  vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
  vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
  vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics)
  vim.keymap.set('n', '<leader>fe', ':Telescope file_browser<CR>')
  vim.keymap.set('n', '<leader>fc', ':Telescope file_browser path=%:p:h<CR>')

end

return plugin

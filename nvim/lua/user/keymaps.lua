vim.keymap.set("n", "<c-l>", ":bn!<CR>")
vim.keymap.set("n", "<Esc>", "<Esc>:noh<return>")
vim.keymap.set("n", "<c-h>", ":bp!<CR>")
vim.keymap.set("n", "<c-q>", ":bp<bar>bd! #<CR>")
vim.keymap.set("n", "<Esc>", "<Esc>:noh<return>")

vim.keymap.set("n", "<c-j>", ":m .+1<cr>==")
vim.keymap.set("n", "<c-k>", ":m .-2<cr>==")

vim.keymap.set("i", "<c-j>", "<esc>:m .+1<cr>==gi")
vim.keymap.set("i", "<c-k>", "<esc>:m .-2<cr>==gi")

vim.keymap.set("v", "<c-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<c-k>", ":m '<-2<cr>gv=gv")

function open_floating_window()
  local lfs = require('lfs')

  local m1 = vim.fn.col("'<")
  local m2 = vim.fn.col("'>")
  local line_no = vim.fn.winline()
  local line = vim.api.nvim_get_current_line()
  local to_display = line:sub(m1, m2)

  -- get a uuid for the filename
  local handle = io.popen('uuidgen')
  local uuid = handle:read("*a")
  uuid = uuid:gsub("%s+", "")
  handle:close()

  -- create temporary file for image
  local tmp_filename = "/tmp/" .. uuid .. ".png"

  local last_modified_time = lfs.attributes(tmp_filename, "modification")
  require('dap.repl').execute("import matplotlib.pyplot as plt")
  require('dap.repl').execute("plt.imsave('" .. tmp_filename .. "', " .. to_display .. ")")

  local new_last_modified_time = lfs.attributes(tmp_filename, "modification")
  while (new_last_modified_time == last_modified_time) or (tonumber(lfs.attributes(tmp_filename, "size")) == 0) do
    new_last_modified_time = lfs.attributes(tmp_filename, "modification")
  end

  local win_width = vim.api.nvim_get_option("columns")
  local win_height = vim.api.nvim_get_option("lines")

  local api = require("image")
  local image = api.from_file(tmp_filename)
  local aspect_ratio = image.image_height / image.image_width

  local floating_win_width = math.floor(win_width * 0.5)
  local floating_win_height = math.floor(floating_win_width * aspect_ratio / 2)

  local buf = vim.api.nvim_create_buf(false, true)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    width = floating_win_width,
    height = floating_win_height - 2,
    row = 0,
    col = 0,
    style = "minimal",
    border = "none",
  })

  local image = api.from_file(tmp_filename, {buffer=buf, window=win, height=floating_win_height, x=0, y=0})

  image.max_height_window_percentage = 100
  image.max_width_window_percentage = 100
  image:render()

  -- Clear image when buffer is closed
  vim.api.nvim_create_autocmd({"BufWinLeave"}, {
    buffer=buf,
    callback=function()
      image:clear()
      local success, message = io.remove(tmp_filename)
      if not success then
        print("Error removing temporary image file: " .. message)
      end
    end
  })

end

-- vim.keymap.set({'n', 'v'}, '<leader>pl', ':lua open_floating_window()<CR>')

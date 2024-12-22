local set = vim.opt_local

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
  term = {
    buf = -1,
    win = -1,
  },
}

-- toggle the floating terminal
local function toggleFloatingTerm(opts)
  opts = opts or {}

  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- calculate the position of the terminal
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  local win = nil
  if vim.api.nvim_buf_is_valid(state.floating.buf) then
    win = vim.fn.bufwinnr(state.floating.buf)
    if win ~= -1 then
      -- Hide the floating window
      vim.api.nvim_win_hide(vim.fn.win_getid(win))
    else
      -- Show the terminal in a new floating window
      win = vim.api.nvim_open_win(state.floating.buf, true, win_opts)
    end
    return
  end

  -- Create new buffer for the terminal
  local buf = vim.api.nvim_create_buf(false, true)
  win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.fn.termopen(vim.o.shell)

  -- Store terminal state
  state.floating.buf = buf
  state.floating.win = win
  vim.cmd 'startinsert'
end

-- Toggle the bottom terminal
local function toggleTerm()
  if vim.api.nvim_buf_is_valid(state.term.buf) then
    local win = vim.fn.bufwinnr(state.term.buf)
    if win ~= -1 then
      -- Hide the window
      vim.api.nvim_win_hide(vim.fn.win_getid(win))
    else
      -- Show the terminal in a new split
      vim.cmd 'botright split'
      vim.api.nvim_win_set_buf(0, state.term.buf)
      vim.api.nvim_win_set_height(0, 12)
      vim.cmd 'startinsert'
    end
    return
  end

  -- Create new terminal
  vim.cmd 'botright split'
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_win_set_height(0, 12)
  vim.fn.termopen(vim.o.shell)

  -- Store terminal state
  state.term.buf = buf
  state.term.win = vim.api.nvim_get_current_win()
  vim.cmd 'startinsert'
end

vim.keymap.set({ 'n', 't' }, ',ft', toggleFloatingTerm, { desc = 'Toggle Floating Terminal' })
vim.keymap.set({ 'n', 't' }, ',tt', toggleTerm, { desc = 'Toggle Bottom Terminal' })

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', {}),
  callback = function()
    set.number = false
    set.relativenumber = false
    set.scrolloff = 0
    vim.bo.filetype = 'terminal'
  end,
})

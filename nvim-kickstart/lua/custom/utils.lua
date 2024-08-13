local M = {}

--- Get highlight properties for a given highlight name
--- @param name string The highlight group name
--- @param fallback? table The fallback highlight properties
--- @return table properties # the highlight group properties
function M.get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local group = vim.api.nvim_get_hl(0, { name = name })

    local hl = {
      fg = group.fg == nil and 'NONE' or M.parse_hex(group.fg),
      bg = group.bg == nil and 'NONE' or M.parse_hex(group.bg),
    }

    return hl
  end
  return fallback or {}
end

--- Remove a buffer by its number without affecting window layout
--- @param buf? number The buffer number to delete
function M.delete_buffer(buf)
  if buf == nil or buf == 0 then
    buf = vim.api.nvim_get_current_buf()
  end

  vim.api.nvim_command('bwipeout ' .. buf)
end

--- Switch to the previous buffer
function M.switch_to_previous_buffer()
  local ok, _ = pcall(function()
    vim.cmd 'buffer #'
  end)
  if not ok then
    vim.notify('No other buffer to switch to!', 3, { title = 'Warning' })
  end
end

--- Get the number of open buffers
--- @return number
function M.get_buffer_count()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.bufname(buf) ~= '' then
      count = count + 1
    end
  end
  return count
end

--- Parse a given integer color to a hex value.
--- @param int_color number
function M.parse_hex(int_color)
  return string.format('#%x', int_color)
end

-- Initialize a table to store information about the last closed window
M.last_closed_window = {}

-- Function to save the last closed window's info
function M.save_last_closed_window()
  local current_win = vim.api.nvim_get_current_win()
  local win_info = vim.fn.getwininfo(current_win)[1]

  -- Save window info if it's not the only window
  if #vim.api.nvim_tabpage_list_wins(0) > 1 then
    M.last_closed_window = {
      buf = vim.api.nvim_win_get_buf(current_win),
      is_vertical = win_info.wincol > 0,
    }
  else
    M.last_closed_window = {}
  end
end

-- Function to reopen the last closed window
function M.reopen_last_closed_window()
  if next(M.last_closed_window) ~= nil then
    local buf = M.last_closed_window.buf
    local is_vertical = M.last_closed_window.is_vertical

    if is_vertical then
      vim.api.nvim_command 'vsplit'
    else
      vim.api.nvim_command 'split'
    end

    local new_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(new_win, buf)
    M.last_closed_window = {} -- Reset after reopening
  else
    print 'No recently closed window to reopen.'
  end
end

return M

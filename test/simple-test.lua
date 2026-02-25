local ws = require("writing-sessions")

local function test()
  local test_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(test_buf)

  ws.setup()

  vim.api.nvim_buf_set_lines(0, 0, -1, false, { "Hello world" })

  ws.start_writing_session()

  vim.api.nvim_buf_set_lines(0, -1, -1, false, { "This is a test" })

  local status = ws.get_statusline_info()

  ws.terminate_writing_session();


  vim.api.nvim_buf_delete(test_buf, {force = true})
  print(status)
end

test()

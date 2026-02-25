local ws = require("writing-sessions")

vim.api.nvim_create_user_command('WritingStart', ws.start_writing_session , {
  desc = "Start new writing session"
})

vim.api.nvim_create_user_command('WritingStop', ws.terminate_writing_session, {
  desc = "Terminate writing session"
})

vim.api.nvim_create_user_command('WritingProgress', ws.get_session_progress, {
  desc = "Show current session information in a notification"
})


local ws = require("writing-sessions")

vim.api.nvim_create_user_command('WritingStart', ws.start_writing_session , {
  desc = "Start new writing session."
})

vim.api.nvim_create_user_command('WritingStop', ws.terminate_writing_session, {
  desc = "Terminate writing session."
})

vim.api.nvim_create_user_command('WritingResume', ws.resume_writing_session, {
  desc = "Resume the previously terminated writing session. This command can be used multiple times until a new session is started."
})

vim.api.nvim_create_user_command('WritingProgress', ws.get_session_progress, {
  desc = "Show current session information in a notification."
})


local state = require('writing-sessions.state')
local utils = require('writing-sessions.utils')

local M = {}


function M.start_writing_session()
  if state.session_started() then
    vim.notify("Session already started", vim.log.levels.INFO)
    return
  end

  state.init_session()

  vim.notify("Writing Session Started", vim.log.levels.INFO)
end


function M.terminate_writing_session()
  if  not state.session_started() then
    vim.notify("No Writing Session active", vim.log.levels.INFO)
    return
  end

  state.terminate_session()

  local total_words = state.get_total_words()
  local total_time = state.get_time_elapsed()

  local duration = utils.format_time(total_time)
  local wph = utils.calculate_wph(total_words,total_time)

  local session_info = string.format("󰴓 %d | 󰥔  %s |   %d", total_words, duration, wph)

  vim.notify("Writing Session ended. Session info: " .. (session_info), vim.log.levels.INFO)
end


function M.resume_writing_session()
  if state.session_started() then
    vim.notify("Session already started.", vim.log.levels.INFO)
    return

  elseif not state.previous_session_exists() then
    vim.notify("No previous session to resume.", vim.log.levels.INFO)
    return
  end

  local total_words = state.get_total_words()
  local total_time = state.get_time_elapsed()
  local duration = utils.format_time(total_time)

  state.resume_session()

  local session_info = string.format("󰴓 %d | 󰥔  %s ", total_words, duration)

  vim.notify("Writing session resumed. Session info: " .. (session_info), vim.log.levels.INFO)
end


function M.get_statusline_info()
  if not state.session_started() then
    return ""
  end

  local total_words = state.get_total_words()
  local total_time = state.get_time_elapsed()
  local duration = utils.format_time(total_time)

  -- TODO: configure text and info shown
  return string.format("󰴓 %d | 󰥔  %s", total_words, duration)
end


function M.get_session_progress()
  local total_words = state.get_total_words()
  local total_time = state.get_time_elapsed()

  local duration = utils.format_time(total_time)
  local wph = utils.calculate_wph(total_words,total_time)

  local progress = string.format("󰴓 %d | 󰥔  %s |   %d", total_words, duration, wph)

  vim.notify(progress, vim.log.levels.INFO)
end


function M.setup()
  -- print("Writing Sessions is loaded!")
  -- TODO
end

return M


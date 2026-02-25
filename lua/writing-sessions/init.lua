local M = {}

-- TODO: add configs
local state = {
  starting_words = nil,
  starting_time = nil,
  session_started = false
}


local function format_time(seconds)
  local hours = math.floor(seconds / 3600)
  local mins = math.floor((seconds % 3600) / 60)
  local secs = seconds % 60

  return string.format("%02d:%02d:%02d", hours, mins, secs)
end


local function calculate_wph(total_words, seconds)
  local wph = 0

  if seconds > 0 then
    wph = math.floor((total_words / seconds) * 3600)
  end

  return wph
end


local function init_session_state(starting_words, starting_time)
  state.starting_words = starting_words
  state.starting_time = starting_time
  state.session_started = true
end


local function reset_session_state()
  state.starting_words = nil
  state.starting_time = nil
  state.session_started = false
end


local function get_session_state()
  local current_words = vim.fn.wordcount().words
  local current_time = os.time()

  local total_words = current_words - state.starting_words
  local total_time = current_time - state.starting_time

  return total_words, total_time
end


M.start_writing_session = function()
  if state.session_started then
    vim.notify("Session already started", vim.log.levels.INFO)
    return
  end

  init_session_state(vim.fn.wordcount().words, os.time())

  vim.notify("Writing Session Started", vim.log.levels.INFO)
end


M.terminate_writing_session = function()
  if  not state.session_started then
    vim.notify("No Writing Session active", vim.log.levels.INFO)
    return
  end

  local total_words, total_time = get_session_state()

  local duration = format_time(total_time)
  local wph = calculate_wph(total_words,total_time)

  local session_info = string.format("󰴓 %d | 󰥔  %s |   %d", total_words, duration, wph)

  reset_session_state()

  vim.notify("Writing Session ended. Session info: " .. (session_info), vim.log.levels.INFO)
end


M.get_statusline_info = function()
  if not state.session_started  then
    return ""
  end

  local total_words, total_time = get_session_state()
  local duration = format_time(total_time)

  -- TODO: configure text and info shown
  return string.format("󰴓 %d | 󰥔  %s", total_words, duration)
end


M.get_session_progress = function()
  if not state.session_started  then
    return "No Writing Session active"
  end

  local total_words, total_time = get_session_state()

  local duration = format_time(total_time)
  local wph = calculate_wph(total_words,total_time)

  local progress = string.format("󰴓 %d | 󰥔  %s |   %d", total_words, duration, wph)

  vim.notify(progress, vim.log.levels.INFO)
end


M.setup = function()
  -- print("Writing Sessions is loaded!")
  -- TODO
end

return M


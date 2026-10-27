local M = {}

local session_state = {
  starting_words = nil,
  starting_time = nil,
  previous_duration = nil,
  ending_words = nil,
  session_started = false,
}


-- state at the start of a session
function M.init_session()
  session_state.starting_words = vim.fn.wordcount().words
  session_state.starting_time = os.time()
  session_state.previous_duration = 0
  session_state.ending_words = nil
  session_state.session_started = true
end


-- set ending values and set session_started state to false
function M.terminate_session()
  local end_time = os.time()

  session_state.previous_duration = end_time - session_state.starting_time + session_state.previous_duration
  session_state.ending_words = vim.fn.wordcount().words
  session_state.session_started = false
end


-- we restart a new session timer and will add the previous duration to it
-- the starting words are the same as the start of the session
-- this will still count any words written during the pause, but that's a trafeoff
-- we need to make
function M.resume_session()
  session_state.starting_time = os.time()
  session_state.ending_time = nil
  session_state.ending_words = nil
  session_state.session_started = true
end


function M.get_total_words()
  local current_words = nil

  if session_state.session_started then
    current_words = vim.fn.wordcount().words
  else
    current_words = session_state.ending_words
  end

  return current_words - session_state.starting_words
end


function M.get_time_elapsed()
  if session_state.session_started then
    return os.time() - session_state.starting_time + session_state.previous_duration
  else
    return session_state.previous_duration
  end
end


function M.session_started()
  return session_state.session_started
end


-- if previous durarion is nil, it means that there is no previous session yet
function M.previous_session_exists()
  return session_state.previous_duration ~= nil
end

return M


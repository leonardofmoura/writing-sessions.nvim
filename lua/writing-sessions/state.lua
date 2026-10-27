local M = {}

local session_state = {
  starting_words = nil,
  starting_time = nil,
  ending_time = nil,
  ending_words = nil,
  session_started = false
}

-- state at the start of a session
function M.init_session()
  session_state.starting_words = vim.fn.wordcount().words
  session_state.starting_time = os.time()
  session_state.ending_time = nil
  session_state.ending_words = nil
  session_state.session_started = true
end

-- set ending values and set session_started state to false
function M.terminate_session()
  session_state.ending_time = os.time()
  session_state.ending_words = vim.fn.wordcount().words
  session_state.session_started = false
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
  local current_time = nil

  if session_state.session_started then
    current_time = os.time()
  else
    current_time = session_state.ending_time
  end

  return current_time - session_state.starting_time
end


function M.session_started()
  return session_state.session_started
end

return M

# ✒️ writing-sessions.nvim ![alpha](https://img.shields.io/badge/status-alpha-orange) 

A minimal plugin to monitor writing metrics in nvim.

> [!CAUTION]
> **Plugin in active development**

## Features

- **Session Tracking:** Start and stop writing sessions using simple commands.
- **Live Session Progress:** Check the status of your session at any time either via notification or your statusline.
- **Writing metrics:** Monitor the length of your session, how many words you wrote your current WPH (words per hour).


## Requirements

- Neovim >= 0.8.0 (older versions currently untested).
- a [patched font](https://www.nerdfonts.com/) for icon display (configurations for unpatched font support coming soon).

## Installation

You can install this plugin with your package manager of choice.

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "leonardofmoura/writing-sessions.nvim"
}
```

Currently `writing-sessions` does not need any further configuration.

## Usage

### Commands

This plugin offers the following commands:


| Command   | Descriptiom   |
|--------------- | --------------- |
| `:WritingStart`   | Start a new writing session, capturing current word count |
| `:WritingProgress` | Show the current session stats in a notification (time, word count and WPH) |
| `:WritingStop`   | Terminate current session and display session summary in a notification (time, word count and WPH) |


### Statusline integration

To see your session progress in real time, you can add the `get_statusline_info` function in your statusline configuration. This will display session time and the number of words written in the current session (further configuration coming soon).

Using [lualine](https://github.com/nvim-lualine/lualine.nvim) to display as the first item on the right section of the screen:

```lua
{
  sections = {
    lualine_x = {
      { require("writing-sessions").get_statusline_info }
      -- your remaining configuration
    }
  }
}
```


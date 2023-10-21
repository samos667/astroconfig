local wilder = require "wilder"
wilder.setup { modes = { ":", "/", "?" } }
-- Disable Python remote plugin
-- wilder.set_option("use_python_remote_plugin", 0)

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline {
      fuzzy = 1,
      fuzzy_filter = wilder.lua_fzy_filter(),
    },
    wilder.vim_search_pipeline()
  ),
})

local highlighters = {
  wilder.pcre2_highlighter(),
  wilder.lua_fzy_highlighter(),
}

wilder.set_option(
  "renderer",
  wilder.renderer_mux {
    [":"] = wilder.popupmenu_renderer {
      highlighter = wilder.lua_fzy_highlighter(),
      left = {
        " ",
        wilder.popupmenu_devicons(),
      },
      right = {
        " ",
        wilder.popupmenu_scrollbar(),
      },
    },
    ["/"] = wilder.wildmenu_renderer {
      highlighter = wilder.lua_fzy_highlighter(),
    },
  }
)

local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
  border = "rounded",
  max_height = "50%",
  min_height = 0,
  prompt_position = "top",
  reverse = 0,
  highlighter = highlighters,
  highlights = {
    accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
  },
  left = {
    " ",
    wilder.popupmenu_devicons(),
    wilder.popupmenu_buffer_flags {
      flags = " a + ",
      icons = { ["+"] = "", a = "", h = "" },
    },
  },
})

local wildmenu_renderer = wilder.wildmenu_renderer {
  apply_incsearch_fix = false,
  highlighter = highlighters,
  separator = " | ",
  left = { " ", wilder.wildmenu_spinner(), " " },
  right = { " ", wilder.wildmenu_index() },
}
-- Substitute completion
wilder.set_option(
  "renderer",
  wilder.renderer_mux {
    [":"] = popupmenu_renderer,
    ["/"] = wildmenu_renderer,
    substitute = wildmenu_renderer,
  }
)

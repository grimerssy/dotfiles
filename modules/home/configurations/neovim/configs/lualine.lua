local lualine = require("lualine")
local git = require("lualine.components.branch.git_branch")
local utils = require("lualine.utils.utils")

local foreground = "#333333"

local function color(higroup)
  return utils.extract_color_from_hllist("fg", { higroup }, nil)
end

local function theme(fg, bg)
  return {
    a = { bg = nil, fg = bg },
    b = { bg = bg, fg = fg },
    c = { bg = nil, fg = bg },
  }
end

local function literal(str)
  return function()
    return str
  end
end

local left = literal("")
local right = literal("")

local function has_git_context()
  return git.get_branch() ~= ""
end

lualine.setup({
  options = {
    theme = {
      normal = theme(foreground, color("String")),
      insert = theme(foreground, color("Function")),
      command = theme(foreground, color("Keyword")),
      visual = theme(foreground, color("Constant")),
      replace = theme(foreground, color("Error")),
      inactive = theme(nil, nil),
    },
    globalstatus = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { { left, padding = 0 } },
    lualine_b = { { "mode", padding = 0 } },
    lualine_c = { { right, padding = 0 } },
    lualine_x = { { left, padding = 0, cond = has_git_context } },
    lualine_y = {
      {
        "branch",
        icon = {
          "",
          align = "right",
        },
        padding = 0,
      },
    },
    lualine_z = { { right, padding = 0, cond = has_git_context } },
  },
})

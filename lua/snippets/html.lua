local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("html", {
  s("html5", {
    t({ "<!DOCTYPE html>", "<html>", "<head>", "  <title>" }),
    t({ "</title>", "</head>", "<body>", "", "</body>", "</html>" }),
  }),
})


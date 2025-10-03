-- ~/.config/nvim/lua/snippets/react.lua

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("javascriptreact", {
  s("rfc", {
    t({ "import React from 'react';", "", "function " }),
    i(1, "ComponentName"),
    t({ "() {", "  return (", "    <div>" }),
    i(2, "Hello, world!"),
    t({ "</div>", "  );", "}", "", "export default " }),
    i(1),
    t(";"),
  }),

  s("us", {
    t("const ["),
    i(1, "state"),
    t(", "),
    i(2, "setState"),
    t("] = React.useState("),
    i(3, "initialValue"),
    t(");"),
  }),

  s("ue", {
    t({ "React.useEffect(() => {", "  " }),
    i(1, "// effect"),
    t({ "", "  return () => {", "    " }),
    i(2, "// cleanup"),
    t({ "", "  }", "}, [" }),
    i(3),
    t("]);"),
  }),
})


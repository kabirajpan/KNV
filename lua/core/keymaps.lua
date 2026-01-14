local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =============================
-- Global Variables for Selection State
-- =============================
local selection_state = {
	is_selecting = false,
	selection_type = nil,
	start_pos = nil,
}

local function clear_selection_state()
	selection_state.is_selecting = false
	selection_state.selection_type = nil
	selection_state.start_pos = nil
end

local function start_selection(type, start_pos)
	selection_state.is_selecting = true
	selection_state.selection_type = type
	selection_state.start_pos = start_pos or vim.api.nvim_win_get_cursor(0)
end

-- =============================
-- Enable Mouse Support Globally
-- =============================
vim.opt.mouse = "a"
vim.opt.mousemodel = "popup_setpos"

-- =============================
-- Clear Conflicting Default Mappings
-- =============================
-- Clear only the ones that actually conflict, keep essential vim functions
local conflicting_keys = {
	"<C-s>",
	"<C-x>",
	"<C-c>",
	"<C-v>",
	"<A-Up>",
	"<A-Down>",
	"<A-S-Up>",
	"<A-S-Down>",
}

for _, key in ipairs(conflicting_keys) do
	pcall(function()
		vim.keymap.del({ "n", "i", "v" }, key)
	end)
end

-- =============================
-- Mode Switching Keys (INSERT/NORMAL/VISUAL)
-- =============================
-- Enter Insert mode
map("n", "i", "i", opts) -- Insert before cursor
map("n", "I", "I", opts) -- Insert at beginning of line
map("n", "a", "a", opts) -- Insert after cursor
map("n", "A", "A", opts) -- Insert at end of line
map("n", "o", "o", opts) -- Insert new line below
map("n", "O", "O", opts) -- Insert new line above

-- Enter Visual mode
map("n", "v", "v", opts) -- Visual character mode
map("n", "V", "V", opts) -- Visual line mode
map("n", "<C-v>", "<C-v>", opts) -- Visual block mode (but will be overridden by paste)

-- Exit to Normal mode
map({ "i", "v", "s", "x" }, "<Esc>", "<Esc>", opts) -- Standard escape
map("i", "jk", "<Esc>", opts) -- Alternative: jk to escape
map("t", "<Esc>", "<C-\\><C-n>", opts) -- Exit terminal mode

-- Quick mode switches
map("v", "i", "<Esc>i", opts) -- Visual to Insert
map("v", "a", "<Esc>a", opts) -- Visual to Insert after

-- =============================
-- VS Code Basic Operations (FIXED)
-- =============================

-- Select All (Ctrl+A) - FIXED
vim.keymap.set("n", "<C-a>", "ggVG", opts)
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true, desc = "Select All in insert mode" })

-- =============================
-- Fix Ctrl+Z Terminal Suspension
-- =============================
-- Undo (Ctrl+Z)
vim.keymap.set("n", "<C-z>", "u", opts)
vim.keymap.set("i", "<C-z>", "<C-o>u", { noremap = true, silent = true, desc = "Undo in insert mode" })

-- Redo (Ctrl+Y, Ctrl+Shift+Z)
vim.keymap.set("n", "<C-y>", "<C-r>", opts) -- Ctrl+Y as redo
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", opts)

-- Copy/Cut/Paste (FIXED - Better clipboard integration)
map("v", "<C-c>", '"+y', opts) -- Copy selection
map("n", "<C-c>", '"+yy', opts) -- Copy line
map("i", "<C-c>", '<C-o>"+yy', opts) -- Copy line in insert mode

map("v", "<C-x>", '"+d', opts) -- Cut selection
map("n", "<C-x>", '"+dd', opts) -- Cut line
map("i", "<C-x>", '<C-o>"+dd', opts) -- Cut line in insert mode

map("n", "<C-v>", '"+p', opts) -- Paste in normal mode
map("v", "<C-v>", '"+p', opts) -- Paste over selection
map("i", "<C-v>", "<C-r>+", opts) -- Paste in insert mode

map("c", "<C-v>", "<C-r>+", opts) -- Paste in command mode

-- Save (Ctrl+S)
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<C-o>:w<CR>", opts)

-- =============================
-- VS Code Cursor Movement
-- =============================
-- Home/End behavior
map("n", "<Home>", "^", opts)
map("i", "<Home>", "<C-o>^", opts)
map("n", "<End>", "$", opts)
map("i", "<End>", "<End>", opts)

-- Word movement (Ctrl+Left/Right)
map("n", "<C-Left>", "b", opts)
map("n", "<C-Right>", "w", opts)
map("i", "<C-Left>", "<C-o>b", opts)
map("i", "<C-Right>", "<C-o>w", opts)

-- =============================
-- VS Code Text Selection (FIXED)
-- =============================
-- Character selection (Shift+Arrow keys)
map("n", "<S-Left>", "vh", opts)
map("n", "<S-Right>", "vl", opts)
map("n", "<S-Up>", "vk", opts)
map("n", "<S-Down>", "vj", opts)
map("v", "<S-Left>", "h", opts)
map("v", "<S-Right>", "l", opts)
map("v", "<S-Up>", "k", opts)
map("v", "<S-Down>", "j", opts)

-- Insert mode selection
map("i", "<S-Left>", function()
	if not selection_state.is_selecting then
		start_selection("char")
		return "<C-o>v<Left>"
	else
		return "<C-o><Left>"
	end
end, { expr = true, noremap = true, silent = true })

map("i", "<S-Right>", function()
	if not selection_state.is_selecting then
		start_selection("char")
		return "<C-o>v<Right>"
	else
		return "<C-o><Right>"
	end
end, { expr = true, noremap = true, silent = true })

-- Word selection (Ctrl+Shift+Left/Right) - FIXED
map("n", "<C-S-Left>", "vb", opts)
map("n", "<C-S-Right>", "ve", opts) -- Changed from "vw" to "ve" for proper word end selection
map("v", "<C-S-Left>", "b", opts)
map("v", "<C-S-Right>", "e", opts) -- Changed from "w" to "e" for proper word end selection

-- Insert mode word selection - FIXED
map("i", "<C-S-Left>", function()
	if not selection_state.is_selecting then
		start_selection("word")
		return "<C-o>vb"
	else
		return "<C-o>b"
	end
end, { expr = true, noremap = true, silent = true })

map("i", "<C-S-Right>", function()
	if not selection_state.is_selecting then
		start_selection("word")
		return "<C-o>ve"
	else
		return "<C-o>e"
	end
end, { expr = true, noremap = true, silent = true })

-- Line selection (Shift+Home/End)
map("n", "<S-Home>", "v^", opts)
map("n", "<S-End>", "v$", opts)
map("v", "<S-Home>", "^", opts)
map("v", "<S-End>", "$", opts)

map("i", "<S-Home>", function()
	if not selection_state.is_selecting then
		start_selection("line_start")
		return "<C-o>v^"
	else
		return "<C-o>^"
	end
end, { expr = true, noremap = true, silent = true })

map("i", "<S-End>", function()
	if not selection_state.is_selecting then
		start_selection("line_end")
		return "<C-o>v$"
	else
		return "<C-o>$"
	end
end, { expr = true, noremap = true, silent = true })

-- Cancel selection and move cursor
local function handle_movement_key(key)
	return function()
		if selection_state.is_selecting then
			clear_selection_state()
			if vim.fn.mode():match("[vV]") then
				if key == "<Right>" or key == "<Down>" or key == "<End>" then
					return "<Esc>`>i"
				else
					return "<Esc>`<i"
				end
			end
		end
		return key
	end
end

map("i", "<Left>", handle_movement_key("<Left>"), { expr = true, noremap = true, silent = true })
map("i", "<Right>", handle_movement_key("<Right>"), { expr = true, noremap = true, silent = true })
map("i", "<Up>", handle_movement_key("<Up>"), { expr = true, noremap = true, silent = true })
map("i", "<Down>", handle_movement_key("<Down>"), { expr = true, noremap = true, silent = true })

-- =============================
-- VS Code Line Operations
-- =============================
-- Move lines up/down (Alt+Up/Down)
map("n", "<A-Up>", ":m .-2<CR>==", opts)
map("n", "<A-Down>", ":m .+1<CR>==", opts)
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- Duplicate lines (Alt+Shift+Up/Down)
map("n", "<A-S-Up>", "yyP", opts)
map("n", "<A-S-Down>", "yyp", opts)
map("i", "<A-S-Up>", "<Esc>yyPgi", opts)
map("i", "<A-S-Down>", "<Esc>yypgi", opts)
map("v", "<A-S-Up>", "y`>pgv", opts)
map("v", "<A-S-Down>", "y`<Pgv", opts)

-- Delete line (Ctrl+Shift+K)
map("n", "<C-S-k>", "dd", opts)
map("i", "<C-S-k>", "<C-o>dd", opts)

-- =============================
-- Buffer/Tab Switching (FIXED)
-- =============================
-- Buffer switching - using multiple reliable methods
map("n", "<A-Left>", ":bprevious<CR>", opts) -- Alt+Left: Previous buffer
map("n", "<A-Right>", ":bnext<CR>", opts) -- Alt+Right: Next buffer

-- Fallback mappings in case Alt keys don't work
map("n", "<leader>h", ":bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>l", ":bnext<CR>", { desc = "Next buffer" })

-- Buffer switching - terminal-safe
map("n", "<A-Left>", function()
	if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
		vim.cmd("bprevious")
	end
end, opts)

map("n", "<A-Right>", function()
	if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
		vim.cmd("bnext")
	end
end, opts)

-- Ctrl+Tab alternatives (some terminals don't support this)
map("n", "<C-S-Tab>", ":bprevious<CR>", opts)
map("n", "<C-Tab>", ":bnext<CR>", opts)

-- Leader-based buffer switching (always works)
map("n", "<leader>bp", ":bprevious<CR>", opts)
map("n", "<leader>bn", ":bnext<CR>", opts)

-- Buffer management
map("n", "<C-n>", ":enew<CR>", opts) -- New buffer
map("n", "<C-w>", ":bd<CR>", opts) -- Close buffer

-- Quick buffer access
map("n", "<C-b>", "<cmd>Telescope buffers<cr>", opts) -- Buffer list

-- Go to specific buffers (Ctrl+1-9)
for i = 1, 9 do
	map("n", "<C-" .. i .. ">", function()
		local buffers = vim.fn.getbufinfo({ buflisted = 1 })
		if buffers[i] and vim.api.nvim_buf_is_valid(buffers[i].bufnr) then
			vim.api.nvim_set_current_buf(buffers[i].bufnr)
		end
	end, opts)
end

-- Move buffer tabs left/right
map("n", "<A-S-Left>", ":BufferLineMovePrev<CR>", opts) -- Alt+Shift+Left → move tab left
map("n", "<A-S-Right>", ":BufferLineMoveNext<CR>", opts) -- Alt+Shift+Right → move tab right

-- =============================
-- File Explorer with Mouse Support
-- =============================
-- Universal File Explorer Toggle (Ctrl + E from any mode)
local function toggle_file_explorer()
	local mode = vim.fn.mode()

	if mode == "i" or mode == "v" or mode == "V" or mode == "" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	elseif mode == "t" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
	end

	vim.schedule(function()
		if vim.fn.exists(":NvimTreeToggle") == 2 then
			vim.cmd("NvimTreeToggle")
		elseif vim.fn.exists(":NeoTreeToggle") == 2 then
			vim.cmd("NeoTreeToggle")
		else
			vim.cmd("Explore")
		end
	end)
end

map({ "n", "i", "v", "t" }, "<C-e>", toggle_file_explorer, opts)
map("n", "<leader>e", toggle_file_explorer, opts)

-- NvimTree mouse support
vim.api.nvim_create_autocmd("FileType", {
	pattern = "NvimTree",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()

		-- Auto exit insert/visual mode on mouse click
		local function auto_open_file()
			-- Leave insert/visual mode
			local mode = vim.fn.mode()
			if mode == "i" or mode:match("[vV]") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end

			-- Simulate <CR> to open the file
			vim.schedule(function()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
			end)
		end

		-- Set mouse click bindings
		vim.keymap.set(
			{ "n", "i", "v" },
			"<2-LeftMouse>",
			auto_open_file,
			{ buffer = bufnr, noremap = true, silent = true }
		)
		vim.keymap.set({ "n", "i", "v" }, "<CR>", auto_open_file, { buffer = bufnr, noremap = true, silent = true })
	end,
})

-- =============================
-- Mouse Support
-- =============================
-- Basic mouse support
map("n", "<LeftMouse>", "<LeftMouse>", opts)
map("n", "<2-LeftMouse>", "<2-LeftMouse>", opts)
map("n", "<RightMouse>", "<RightMouse>", opts)

-- Smarter scrolling
map("n", "<ScrollWheelUp>", "3<C-y>", opts) -- scroll up
map("n", "<ScrollWheelDown>", "3<C-e>", opts) -- scroll down
map("i", "<ScrollWheelUp>", "<C-o>3<C-y>", opts)
map("i", "<ScrollWheelDown>", "<C-o>3<C-e>", opts)

-- Horizontal scrolling with Shift + Scroll
map("n", "<S-ScrollWheelUp>", "3zh", opts) -- scroll left
map("n", "<S-ScrollWheelDown>", "3zl", opts) -- scroll right
map("i", "<S-ScrollWheelUp>", "<C-o>3zh", opts)
map("i", "<S-ScrollWheelDown>", "<C-o>3zl", opts)

-- Middle mouse paste
map({ "n", "v" }, "<MiddleMouse>", '"+p', opts)
map("i", "<MiddleMouse>", "<C-r>+", opts)

-- =============================
-- VS Code Text Editing
-- =============================
-- Delete word left/right
map("i", "<C-BS>", "<C-w>", opts)
map("i", "<C-H>", "<C-w>", opts)
map("i", "<C-Del>", "<C-o>dw", opts)

-- Toggle comment (Ctrl+/) - FIXED
-- Clear any existing conflicting mappings first
pcall(function()
	vim.keymap.del("n", "<C-/>")
end)
pcall(function()
	vim.keymap.del("i", "<C-/>")
end)
pcall(function()
	vim.keymap.del("v", "<C-/>")
end)
pcall(function()
	vim.keymap.del("n", "<C-_>")
end)
pcall(function()
	vim.keymap.del("i", "<C-_>")
end)
pcall(function()
	vim.keymap.del("v", "<C-_>")
end)

-- Simple comment toggle function (works without any plugins)
local function simple_comment_toggle()
	local line = vim.api.nvim_get_current_line()
	local commentstring = vim.bo.commentstring

	if commentstring == "" then
		-- Default to // for unknown file types
		commentstring = "// %s"
	end

	-- Extract comment prefix (everything before %s)
	local prefix = commentstring:match("^(.-)%%s") or "//"
	prefix = vim.trim(prefix)

	-- Check if line is already commented
	local trimmed_line = vim.trim(line)
	if trimmed_line:sub(1, #prefix) == prefix then
		-- Uncomment: remove comment prefix
		local new_line = line:gsub("^(%s*)" .. vim.pesc(prefix) .. "%s?", "%1")
		vim.api.nvim_set_current_line(new_line)
	else
		-- Comment: add comment prefix
		local indent = line:match("^%s*")
		local content = line:sub(#indent + 1)
		if content ~= "" then
			vim.api.nvim_set_current_line(indent .. prefix .. " " .. content)
		else
			vim.api.nvim_set_current_line(line)
		end
	end
end

-- Visual mode comment toggle
local function visual_comment_toggle()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	-- Save cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)

	-- Toggle comment for each line in selection
	for line_num = start_line, end_line do
		vim.api.nvim_win_set_cursor(0, { line_num, 0 })
		simple_comment_toggle()
	end

	-- Restore cursor position
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end

-- Check if Comment.nvim is available
local comment_available, comment_api = pcall(require, "Comment.api")

if comment_available then
	-- Using Comment.nvim
	map("n", "<C-/>", function()
		comment_api.toggle.linewise.current()
	end, { noremap = true, silent = true, desc = "Toggle comment" })

	map("i", "<C-/>", function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
		vim.schedule(function()
			comment_api.toggle.linewise.current()
			vim.api.nvim_feedkeys("a", "n", true)
		end)
	end, { noremap = true, silent = true, desc = "Toggle comment in insert mode" })

	map("v", "<C-/>", function()
		local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		vim.api.nvim_feedkeys(esc, "nx", false)
		comment_api.toggle.linewise(vim.fn.visualmode())
	end, { noremap = true, silent = true, desc = "Toggle comment in visual mode" })
else
	-- Use our simple comment function
	map("n", "<C-/>", simple_comment_toggle, { noremap = true, silent = true, desc = "Toggle comment" })
	map("i", "<C-/>", function()
		simple_comment_toggle()
	end, { noremap = true, silent = true, desc = "Toggle comment in insert mode" })
	map("v", "<C-/>", function()
		visual_comment_toggle()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	end, { noremap = true, silent = true, desc = "Toggle comment in visual mode" })
end

-- Alternative mapping for terminals that don't support Ctrl+/
map("n", "<C-_>", function()
	if comment_available then
		comment_api.toggle.linewise.current()
	else
		simple_comment_toggle()
	end
end, { noremap = true, silent = true, desc = "Toggle comment (alternative)" })

map("i", "<C-_>", function()
	if comment_available then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
		vim.schedule(function()
			comment_api.toggle.linewise.current()
			vim.api.nvim_feedkeys("a", "n", true)
		end)
	else
		simple_comment_toggle()
	end
end, { noremap = true, silent = true, desc = "Toggle comment in insert (alternative)" })

map("v", "<C-_>", function()
	if comment_available then
		local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		vim.api.nvim_feedkeys(esc, "nx", false)
		comment_api.toggle.linewise(vim.fn.visualmode())
	else
		visual_comment_toggle()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	end
end, { noremap = true, silent = true, desc = "Toggle comment in visual (alternative)" })

-- Indent/Unindent
map("v", "<Tab>", ">gv", opts)
map("v", "<S-Tab>", "<gv", opts)
map("n", "<Tab>", ">>", opts)
map("n", "<S-Tab>", "<<", opts)
map("i", "<S-Tab>", "<C-d>", opts)

-- =============================
-- Find/Replace (FIXED)
-- =============================
map("n", "<C-f>", "/", { noremap = true })
map("i", "<C-f>", "<C-o>/", { noremap = true })
map("n", "<C-h>", ":%s/", { noremap = true })
map("n", "<F3>", "n", opts)
map("n", "<S-F3>", "N", opts)

-- =============================
-- Quick Actions
-- =============================
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)
map("n", "<C-S-p>", "<cmd>Telescope commands<cr>", opts)
map("n", "<C-S-f>", "<cmd>Telescope live_grep<cr>", opts)

-- =============================
-- Terminal
-- =============================
map({ "n", "i", "v" }, "<C-`>", "<cmd>ToggleTerm<cr>", opts)
map("t", "<C-`>", "<cmd>ToggleTerm<cr>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- Terminal Copy/Paste (ADD THESE NEW LINES)
map("t", "<C-S-v>", '<C-\\><C-n>"+pi', opts) -- Paste with Ctrl+Shift+V
map("t", "<S-Insert>", '<C-\\><C-n>"+pi', opts) -- Paste with Shift+Insert

-- =============================
-- LSP Keymaps
-- =============================
map("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<C-.>", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<S-F12>", vim.lsp.buf.references, { desc = "Find references" })

-- =============================
-- Telescope (Leader-based)
-- =============================
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- =============================
-- Git
-- =============================
map("n", "<leader>gs", "<cmd>Git<CR>", opts)
map("n", "<leader>lg", "<cmd>LazyGit<CR>", opts)

-- =============================
-- Auto-commands for Selection State
-- =============================
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	pattern = "*",
	callback = function()
		clear_selection_state()
	end,
})

-- Clear search highlight on Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Telescope theme switcher
map("n", "<leader>ut", "<cmd>Telescope colorscheme enable_preview=true<CR>", opts)

-- =============================
-- Additional Useful Mappings
-- =============================
-- Quick save and quit
map("n", "<C-q>", ":q<CR>", opts)
map("n", "<C-S-q>", ":qa<CR>", opts)

-- Better escape from insert mode
map("i", "<C-c>", "<Esc>", opts)

-- Better line joining
map("n", "J", "mzJ`z", opts)

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Better search behavior
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

--===================================
--          AI Toggle (F9/F10)
--===================================

-- F9: Toggle AI (Copilot <-> Codeium)
vim.keymap.set("n", "<F9>", function()
	local copilot_active = false
	local codeium_active = vim.g.codeium_enabled ~= false

	local ok_copilot, copilot = pcall(require, "copilot.api")
	if ok_copilot and copilot.status and copilot.status.data then
		local status = copilot.status.data.status
		if status == "Normal" or status == "InProgress" then
			copilot_active = true
		end
	end

	if copilot_active then
		vim.cmd("Copilot disable")
		if ok_copilot then
			copilot.status.data.status = "Disabled"
		end

		if pcall(require, "codeium") then
			pcall(vim.cmd, "CodeiumEnable")
			vim.g.codeium_enabled = true
			vim.notify("Codeium enabled", vim.log.levels.INFO)
		end
	else
		if pcall(require, "codeium") then
			pcall(vim.cmd, "CodeiumDisable")
			vim.g.codeium_enabled = false
		end
		vim.cmd("Copilot enable")
		vim.notify("Copilot enabled", vim.log.levels.INFO)
	end

	-- Update both UI components
	local ok_barbecue, barbecue = pcall(require, "barbecue")
	if ok_barbecue and barbecue.update then
		barbecue.update()
	end

	-- FIX: Also refresh lualine
	local ok_lualine, lualine = pcall(require, "lualine")
	if ok_lualine and lualine.refresh then
		lualine.refresh()
	end
end, { desc = "Toggle Copilot ↔ Codeium (F9)" })

-- F10: Enable/Disable both AI
vim.keymap.set("n", "<F10>", function()
	local copilot_active = false
	local codeium_active = vim.g.codeium_enabled ~= false

	local ok_copilot, copilot = pcall(require, "copilot.api")
	if ok_copilot and copilot.status and copilot.status.data then
		local status = copilot.status.data.status
		if status == "Normal" or status == "InProgress" then
			copilot_active = true
		end
	end

	if copilot_active or codeium_active then
		vim.cmd("Copilot disable")
		if ok_copilot then
			copilot.status.data.status = "Disabled"
		end
		pcall(vim.cmd, "CodeiumDisable")
		vim.g.codeium_enabled = false
		vim.notify("AI disabled", vim.log.levels.INFO)
	else
		vim.cmd("Copilot enable")
		vim.notify("Copilot enabled", vim.log.levels.INFO)
	end

	-- Update both UI components
	local ok_barbecue, barbecue = pcall(require, "barbecue")
	if ok_barbecue and barbecue.update then
		barbecue.update()
	end

	-- FIX: Also refresh lualine
	local ok_lualine, lualine = pcall(require, "lualine")
	if ok_lualine and lualine.refresh then
		lualine.refresh()
	end
end, { desc = "Enable/Disable AI (F10)" })

-- =============================
-- Auto-open project file explorer if no file is passed
-- (but don't override dashboard)
-- =============================

--[[
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only open file explorer if:
    -- 1. No arguments passed
    -- 2. Not in a dashboard buffer
    -- 3. Not in a special buffer
    if vim.fn.argc() == 0 then
      local bufname = vim.api.nvim_buf_get_name(0)
      local buftype = vim.bo.filetype
      
      -- Skip if dashboard or special buffer is already open
      local skip_filetypes = {
        "dashboard",
        "alpha",
        "starter",
        "lazy",
        "mason",
        "neo-tree",
        "NvimTree",
      }
      
      for _, ft in ipairs(skip_filetypes) do
        if buftype == ft then
          return
        end
      end
      
      -- Also check buffer name for dashboard
      if bufname:match("dashboard") or bufname:match("alpha") then
        return
      end
      
      -- If we're still here, we can open the file explorer
      vim.defer_fn(function()
        -- Only open if still no file loaded
        if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
          if vim.fn.exists(":NvimTreeOpen") == 2 then
            vim.cmd("NvimTreeOpen")
          elseif vim.fn.exists(":NeoTreeFloatToggle") == 2 then
            vim.cmd("NeoTreeFloatToggle")
          else
            vim.cmd("Explore .")
          end
          
          -- Close empty [No Name] buffer
          local buf = vim.api.nvim_get_current_buf()
          if vim.api.nvim_buf_get_name(buf) == "" then
            pcall(vim.cmd, "bdelete")
          end
        end
      end, 100) -- Add small delay to let dashboard load first
    end
  end
})

]]
--

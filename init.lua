vim.opt.clipboard = "unnamedplus" -- Clipboard support

-- Load core configuration (this loads all plugins)
require("core")

-- Neovide-specific configuration (MUST be after require("core"))
if vim.g.neovide then
	-- Display settings
	vim.g.neovide_scale_factor = 0.8

	-- KEY FIX: Disable logo key and improve key handling
	vim.g.neovide_input_use_logo = false
	vim.g.neovide_input_macos_alt_is_meta = true

	-- Defer Neovide keymaps until plugins are fully loaded
	vim.defer_fn(function()
		-- Ensure Ctrl+E works in Neovide for file explorer
		vim.keymap.set({ "n", "i", "v", "t" }, "<C-e>", function()
			local mode = vim.fn.mode()

			-- Exit insert/visual mode first
			if mode == "i" or mode == "v" or mode == "V" or mode == "^V" then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			elseif mode == "t" then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
			end

			vim.schedule(function()
				if vim.fn.exists(":NvimTreeToggle") == 2 then
					vim.cmd("NvimTreeToggle")
				end
			end)
		end, { noremap = true, silent = true, desc = "Toggle NvimTree in Neovide" })

		-- FIX: Command mode paste for Neovide with proper redraw
		vim.keymap.set("c", "<C-v>", function()
			-- Get clipboard content
			local clipboard = vim.fn.getreg("+")
			-- Return the content to be inserted
			return clipboard
		end, { expr = true, noremap = true, silent = true })

		vim.keymap.set("c", "<C-S-v>", function()
			local clipboard = vim.fn.getreg("+")
			return clipboard
		end, { expr = true, noremap = true, silent = true })
	end, 100) -- Wait 100ms for plugins to load

	-- Scale controls (these can be set immediately)
	vim.keymap.set("n", "<C-=>", function()
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
	end)
	vim.keymap.set("n", "<C-minus>", function()
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
	end)
	vim.keymap.set("n", "<C-0>", function()
		vim.g.neovide_scale_factor = 1.0
	end)
end

-- lua/plugins/terminal-enhanced.lua
-- Better terminal integration with multiple terminals and REPL support

return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = [[<c-`>]],
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,
				direction = "horizontal",
				close_on_exit = true,
				shell = vim.o.shell,
				auto_scroll = true,
				float_opts = {
					border = "curved",
					winblend = 0,
				},
			})

			-- Terminal keymaps
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

			-- Multiple terminal instances
			local Terminal = require("toggleterm.terminal").Terminal

			-- Terminal 1: General purpose
			local term1 = Terminal:new({ direction = "horizontal", count = 1 })
			function _TERM1_TOGGLE()
				term1:toggle()
			end

			-- Terminal 2: Build/compile
			local term2 = Terminal:new({ direction = "horizontal", count = 2 })
			function _TERM2_TOGGLE()
				term2:toggle()
			end

			-- Terminal 3: Floating terminal
			local term_float = Terminal:new({
				direction = "float",
				count = 3,
				float_opts = {
					border = "double",
				},
			})
			function _TERM_FLOAT_TOGGLE()
				term_float:toggle()
			end

			-- Gradle terminal
			local gradle_term = Terminal:new({
				cmd = "./gradlew --console=plain",
				direction = "horizontal",
				close_on_exit = false,
			})
			function _GRADLE_TERM()
				gradle_term:toggle()
			end

			-- Maven terminal
			local mvn_term = Terminal:new({
				cmd = "./mvnw",
				direction = "horizontal",
				close_on_exit = false,
			})
			function _MVN_TERM()
				mvn_term:toggle()
			end

			-- Kotlin REPL
			local kotlin_repl = Terminal:new({
				cmd = "kotlin",
				direction = "horizontal",
				close_on_exit = false,
			})
			function _KOTLIN_REPL()
				kotlin_repl:toggle()
			end

			-- Python REPL
			local python_repl = Terminal:new({
				cmd = "python3",
				direction = "horizontal",
				close_on_exit = false,
			})
			function _PYTHON_REPL()
				python_repl:toggle()
			end

			-- Node REPL
			local node_repl = Terminal:new({
				cmd = "node",
				direction = "horizontal",
				close_on_exit = false,
			})
			function _NODE_REPL()
				node_repl:toggle()
			end

			-- Keymaps for multiple terminals
			vim.keymap.set("n", "<leader>t1", "<cmd>lua _TERM1_TOGGLE()<CR>", { desc = "[T]erminal [1]" })
			vim.keymap.set("n", "<leader>t2", "<cmd>lua _TERM2_TOGGLE()<CR>", { desc = "[T]erminal [2]" })
			vim.keymap.set("n", "<leader>tf", "<cmd>lua _TERM_FLOAT_TOGGLE()<CR>", { desc = "[T]erminal [F]loat" })
			vim.keymap.set("n", "<leader>tg", "<cmd>lua _GRADLE_TERM()<CR>", { desc = "[T]erminal [G]radle" })
			vim.keymap.set("n", "<leader>tm", "<cmd>lua _MVN_TERM()<CR>", { desc = "[T]erminal [M]aven" })

			-- REPL keymaps
			vim.keymap.set("n", "<leader>rk", "<cmd>lua _KOTLIN_REPL()<CR>", { desc = "[R]EPL [K]otlin" })
			vim.keymap.set("n", "<leader>rp", "<cmd>lua _PYTHON_REPL()<CR>", { desc = "[R]EPL [P]ython" })
			vim.keymap.set("n", "<leader>rn", "<cmd>lua _NODE_REPL()<CR>", { desc = "[R]EPL [N]ode" })

			-- Send selection to terminal
			vim.keymap.set("v", "<leader>ts", function()
				local start_line = vim.fn.line("'<")
				local end_line = vim.fn.line("'>")
				local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
				local text = table.concat(lines, "\n")

				-- Send to the currently active terminal
				require("toggleterm").exec(text)
			end, { desc = "[T]erminal [S]end selection" })
		end,
	},
}

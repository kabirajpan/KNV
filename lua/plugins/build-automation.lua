-- lua/plugins/build-automation.lua
-- Auto-format on save, build watchers, error quickfix integration

return {
	-- Auto-format on save (enhance existing conform.nvim)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					tsx = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					sql = { "sql_formatter" },
					c = { "clang_format" },
					cpp = { "clang_format" },
					java = { "google_java_format" },
					kotlin = { "ktlint" },
					rust = { "rustfmt" },
					sh = { "shfmt" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})

			-- Manual format command
			vim.keymap.set({ "n", "v" }, "<leader>cf", function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "[C]ode [F]ormat" })

			-- Toggle auto-format
			vim.g.disable_autoformat = false
			vim.keymap.set("n", "<leader>tf", function()
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				if vim.g.disable_autoformat then
					vim.notify("Auto-format disabled", vim.log.levels.INFO)
				else
					vim.notify("Auto-format enabled", vim.log.levels.INFO)
				end
			end, { desc = "[T]oggle auto-[F]ormat" })
		end,
	},

	-- Error quickfix integration
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols (Trouble)" },
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
		},
		config = function()
			require("trouble").setup({
				auto_close = true,
				auto_open = false,
				use_diagnostic_signs = true,
			})
		end,
	},

	-- Build status and notifications
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			text = {
				spinner = "dots",
				done = "✓",
			},
			window = {
				blend = 0,
			},
		},
	},

	-- Auto-save (optional, can be enabled)
	{
		"pocco81/auto-save.nvim",
		enabled = false, -- Set to true if you want auto-save
		config = function()
			require("auto-save").setup({
				enabled = true,
				execution_message = {
					message = function()
						return ""
					end,
				},
				trigger_events = { "InsertLeave", "TextChanged" },
				condition = function(buf)
					local fn = vim.fn
					local utils = require("auto-save.utils.data")

					if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
						return true
					end
					return false
				end,
				debounce_delay = 1000,
			})
		end,
	},

	-- Build commands integration
	{
		"nvim-lua/plenary.nvim",
		config = function()
			-- Quick build command
			vim.api.nvim_create_user_command("Build", function()
				local ft = vim.bo.filetype

				if vim.fn.filereadable("build.gradle") == 1 or vim.fn.filereadable("build.gradle.kts") == 1 then
					vim.cmd("terminal ./gradlew build")
				elseif vim.fn.filereadable("pom.xml") == 1 then
					vim.cmd("terminal ./mvnw clean package")
				elseif vim.fn.filereadable("Cargo.toml") == 1 then
					vim.cmd("terminal cargo build")
				elseif vim.fn.filereadable("package.json") == 1 then
					vim.cmd("terminal npm run build")
				else
					vim.notify("No build file found", vim.log.levels.WARN)
				end
			end, {})

			-- Quick test command
			vim.api.nvim_create_user_command("Test", function()
				if vim.fn.filereadable("build.gradle") == 1 or vim.fn.filereadable("build.gradle.kts") == 1 then
					vim.cmd("terminal ./gradlew test")
				elseif vim.fn.filereadable("pom.xml") == 1 then
					vim.cmd("terminal ./mvnw test")
				elseif vim.fn.filereadable("Cargo.toml") == 1 then
					vim.cmd("terminal cargo test")
				elseif vim.fn.filereadable("package.json") == 1 then
					vim.cmd("terminal npm test")
				else
					vim.notify("No test command found", vim.log.levels.WARN)
				end
			end, {})

			-- Keymaps
			vim.keymap.set("n", "<leader>bb", ":Build<CR>", { desc = "[B]uild project" })
			vim.keymap.set("n", "<leader>bt", ":Test<CR>", { desc = "[B]uild [T]est" })
		end,
	},
}

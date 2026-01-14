-- lua/plugins/git-enhanced.lua
-- Enhanced Git workflow with blame, history, and better conflict resolution

return {
	-- Git blame and history
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next git change" })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Previous git change" })

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, { desc = "[H]unk [S]tage" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [R]eset" })
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[H]unk [S]tage" })
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "[H]unk [R]eset" })
				map("n", "<leader>hS", gs.stage_buffer, { desc = "[H]unk [S]tage buffer" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[H]unk [U]ndo stage" })
				map("n", "<leader>hR", gs.reset_buffer, { desc = "[H]unk [R]eset buffer" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "[H]unk [P]review" })
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { desc = "[H]unk [B]lame line" })
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[T]oggle [B]lame" })
				map("n", "<leader>hd", gs.diffthis, { desc = "[H]unk [D]iff" })
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { desc = "[H]unk [D]iff ~" })
				map("n", "<leader>td", gs.toggle_deleted, { desc = "[T]oggle [D]eleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git hunk text object" })
			end,
		},
	},

	-- Better commit history browser
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "[G]it [D]iff view" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "[G]it file [H]istory" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "[G]it repo [H]istory" },
		},
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				use_icons = true,
			})
		end,
	},

	-- Fugitive (already have this, but adding useful keymaps)
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			{ "<leader>gg", "<cmd>Git<CR>", desc = "[G]it status" },
			{ "<leader>gc", "<cmd>Git commit<CR>", desc = "[G]it [C]ommit" },
			{ "<leader>gp", "<cmd>Git push<CR>", desc = "[G]it [P]ush" },
			{ "<leader>gP", "<cmd>Git pull<CR>", desc = "[G]it [P]ull (capital)" },
			{ "<leader>gb", "<cmd>Git blame<CR>", desc = "[G]it [B]lame" },
			{ "<leader>gL", "<cmd>Git log<CR>", desc = "[G]it [L]og" },
		},
	},

	-- Conflict resolution helper
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPre",
		config = function()
			require("git-conflict").setup({
				default_mappings = true,
				default_commands = true,
				disable_diagnostics = false,
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
				},
			})

			-- Custom keymaps for conflict resolution
			vim.keymap.set("n", "<leader>co", "<cmd>GitConflictChooseOurs<CR>", { desc = "[C]onflict choose [O]urs" })
			vim.keymap.set(
				"n",
				"<leader>ct",
				"<cmd>GitConflictChooseTheirs<CR>",
				{ desc = "[C]onflict choose [T]heirs" }
			)
			vim.keymap.set("n", "<leader>cb", "<cmd>GitConflictChooseBoth<CR>", { desc = "[C]onflict choose [B]oth" })
			vim.keymap.set("n", "<leader>c0", "<cmd>GitConflictChooseNone<CR>", { desc = "[C]onflict choose none" })
			vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<CR>", { desc = "Previous conflict" })
			vim.keymap.set("n", "]x", "<cmd>GitConflictNextConflict<CR>", { desc = "Next conflict" })
			vim.keymap.set("n", "<leader>cl", "<cmd>GitConflictListQf<CR>", { desc = "[C]onflict [L]ist" })
		end,
	},
}

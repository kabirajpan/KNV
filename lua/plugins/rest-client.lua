-- lua/plugins/rest-client.lua
-- REST API testing directly from Neovim
-- Uses rest.nvim for .http file support

return {
	{
		"rest-nvim/rest.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		rocks = { "nvim-nio", "mimetypes", "xml2lua" },
		ft = { "http" },
		config = function()
			require("rest-nvim").setup({
				-- Result split options
				result_split_horizontal = false,
				result_split_in_place = false,
				skip_ssl_verification = false,
				encode_url = true,
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					show_url = true,
					show_http_info = true,
					show_headers = true,
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})

			-- ===============================
			-- Keymaps for .http files
			-- ===============================

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "http",
				callback = function()
					local opts = { buffer = true, silent = true }

					-- Run request under cursor
					vim.keymap.set("n", "<CR>", "<Plug>RestNvim", opts)
					vim.keymap.set(
						"n",
						"<leader>rr",
						"<Plug>RestNvim",
						vim.tbl_extend("force", opts, { desc = "[R]est [R]un" })
					)

					-- Preview request (dry run)
					vim.keymap.set(
						"n",
						"<leader>rp",
						"<Plug>RestNvimPreview",
						vim.tbl_extend("force", opts, { desc = "[R]est [P]review" })
					)

					-- Run last request
					vim.keymap.set(
						"n",
						"<leader>rl",
						"<Plug>RestNvimLast",
						vim.tbl_extend("force", opts, { desc = "[R]est [L]ast" })
					)
				end,
			})

			-- ===============================
			-- Commands
			-- ===============================

			vim.api.nvim_create_user_command("RestRun", function()
				vim.cmd("Rest run")
			end, { desc = "Run REST request under cursor" })

			vim.api.nvim_create_user_command("RestLast", function()
				vim.cmd("Rest run last")
			end, { desc = "Run last REST request" })

			vim.api.nvim_create_user_command("RestNew", function()
				local filename = vim.fn.input("Request file name: ", "api.http")
				if filename ~= "" then
					vim.cmd("edit " .. filename)
					-- Insert template
					local template = {
						"### Example GET Request",
						"GET https://api.example.com/users",
						"Content-Type: application/json",
						"",
						"###",
						"",
						"### Example POST Request",
						"POST https://api.example.com/users",
						"Content-Type: application/json",
						"",
						"{",
						'  "name": "John Doe",',
						'  "email": "john@example.com"',
						"}",
						"",
						"###",
					}
					vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
				end
			end, { desc = "Create new .http file" })

			-- ===============================
			-- Global keymaps
			-- ===============================

			vim.keymap.set("n", "<leader>rn", ":RestNew<CR>", { desc = "[R]est [N]ew file" })
		end,
	},

	-- Alternative: kulala.nvim (lighter alternative to rest.nvim)
	-- Uncomment this block and comment out rest.nvim above if you prefer
	--[[
  {
    "mistweaverco/kulala.nvim",
    ft = { "http" },
    config = function()
      require("kulala").setup({
        -- default_view = "body",
        -- default_env = "dev",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "http",
        callback = function()
          local opts = { buffer = true, silent = true }
          vim.keymap.set("n", "<CR>", require("kulala").run, opts)
          vim.keymap.set("n", "<leader>rr", require("kulala").run, vim.tbl_extend("force", opts, { desc = "Run request" }))
        end,
      })
    end,
  },
  ]]
}

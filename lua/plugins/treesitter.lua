-- lua/plugins/treesitter.lua
-- Optimized Treesitter - disabled unused features for better performance

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				-- Programming Languages
				"bash",
				"c",
				"cpp",
				"java",
				"python",
				"lua",
				"rust",
				"go",
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",
				"kotlin",

				-- Markup / Styles
				"html",
				"css",
				"scss",
				"json",
				"yaml",
				"toml",
				"markdown",
				"markdown_inline",

				-- DevOps / Configs
				"dockerfile",
				"gitignore",
				"make",
				"cmake",

				-- DB / Graph
				"sql",
				"graphql",

				-- Misc
				"vim",
				"regex",
				"query",
				"asm",
				"http", -- Added http for rest.nvim
			},

			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				-- Disable for very large files
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},

			indent = {
				enable = true,
				-- Disable for problematic languages
				disable = { "yaml", "python" },
			},

			-- OPTIMIZED: Only enable autotag for web files
			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
				filetypes = {
					"html",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"tsx",
					"jsx",
					"rescript",
					"xml",
					"astro",
				},
			},

			-- DISABLED: Incremental selection (uses <CR> which conflicts with other mappings)
			-- Uncomment if you actually use this feature
			--[[
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
      },
      ]]
		})
	end,
}

-- lua/plugins/project-manager.lua
-- Smart project management for multi-repo workflows
-- Auto-detects Android, Spring Boot, KMP projects

return {
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				detection_methods = { "pattern", "lsp" },
				patterns = {
					".git",
					"build.gradle",
					"build.gradle.kts",
					"settings.gradle",
					"settings.gradle.kts",
					"pom.xml",
					"package.json",
					"Cargo.toml",
				},
				show_hidden = false,
				silent_chdir = false,
				scope_chdir = "global",
			})

			-- Integrate with Telescope
			require("telescope").load_extension("projects")
		end,
	},

	-- Enhanced project navigation
	{
		"nvim-lua/plenary.nvim",
		config = function()
			-- Detect project type
			local function get_project_type()
				if vim.fn.filereadable("build.gradle") == 1 or vim.fn.filereadable("build.gradle.kts") == 1 then
					if
						vim.fn.isdirectory("app/src/main/java") == 1
						or vim.fn.isdirectory("app/src/main/kotlin") == 1
					then
						return "android"
					else
						return "gradle"
					end
				elseif vim.fn.filereadable("pom.xml") == 1 then
					local pom = vim.fn.readfile("pom.xml")
					for _, line in ipairs(pom) do
						if line:match("spring%-boot") then
							return "spring-boot"
						end
					end
					return "maven"
				elseif vim.fn.filereadable("package.json") == 1 then
					return "node"
				end
				return "unknown"
			end

			-- Show project info
			vim.api.nvim_create_user_command("ProjectInfo", function()
				local ptype = get_project_type()
				local cwd = vim.fn.getcwd()
				local project_name = vim.fn.fnamemodify(cwd, ":t")

				local info = {
					"Project: " .. project_name,
					"Type: " .. ptype,
					"Path: " .. cwd,
					"",
					"Available commands:",
				}

				if ptype == "android" then
					table.insert(info, "  :AndroidBuild, :AndroidInstall, :AndroidLogcat")
				elseif ptype == "spring-boot" then
					table.insert(info, "  :SpringRun, :SpringBuild, :SpringTest")
				elseif ptype == "gradle" or ptype == "maven" then
					table.insert(info, "  Use Spring/Android commands based on build file")
				end

				vim.notify(table.concat(info, "\n"), vim.log.levels.INFO)
			end, {})

			-- Quick project switching
			vim.keymap.set("n", "<leader>pp", "<cmd>Telescope projects<CR>", { desc = "[P]roject [P]icker" })
			vim.keymap.set("n", "<leader>pi", ":ProjectInfo<CR>", { desc = "[P]roject [I]nfo" })
		end,
	},
}

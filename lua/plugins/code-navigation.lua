-- lua/plugins/code-navigation.lua
-- Smart code navigation for Java/Kotlin/Spring projects
-- Jump between related files (Controller -> Service -> Repository -> Entity)

return {
	{
		"nvim-lua/plenary.nvim",
		config = function()
			local telescope_builtin = require("telescope.builtin")

			-- Find related files based on current file
			local function find_related_files()
				local current_file = vim.fn.expand("%:t:r") -- filename without extension
				local patterns = {}

				-- If in Controller, suggest Service/Repository
				if current_file:match("Controller$") then
					local base = current_file:gsub("Controller$", "")
					patterns = {
						base .. "Service",
						base .. "Repository",
						base .. "Entity",
						base,
					}
				-- If in Service, suggest Controller/Repository
				elseif current_file:match("Service$") then
					local base = current_file:gsub("Service$", "")
					patterns = {
						base .. "Controller",
						base .. "Repository",
						base .. "Entity",
						base,
					}
				-- If in Repository, suggest Service/Entity
				elseif current_file:match("Repository$") then
					local base = current_file:gsub("Repository$", "")
					patterns = {
						base .. "Service",
						base .. "Entity",
						base .. "Controller",
						base,
					}
				-- If in Entity/Model, suggest Repository/Service
				elseif current_file:match("Entity$") or current_file:match("Model$") then
					local base = current_file:gsub("Entity$", ""):gsub("Model$", "")
					patterns = {
						base .. "Repository",
						base .. "Service",
						base .. "Controller",
						base,
					}
				-- If in Activity (Android), suggest ViewModel/Fragment
				elseif current_file:match("Activity$") then
					local base = current_file:gsub("Activity$", "")
					patterns = {
						base .. "ViewModel",
						base .. "Fragment",
						base,
					}
				-- If in Fragment, suggest ViewModel/Activity
				elseif current_file:match("Fragment$") then
					local base = current_file:gsub("Fragment$", "")
					patterns = {
						base .. "ViewModel",
						base .. "Activity",
						base,
					}
				-- If in ViewModel, suggest Activity/Fragment
				elseif current_file:match("ViewModel$") then
					local base = current_file:gsub("ViewModel$", "")
					patterns = {
						base .. "Activity",
						base .. "Fragment",
						base,
					}
				end

				if #patterns > 0 then
					telescope_builtin.find_files({
						search_file = table.concat(patterns, "|"),
						prompt_title = "Related Files",
					})
				else
					vim.notify("No related files pattern found", vim.log.levels.INFO)
				end
			end

			-- Jump to test file or create it
			local function jump_to_test()
				local current_file = vim.fn.expand("%:p")
				local current_name = vim.fn.expand("%:t:r")

				local test_patterns = {
					current_name .. "Test",
					current_name .. "Tests",
					current_name .. "Spec",
				}

				-- Try to find existing test
				for _, pattern in ipairs(test_patterns) do
					local test_file = vim.fn.findfile(pattern .. ".*", "**")
					if test_file ~= "" then
						vim.cmd("edit " .. test_file)
						return
					end
				end

				-- Offer to create test file
				vim.ui.input({
					prompt = "Test file not found. Create " .. current_name .. "Test? (y/n): ",
				}, function(input)
					if input and input:lower() == "y" then
						local test_dir = vim.fn.expand("%:p:h"):gsub("/main/", "/test/")
						vim.fn.mkdir(test_dir, "p")
						local test_file = test_dir .. "/" .. current_name .. "Test.kt"
						vim.cmd("edit " .. test_file)

						-- Insert basic test template
						local ext = vim.fn.expand("%:e")
						if ext == "kt" or ext == "java" then
							local package = vim.fn.matchstr(vim.fn.getline(1), "package \\zs.*")
							local template = {
								"package " .. package,
								"",
								"import org.junit.jupiter.api.Test",
								"import org.junit.jupiter.api.Assertions.*",
								"",
								"class " .. current_name .. "Test {",
								"    ",
								"    @Test",
								"    fun `test something`() {",
								"        // TODO: Write test",
								"    }",
								"}",
							}
							vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
						end
					end
				end)
			end

			-- Commands
			vim.api.nvim_create_user_command("RelatedFiles", find_related_files, {})
			vim.api.nvim_create_user_command("JumpToTest", jump_to_test, {})

			-- Keymaps
			vim.keymap.set("n", "<leader>gf", find_related_files, { desc = "[G]o to related [F]iles" })
			vim.keymap.set("n", "<leader>gt", jump_to_test, { desc = "[G]o to [T]est" })

			-- Quick file type navigation
			vim.keymap.set("n", "<leader>fc", function()
				telescope_builtin.find_files({ search_file = "Controller" })
			end, { desc = "[F]ind [C]ontroller" })

			vim.keymap.set("n", "<leader>fs", function()
				telescope_builtin.find_files({ search_file = "Service" })
			end, { desc = "[F]ind [S]ervice" })

			vim.keymap.set("n", "<leader>fr", function()
				telescope_builtin.find_files({ search_file = "Repository" })
			end, { desc = "[F]ind [R]epository" })

			vim.keymap.set("n", "<leader>fe", function()
				telescope_builtin.find_files({ search_file = "Entity" })
			end, { desc = "[F]ind [E]ntity" })

			vim.keymap.set("n", "<leader>fv", function()
				telescope_builtin.find_files({ search_file = "ViewModel" })
			end, { desc = "[F]ind [V]iewModel" })

			vim.keymap.set("n", "<leader>fa", function()
				telescope_builtin.find_files({ search_file = "Activity" })
			end, { desc = "[F]ind [A]ctivity" })
		end,
	},
}

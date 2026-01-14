-- lua/plugins/spring-boot.lua
-- Spring Boot development helpers for Neovim
-- Maven & Gradle support, quick run/build/test commands

return {
	{
		"nvim-lua/plenary.nvim",
		config = function()
			-- Helper: Run command in terminal tab
			local function run_terminal(cmd, title)
				vim.cmd("tabnew")
				vim.cmd("terminal " .. cmd)
				if title then
					vim.cmd("file " .. title)
				end
				vim.cmd("startinsert")
			end

			-- Helper: Detect build tool (Maven or Gradle)
			local function get_build_tool()
				if vim.fn.filereadable("pom.xml") == 1 then
					return "mvn"
				elseif vim.fn.filereadable("build.gradle") == 1 or vim.fn.filereadable("build.gradle.kts") == 1 then
					return "gradle"
				else
					return nil
				end
			end

			-- ===============================
			-- Spring Boot Commands
			-- ===============================

			vim.api.nvim_create_user_command("SpringRun", function()
				local tool = get_build_tool()
				if not tool then
					vim.notify("No pom.xml or build.gradle found!", vim.log.levels.ERROR)
					return
				end

				if tool == "mvn" then
					run_terminal("./mvnw spring-boot:run", "Spring Boot (Maven)")
				else
					run_terminal("./gradlew bootRun", "Spring Boot (Gradle)")
				end
			end, { desc = "Run Spring Boot application" })

			vim.api.nvim_create_user_command("SpringBuild", function()
				local tool = get_build_tool()
				if not tool then
					vim.notify("No pom.xml or build.gradle found!", vim.log.levels.ERROR)
					return
				end

				if tool == "mvn" then
					run_terminal("./mvnw clean package", "Build (Maven)")
				else
					run_terminal("./gradlew build", "Build (Gradle)")
				end
			end, { desc = "Build Spring Boot project" })

			vim.api.nvim_create_user_command("SpringTest", function()
				local tool = get_build_tool()
				if not tool then
					vim.notify("No pom.xml or build.gradle found!", vim.log.levels.ERROR)
					return
				end

				if tool == "mvn" then
					run_terminal("./mvnw test", "Tests (Maven)")
				else
					run_terminal("./gradlew test", "Tests (Gradle)")
				end
			end, { desc = "Run Spring Boot tests" })

			vim.api.nvim_create_user_command("SpringClean", function()
				local tool = get_build_tool()
				if not tool then
					vim.notify("No pom.xml or build.gradle found!", vim.log.levels.ERROR)
					return
				end

				if tool == "mvn" then
					run_terminal("./mvnw clean", "Clean (Maven)")
				else
					run_terminal("./gradlew clean", "Clean (Gradle)")
				end
			end, { desc = "Clean build artifacts" })

			vim.api.nvim_create_user_command("SpringPackage", function()
				local tool = get_build_tool()
				if not tool then
					vim.notify("No pom.xml or build.gradle found!", vim.log.levels.ERROR)
					return
				end

				if tool == "mvn" then
					run_terminal("./mvnw clean package -DskipTests", "Package JAR (Maven)")
				else
					run_terminal("./gradlew bootJar", "Package JAR (Gradle)")
				end
			end, { desc = "Package Spring Boot JAR" })

			-- ===============================
			-- Quick File Navigation
			-- ===============================

			vim.api.nvim_create_user_command("SpringProperties", function()
				local paths = {
					"src/main/resources/application.properties",
					"src/main/resources/application.yml",
					"src/main/resources/application.yaml",
				}

				for _, path in ipairs(paths) do
					if vim.fn.filereadable(path) == 1 then
						vim.cmd("edit " .. path)
						return
					end
				end

				vim.notify("No application.properties/yml found!", vim.log.levels.WARN)
			end, { desc = "Open application properties" })

			vim.api.nvim_create_user_command("SpringController", function()
				vim.cmd("Telescope find_files search=Controller.java")
			end, { desc = "Find Spring Controllers" })

			vim.api.nvim_create_user_command("SpringService", function()
				vim.cmd("Telescope find_files search=Service.java")
			end, { desc = "Find Spring Services" })

			vim.api.nvim_create_user_command("SpringEntity", function()
				vim.cmd("Telescope find_files search=Entity.java")
			end, { desc = "Find Spring Entities" })

			vim.api.nvim_create_user_command("SpringRepository", function()
				vim.cmd("Telescope find_files search=Repository.java")
			end, { desc = "Find Spring Repositories" })

			-- ===============================
			-- Keymaps (leader-based)
			-- ===============================

			vim.keymap.set("n", "<leader>sr", ":SpringRun<CR>", { desc = "[S]pring [R]un" })
			vim.keymap.set("n", "<leader>sb", ":SpringBuild<CR>", { desc = "[S]pring [B]uild" })
			vim.keymap.set("n", "<leader>st", ":SpringTest<CR>", { desc = "[S]pring [T]est" })
			vim.keymap.set("n", "<leader>sp", ":SpringProperties<CR>", { desc = "[S]pring [P]roperties" })
			vim.keymap.set("n", "<leader>sc", ":SpringController<CR>", { desc = "[S]pring [C]ontroller" })
		end,
	},
}

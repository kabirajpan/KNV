-- lua/plugins/android.lua
-- Enhanced Android + KMP workflow for physical device development
-- No emulator, terminal-based, optimized for real device testing

return {
	-- Kotlin syntax
	{
		"udalov/kotlin-vim",
		ft = { "kotlin" },
	},

	-- Gradle support
	{
		"tfnico/vim-gradle",
		ft = { "gradle", "groovy", "kotlin" },
	},

	-- XML support
	{
		"othree/xml.vim",
		ft = { "xml" },
	},

	-- ===============================
	-- Enhanced Android Commands
	-- ===============================
	{
		"nvim-lua/plenary.nvim",
		config = function()
			local Job = require("plenary.job")

			-- Helper: Run command in floating terminal
			local function run_terminal(cmd, title)
				vim.cmd("tabnew")
				vim.cmd("terminal " .. cmd)
				if title then
					vim.cmd("file " .. title)
				end
				vim.cmd("startinsert")
			end

			-- Helper: Get connected ADB devices
			local function get_devices()
				local devices = {}
				local job = Job:new({
					command = "adb",
					args = { "devices" },
				})
				job:sync()

				for _, line in ipairs(job:result()) do
					local device = line:match("^(%S+)%s+device$")
					if device then
						table.insert(devices, device)
					end
				end
				return devices
			end

			-- Helper: Select device if multiple
			local function with_device(callback)
				local devices = get_devices()

				if #devices == 0 then
					vim.notify("No devices connected!", vim.log.levels.ERROR)
					return
				end

				if #devices == 1 then
					callback(devices[1])
					return
				end

				vim.ui.select(devices, {
					prompt = "Select device:",
				}, function(choice)
					if choice then
						callback(choice)
					end
				end)
			end

			-- Helper: Get gradle/mvn wrapper command (cross-platform)
			local function get_wrapper_cmd(base_cmd)
				if vim.fn.has("win32") == 1 then
					return base_cmd .. ".bat"
				end
				return "./" .. base_cmd
			end

			-- ===============================
			-- Gradle Commands
			-- ===============================

			vim.api.nvim_create_user_command("AndroidBuild", function()
				local cmd = get_wrapper_cmd("gradlew") .. " assembleDebug"
				run_terminal(cmd, "Build Debug APK")
			end, { desc = "Build debug APK" })

			vim.api.nvim_create_user_command("AndroidBuildRelease", function()
				local cmd = get_wrapper_cmd("gradlew") .. " assembleRelease"
				run_terminal(cmd, "Build Release APK")
			end, { desc = "Build release APK" })

			vim.api.nvim_create_user_command("AndroidInstall", function()
				with_device(function(device)
					local cmd = get_wrapper_cmd("gradlew") .. " installDebug -Pandroid.injected.device=" .. device
					run_terminal(cmd, "Install to " .. device)
				end)
			end, { desc = "Install debug APK to device" })

			vim.api.nvim_create_user_command("AndroidUninstall", function(opts)
				local package = opts.args
				if package == "" then
					vim.notify("Usage: :AndroidUninstall <package.name>", vim.log.levels.ERROR)
					return
				end
				with_device(function(device)
					run_terminal("adb -s " .. device .. " uninstall " .. package, "Uninstall " .. package)
				end)
			end, { nargs = 1, desc = "Uninstall app from device" })

			vim.api.nvim_create_user_command("AndroidClean", function()
				run_terminal("./gradlew clean", "Clean Build")
			end, { desc = "Clean build artifacts" })

			vim.api.nvim_create_user_command("AndroidTest", function()
				run_terminal("./gradlew test", "Run Tests")
			end, { desc = "Run unit tests" })

			vim.api.nvim_create_user_command("AndroidLint", function()
				run_terminal("./gradlew lint", "Lint Check")
			end, { desc = "Run lint checks" })

			-- ===============================
			-- ADB Commands
			-- ===============================

			vim.api.nvim_create_user_command("AndroidDevices", function()
				local devices = get_devices()
				if #devices == 0 then
					vim.notify("No devices connected", vim.log.levels.WARN)
				else
					vim.notify("Connected devices:\n" .. table.concat(devices, "\n"), vim.log.levels.INFO)
				end
			end, { desc = "List connected devices" })

			vim.api.nvim_create_user_command("AndroidLogcat", function(opts)
				local filter = opts.args ~= "" and " | grep -i '" .. opts.args .. "'" or ""
				with_device(function(device)
					run_terminal(
						"adb -s " .. device .. " logcat -c && adb -s " .. device .. " logcat" .. filter,
						"Logcat " .. device
					)
				end)
			end, { nargs = "?", desc = "Show logcat (optional: filter)" })

			vim.api.nvim_create_user_command("AndroidLogcatClear", function()
				with_device(function(device)
					vim.fn.system("adb -s " .. device .. " logcat -c")
					vim.notify("Logcat cleared on " .. device, vim.log.levels.INFO)
				end)
			end, { desc = "Clear logcat buffer" })

			vim.api.nvim_create_user_command("AndroidShell", function()
				with_device(function(device)
					run_terminal("adb -s " .. device .. " shell", "ADB Shell " .. device)
				end)
			end, { desc = "Open ADB shell" })

			vim.api.nvim_create_user_command("AndroidScreenshot", function()
				with_device(function(device)
					local filename = os.date("screenshot_%Y%m%d_%H%M%S.png")
					vim.fn.system("adb -s " .. device .. " shell screencap -p /sdcard/" .. filename)
					vim.fn.system("adb -s " .. device .. " pull /sdcard/" .. filename .. " .")
					vim.fn.system("adb -s " .. device .. " shell rm /sdcard/" .. filename)
					vim.notify("Screenshot saved: " .. filename, vim.log.levels.INFO)
				end)
			end, { desc = "Take device screenshot" })

			-- ===============================
			-- KMP Commands
			-- ===============================

			vim.api.nvim_create_user_command("KmpBuild", function()
				run_terminal("./gradlew :shared:build", "Build KMP Shared")
			end, { desc = "Build KMP shared module" })

			vim.api.nvim_create_user_command("KmpTest", function()
				run_terminal("./gradlew :shared:allTests", "KMP Tests")
			end, { desc = "Run KMP tests" })

			vim.api.nvim_create_user_command("KmpAndroid", function()
				run_terminal("./gradlew :shared:assembleDebug", "KMP Android Build")
			end, { desc = "Build KMP Android target" })

			-- ===============================
			-- Keymaps (optional, leader-based)
			-- ===============================

			vim.keymap.set("n", "<leader>ab", ":AndroidBuild<CR>", { desc = "[A]ndroid [B]uild" })
			vim.keymap.set("n", "<leader>ai", ":AndroidInstall<CR>", { desc = "[A]ndroid [I]nstall" })
			vim.keymap.set("n", "<leader>al", ":AndroidLogcat<CR>", { desc = "[A]ndroid [L]ogcat" })
			vim.keymap.set("n", "<leader>ac", ":AndroidClean<CR>", { desc = "[A]ndroid [C]lean" })
			vim.keymap.set("n", "<leader>ad", ":AndroidDevices<CR>", { desc = "[A]ndroid [D]evices" })
		end,
	},
}

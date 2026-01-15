return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- AI highlights
		vim.cmd([[
      highlight LualineCopilot guifg=#FFA500
      highlight LualineCodeium guifg=#00BFFF
      highlight LualineNone guifg=#888888
    ]])

		-- AI status function
		local function ai_status()
			local copilot_active = false
			local codeium_active = false

			-- Check Copilot status
			local ok, copilot = pcall(require, "copilot.api")
			if ok and copilot.status and copilot.status.data then
				local status = copilot.status.data.status
				if status == "Normal" or status == "InProgress" then
					copilot_active = true
				end
			end

			-- Check Codeium status using VimScript function
			local codeium_ok, codeium_enabled = pcall(vim.fn["codeium#Enabled"])
			if codeium_ok and codeium_enabled == 1 then
				codeium_active = true
			end

			if copilot_active then
				return "%#LualineCopilot#󰚀 Copilot"
			elseif codeium_active then
				return "%#LualineCodeium#󰘦 Codeium"
			else
				return "%#LualineNone#󰚫 None"
			end
		end

		-- Relative path function with file icon
		local function relative_path()
			local filepath = vim.fn.expand("%:~:.") -- relative to current dir
			if filepath == "" then
				filepath = "[No Name]"
			end
			-- Try to get file icon via devicons
			local ok, devicons = pcall(require, "nvim-web-devicons")
			if ok then
				local filename = vim.fn.expand("%:t")
				local ext = vim.fn.expand("%:e")
				local icon, icon_color = devicons.get_icon(filename, ext, { default = true })
				if icon then
					return icon .. " " .. filepath
				end
			end
			return filepath
		end

		-- Git status with icons (cross-platform)
		local function git_branch()
			local cmd = vim.fn.has("win32") == 1 and 
				"git branch --show-current 2>NUL" or 
				"git branch --show-current 2>/dev/null"
			local branch = vim.fn.system(cmd)
			if vim.v.shell_error == 0 then
				return " " .. branch:gsub("\n", "")
			end
			return ""
		end

		require("lualine").setup({
			options = {
				theme = "gruvbox",
				section_separators = { left = "", right = "" },
				component_separators = { left = "|", right = "|" },
				globalstatus = true,
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { relative_path },
				lualine_x = { 
					"diagnostics",
					ai_status,
					"encoding",
					"fileformat",
					"filetype"
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}

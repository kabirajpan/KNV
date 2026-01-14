-- lua/plugins/lsp.lua
-- Optimized LSP configuration with performance tuning
-- Merged Kotlin LSP config from kotlin-lsp.lua (DELETE that file after using this)

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"williamboman/mason.nvim",
			build = ":MasonUpdate",
			config = function()
				require("mason").setup()
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = function() end,
		},
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local on_attach = function(client, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
			nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			nmap("K", vim.lsp.buf.hover, "Hover Documentation")
			nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

			if client.name == "dartls" then
				nmap("<leader>fd", ":FlutterDevices<CR>", "[F]lutter [D]evices")
				nmap("<leader>fe", ":FlutterEmulators<CR>", "[F]lutter [E]mulators")
				nmap("<leader>fr", ":FlutterRun<CR>", "[F]lutter [R]un")
				nmap("<leader>fq", ":FlutterQuit<CR>", "[F]lutter [Q]uit")
				nmap("<leader>fh", ":FlutterHotReload<CR>", "[F]lutter [H]ot Reload")
				nmap("<leader>fR", ":FlutterHotRestart<CR>", "[F]lutter Hot [R]estart")
			end

			vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local mason_lspconfig = require("mason-lspconfig")

		-- Performance flags for all servers
		local default_flags = {
			debounce_text_changes = 150,
		}

		local servers = {
			lua_ls = {
				flags = default_flags,
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
						diagnostics = { globals = { "vim" } },
					},
				},
			},

			ts_ls = {
				flags = default_flags,
				settings = {
					completions = { completeFunctionCalls = true },
				},
			},

			html = {
				flags = default_flags,
				filetypes = { "html", "twig", "hbs", "astro" },
			},

			cssls = {
				flags = default_flags,
				filetypes = { "css", "scss", "less" },
			},

			emmet_ls = {
				flags = default_flags,
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
					"astro",
				},
			},

			tailwindcss = {
				flags = default_flags,
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"svelte",
					"astro",
				},
			},

			unocss = {
				flags = default_flags,
				filetypes = {
					"html",
					"javascriptreact",
					"typescriptreact",
					"vue",
					"svelte",
					"astro",
				},
			},

			astro = {
				flags = default_flags,
				filetypes = { "astro" },
			},

			pyright = {
				flags = default_flags,
				settings = {
					python = { analysis = { typeCheckingMode = "basic" } },
				},
			},

			dartls = {
				flags = default_flags,
				settings = {
					dart = {
						updateImportsOnRename = true,
						completeFunctionCalls = true,
						showTodos = true,
						lineLength = 120,
						enableSdkFormatter = true,
					},
				},
			},

			-- =========================
			-- JVM / Mobile / Backend
			-- =========================

			jdtls = {
				flags = default_flags,
				settings = {
					java = {
						signatureHelp = { enabled = true },
						contentProvider = { preferred = "fernflower" },
					},
				},
			},

			-- Kotlin (merged from kotlin-lsp.lua with performance tuning)
			kotlin_language_server = {
				cmd = { "kotlin-language-server" },
				filetypes = { "kotlin" },
				root_dir = require("lspconfig").util.root_pattern(
					"settings.gradle",
					"settings.gradle.kts",
					"build.gradle",
					"build.gradle.kts",
					".git"
				),
				single_file_support = true,
				flags = {
					debounce_text_changes = 300, -- Higher for Kotlin (heavy files)
				},
			},

			androidls = {
				flags = default_flags,
				filetypes = { "xml" },
			},

			spring_boot_ls = {
				flags = default_flags,
				cmd = { "spring-boot-language-server" },
				filetypes = { "java", "yaml", "properties" },
			},

			sourcekit = {
				flags = default_flags,
				filetypes = { "swift", "objective-c", "objective-cpp" },
			},

			clangd = {
				flags = default_flags,
			},

			rust_analyzer = {
				flags = default_flags,
			},

			gopls = {
				flags = default_flags,
			},
		}

		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"eslint",
				"emmet_ls",
				"astro",
				"pyright",
				"lua_ls",
				"clangd",
				"jdtls",
				"rust_analyzer",
				"dartls",
				"sqls",
				"jsonls",
				"yamlls",
				"marksman",
				"bashls",
				"dockerls",
				"gopls",
				"lemminx",
				"taplo",
				"kotlin_language_server",
			},
			automatic_installation = true,
		})

		for server_name, config in pairs(servers) do
			local server_config = vim.tbl_deep_extend("force", {
				capabilities = capabilities,
				on_attach = on_attach,
			}, config)

			if vim.lsp.config then
				vim.lsp.config[server_name] = server_config
			else
				require("lspconfig")[server_name].setup(server_config)
			end
		end

		if vim.lsp.enable then
			for server_name, _ in pairs(servers) do
				vim.lsp.enable(server_name)
			end
		end

		local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		for type, icon in pairs(signs) do
			vim.fn.sign_define("DiagnosticSign" .. type, { text = icon })
		end

		vim.diagnostic.config({
			virtual_text = { prefix = "●" },
			update_in_insert = false,
			float = { source = "always" },
			severity_sort = true,
		})
	end,
}

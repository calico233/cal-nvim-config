return {
	"mfussenegger/nvim-jdtls",
	ft = "java", -- 只在打开 Java 文件时加载
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"saghen/blink.cmp",
	},
	config = function()
		-- 1. 获取 blink.cmp 的能力声明
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- 2. 构建 jdtls 配置表
		local config = {
			cmd = { vim.fn.exepath("jdtls") }, -- 使用 Mason 安装的 jdtls
			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
			capabilities = capabilities,
			settings = {
				java = {
					-- 可以根据需要调整配置，例如：
					signatureHelp = { enabled = true },
					-- contentProvider = { preferred = "fernflower" },
				},
			},
			init_options = {
				bundles = {},
			},
		}

		-- 3. 启动或附加到当前缓冲区
		require("jdtls").start_or_attach(config)
	end,
}

return {
	"neovim/nvim-lspconfig",
	ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, -- 只在相关文件类型加载
	dependencies = {
		"williamboman/mason.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		-- 1. 获取 blink.cmp 的能力声明
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- 2. 配置 vtsls
		vim.lsp.config("vtsls", {
			capabilities = capabilities, -- 你的 blink.cmp 能力声明
			filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
			root_markers = { "package.json", "tsconfig.json", ".git" },
			settings = {},
		})

		-- 2. 启用服务器
		vim.lsp.enable("vtsls")
	end,
}

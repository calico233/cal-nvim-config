return {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig",
	},

	config = function()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- lua
				"clangd", -- c/cpp
				"jdtls", -- java
				"vtsls", -- js/ts
			},
			automatic_installation = true,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities({
			textDocument = {
				completion = {
					completionItem = {
						snippetSupport = false, -- 关闭片段提示
					},
				},
			},
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = { checkThirdParty = false },
					-- diagnostics.globals 通常不再需要，因为类型库会提供 vim 的定义
				},
			},
		})

		vim.lsp.config("clangd", {
			capabilities = capabilities,
			cmd = { "clangd", "--query-driver=/usr/bin/g++", "--header-insertion=never" },
		})

		vim.diagnostic.config({
			-- 开启行尾的虚空文本显示
			virtual_text = {
				spacing = 1, -- 文字和代码之间的间距
				prefix = "●", -- 前缀图标（可以用 "E:"、"■" 或者留空 ""）
				source = "if_many", -- 多个 LSP 报错时显示来源（如 clangd）
			},
			-- 建议顺手开启的其他诊断选项
			signs = true, -- 左侧行号旁显示提示图标
			underline = true, -- 保留底部的波浪线
			update_in_insert = false, -- 插入模式下不实时更新（防止打字时报错闪烁卡顿）
			severity_sort = true, -- 按错误严重程度排序
		})

		vim.lsp.enable("lua_ls")
		vim.lsp.enable("clangd")
	end,
}

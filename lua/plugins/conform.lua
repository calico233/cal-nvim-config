return {
	"stevearc/conform.nvim",
	config = function()
		local opts = {
			formatters_by_ft = {
				cc = { "clang-format" },
				hpp = { "clang-format" },
				h = { "clang-format" },
				cpp = { "clang-format" },
				lua = { "stylua" },
				java = { "google-java-format" },
				-- python = { "isort", "black" },
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
			formatters = {
				clang_format = {
					-- 添加 --style=file 参数，指示 clang-format 自动查找 .clang-format 文件
					prepend_args = { "--style=file" },
				},

				["google-java-format"] = {
					prepend_args = { "--aosp" }, -- 可选，用于 4 空格缩进
				},
			},
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				if vim.fn.executable("google-java-format") == 0 then
					vim.notify("请先安装 google-java-format: yay -S google-java-format", vim.log.levels.WARN)
				end
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "lua",
			callback = function()
				if vim.fn.executable("stylua") == 0 then
					vim.notify("请先安装 stylua", vim.log.levels.WARN)
				end
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "cpp", "c", "hpp", "h", "cc" },
			callback = function()
				if vim.fn.executable("clang-format") == 0 then
					vim.notify("请先安装 clang-format", vim.log.levels.WARN)
				end
			end,
		})

		require("conform").setup(opts)
	end,
}

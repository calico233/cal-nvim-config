return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	-- dependencies = { 'rafamadriz/friendly-snippets' },

	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config

	opts = {
		-- enabled是函数，不能是bool值
		enabled = function()
			return true
		end,

		-- ... 其他配置 ...
		cmdline = {
			keymap = {
				preset = "none",

				-- Tab: 弹出菜单并向后选择（不插入文本）
				["<Tab>"] = { "show", "select_next", "fallback" },
				-- Shift+Tab: 弹出菜单并向前选择
				["<S-Tab>"] = { "show", "select_prev", "fallback" },

				-- 上下键控制菜单移动
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },

				-- Enter: 第一次相当于 <C-y>（select_and_accept），
				-- 菜单关闭后再按 Enter 落到 fallback 执行命令
				["<CR>"] = { "select_and_accept", "fallback" },

				["<C-e>"] = { "cancel", "fallback" },
			},
			completion = {
				-- 选择时只高亮预览，不自动插入文本
				list = { selection = { preselect = false, auto_insert = false } },
				-- 可选：用 ghost text 显示预览
				ghost_text = { enabled = true },
				menu = { auto_show = false },
			},
		},

		keymap = {
			preset = "none",

			-- Tab: 弹出菜单并向后选择（不插入文本）
			["<Tab>"] = { "select_next", "fallback" },
			-- Shift+Tab: 弹出菜单并向前选择
			["<S-Tab>"] = { "select_prev", "fallback" },

			-- 上下键控制菜单移动
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			-- Enter: 第一次相当于 <C-y>（select_and_accept），
			-- 菜单关闭后再按 Enter 落到 fallback 执行命令
			["<CR>"] = { "select_and_accept", "fallback" },
			["<C-e>"] = { "cancel", "fallback" },
		},

		-- VS Code 风格：Tab 接受候选或跳到下一个 snippet 占位符
		-- keymap = {
		-- 	-- preset = "super-tab", -- tab接受当前候选
		-- },

		completion = {
			trigger = {
				show_on_keyword = true, -- 输入字母、数字、_ 等标识符时自动弹菜单。
				show_on_trigger_character = true, -- 输入 LSP 语言服务器定义的触发字符时弹出，例如 .、::、成员访问等。
				show_on_backspace = false, -- 退格回到一个单词中时重新请求补全；VS Code 的“边改边刷新”体验会更接近。
				show_in_snippet = false, -- 在 snippet 占位符里不弹普通补全，优先让 Tab 在占位符间跳转，避免按键冲突。
			},

			list = {
				selection = {
					preselect = true, -- 菜单出现时高亮第一项，[Enter]/Tab 可立即接受。
					auto_insert = false, -- 上下移动候选时不直接修改文本，只显示预览；比自动替换文本更接近 VS Code。
				},
			},

			menu = {
				auto_show = true, -- 无需手动触发，候选自动显示。
			},

			documentation = {
				-- 候选停留 300ms 后显示文档说明；太快可改为 500，觉得碍眼可设为 false。
				auto_show = true,
				-- auto_show_delay_ms = 300,
			},

			ghost_text = {
				-- enabled = true, -- 在当前行以灰字预览选中的普通补全。它不是 Copilot 一类 AI 行级建议。
				enabled = false,
			},
		},

		sources = {
			-- 优先使用 LSP 语义补全，其次是路径、代码片段、当前 buffer 文本。buffer 默认只会在 LSP 没结果或不可用时起主要作用。
			-- default = { "lsp", "path", "snippets", "buffer" },
			default = { "lsp", "path", "buffer" },
		},

		signature = {
			enabled = true, -- 输入 (、, 时显示参数提示；这是实验性功能，不喜欢可关闭。
		},

		fuzzy = {
			-- implementation = "prefer_rust_with_warning", -- 优先使用 Rust 模糊匹配器，缺失时退回 Lua；保留你现在的设置即可。
		},

		-- ensure_installed = { "lua_ls", "clangd" },
		-- automatic_install = true,
	},
	enabled = true,
}

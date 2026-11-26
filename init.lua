require("core.basic") -- 加载 lua/core/basic.lua

require("core.keymaps") -- 加载 lua/core/keymaps.lua

require("core.lazy")

vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#FFC0CB" })
-- 设置可视模式选中文本的高亮：深蓝色背景 + 白色文字
vim.api.nvim_set_hl(0, "Visual", {
	bg = "#264F78", -- 或者换成 "#2A5A7A"
	fg = "NONE", -- 关键！不覆盖前景色，保持语法高亮
	blend = 0, -- 透明度（0 为完全不透明，100 为完全透明）
})

-- 1. 定义你的高亮组
vim.api.nvim_set_hl(0, "MyCodeRunnerBg", { bg = "#2E3440", fg = "#DCD7BA" })
-- vim.api.nvim_set_hl(0, "MyCodeRunnerBorder", { fg = "#88C0D0", bg = "#2E3440" })


-- vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:block-Cursor,r-cr-o:block-Cursor"
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:block-Cursor"
-- guicursor 的格式是 模式列表:光标形状，不同模式用逗号 , 隔开：
-- n-v-c-sm:block：普通模式(n)、可视模式(v)、命令行模式(c)、显示匹配括号(sm) 使用方块。
-- i-ci-ve:ver25：插入模式(i)、自动补全插入模式(ci)、可视独占模式(ve) 使用 25%宽度的竖线。
-- r-cr-o:block：替换模式(r)、命令行替换(cr)、操作符待定(o) 使用方块。

vim.o.guifont = "CaskaydiaCove Nerd Font:h13:b"

-- vim.o.guifont = "ComicShannsMono Nerd Font:h14:b"

-- 只在 Neovide 里生效
if vim.g.neovide then
	-- 打开默认全屏
	-- vim.g.neovide_fullscreen = true
	-- 字体
	-- vim.o.guifont = "CaskaydiaCove Nerd Font:h14"
	-- 光标动画
	vim.g.neovide_cursor_animation_length = 0.1
	vim.g.neovide_cursor_trail_size = 1.0
	vim.g.neovide_cursor_short_animation_length = 0.02
	-- 窗口透明度
	vim.g.neovide_opacity = 0.85
	-- vim.g.neovide_opacity = 1

	-- 缩放（用 Ctrl+= / Ctrl+- 调整）
	vim.g.neovide_scale_factor = 1.2

	vim.keymap.set("n", "<C-=>", function()
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
	end, { desc = "放大" })

	vim.keymap.set("n", "<C-->", function()
		vim.g.neovide_scale_factor = math.max(0.5, vim.g.neovide_scale_factor - 0.1)
	end, { desc = "缩小" })
else
	-- 背景透明
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

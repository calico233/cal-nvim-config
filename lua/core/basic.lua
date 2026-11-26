-- 文件管理
vim.opt.backup = false -- 是否生成备份文件
vim.opt.swapfile = true -- 是否生成swap文件
vim.opt.writebackup = false -- 覆盖文件前是否备份
vim.opt.undofile = true -- 持久化撤销历史，关闭文件后仍然可以撤销
vim.opt.fileencoding = "utf-8" -- 写入文件时的编码

-- 缩进与编辑
vim.opt.expandtab = true -- 将tab转换为空格
vim.opt.tabstop = 4 -- 一个tab显示4个空格
vim.opt.shiftwidth = 0 -- 开头处vim为我们自动添加的空格数量
-- vim.opt.softtabstop = 4 -- 编辑时按tab键插入的空格数
vim.opt.smartindent = true -- 新行自动智能缩进
vim.opt.autoindent = true -- 新行沿用上一行缩
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove("c")
		vim.opt_local.formatoptions:remove("r")
		vim.opt_local.formatoptions:remove("o")
	end,
})

-- 界面显示
vim.opt.number = true -- 显示行号
vim.opt.relativenumber = true -- 显示相对行号
vim.opt.numberwidth = 4 -- 行号列宽度
vim.opt.cursorline = true -- 高亮当前行
-- vim.opt.signcolumn = "yes" -- 标志列显示(git状态，诊断信息)
vim.opt.showmode = false -- 命令行是否显示模式(INSERT等)
-- vim.opt.showtabline = 1 -- 标签页栏显示方式
-- vim.opt.cmdheight = 1 -- 命令行区域高度，自动的就行
vim.opt.wrap = false -- 长行是否折行显示
vim.opt.list = false -- 显示不可见字符, 比如tab显示为>
vim.opt.conceallevel = 0 -- Markdown等语法隐藏级别,0为不隐藏, 也就是说**abc** 不会隐藏掉左右的**
vim.opt.termguicolors = true -- 启用真彩色
-- vim.opt.background = "dark" -- 背景纯黑色

vim.opt.wrap = false -- 软换行
vim.opt.linebreak = false -- 智能换行，比如说一个单词不会被软换行拆成两部分

-- 滚动与窗口
-- 最右边为默认值
-- scrolloff	光标距离上下边缘保留的最小行数	8
-- sidescrolloff	光标距离左右边缘保留的最小列数	8
-- splitbelow	水平分割在当前窗口下方打开	true
-- splitright	垂直分割在当前窗口右侧打开	true

-- 交互与性能
vim.opt.mouse = "a" -- 启用鼠标支持, "a"表示所有模式
vim.opt.clipboard = "unnamedplus" -- 与系统剪切板同步

-- vim.opt.timeoutlen = 300 -- 等待映射序列输入的时间，单位ms
-- vim.opt.updatetime = 300 -- 触发CursorHold事件的时间
-- completeopt	补全菜单行为	{ "menuone", "noselect" }
-- pumheight	补全弹出菜单最大高度	10
-- confirm	关闭未保存缓冲区前确认	true
-- hidden	切换缓冲区时保留未保存的修改	true
-- wildmenu	命令行补全时显示候选菜单	true

vim.api.nvim_set_hl(0, "Cursor", { fg = "#FFC0CB", bg = "#FFC0CB" }) -- 普通模式：粉色
vim.api.nvim_set_hl(0, "iCursor", { fg = "#FFC0CB", bg = "#FFC0CB" }) -- 插入模式：粉色
vim.api.nvim_set_hl(0, "vCursor", { fg = "#FFC0CB", bg = "#FFC0CB" }) -- 可视模式：粉色
vim.opt.guicursor = "n-v-c:block-Cursor,i:block-iCursor,v:block-vCursor"



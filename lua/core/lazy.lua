-- Bootstrap lazy.nvim
-- 用来安装和初始化lazy.nvim的文件
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- 存储lazy的安装位置 .. 拼接字符串, lazypath = /home/cal/.local/share/nvim/lazy/lazy.nvim 

-- 判断lazypath是否存在，如果存在就说明安装过了

if not vim.uv.fs_stat(lazypath) then
	-- 执行git clone的安装
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath
	}) -- 调用系统命令
end

-- 下载之后又要引入所克隆的代码, rtp = run time path, 在这个搜索路径当中的文件可以被neovim所引用和识别
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" } -- 让lazy读取plugins文件夹当中的插件
	}
})


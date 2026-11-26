-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 快捷键用 vim.keymap.set(模式, 按键, 动作, 选项) 定义
-- noremap: 禁止递归映射
-- silent: 不显示命令输出[reference:44], 设置false表示显示

-- 代码	模式
-- n	普通模式
-- i	插入模式
-- v	可视模式
-- x	可视块模式
-- t	终端模式
-- c	命令行模式

vim.g.mapleader = " "

-- local opts = { noremap = true, silent = false }

vim.keymap.set({ "n", "i", "v", "c" }, "<C-z>", "<Nop>", { desc = "禁用挂起" })

----------------------------------------------------------------插入模式----------------------------------------------------------------

vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "删除上一个单词" }) -- Ctrl + backspace删除前一个单词

-- vim.keymap.set("i", "<C-h>", "<C-w>", { desc = "删除上一个单词" }) -- 为了兼容 xfce terminal, actually 我现在也不需要了

vim.keymap.set("i", "<C-Del>", '<C-o>"_dw', { desc = "删除下一个单词" }) -- Ctrl + delete 删除后一个单词

vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "撤销" }) -- Ctrl + z 撤销

vim.keymap.set("i", "<C-r>", "<C-o><C-r>", { desc = "撤回撤销" }) -- Ctrl + r 撤回撤销

vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "下移当前行" })

vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "上移当前行" })

vim.keymap.set("i", "<S-Left>", "<Left><C-o>v", { desc = "向左选择" })

vim.keymap.set("i", "<S-Up>", "<C-o>v<Up>", { desc = "向上选择" })

vim.keymap.set("i", "<S-Right>", "<C-o>v", { desc = "向右选择" })

vim.keymap.set("i", "<S-Down>", "<C-o>v<Down>", { desc = "向下选择" })

vim.keymap.set("i", "<S-End>", "<C-o>v$<Left>", { desc = "选中到结尾" })

vim.keymap.set("i", "<S-Home>", "<C-o>v^", { desc = "选中到开头非空字符" })

vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "粘贴" })

vim.keymap.set("i", "<C-x>", "<C-o>dd", { desc = "剪切一行" })

vim.keymap.set("i", "<C-c>", "<C-o>yy", { desc = "复制当前行" })

vim.keymap.set("i", "<C-l>", "<Home><C-o>v<End>", { desc = "选中当前行" })

vim.keymap.set("i", "<C-/>", "<C-o>gc", { desc = "注释当前行", remap = true }) -- gcc，是 Comment.nvim 插件提供的一个映射

vim.keymap.set("i", "<C-s>", "<Cmd>w<CR>", { desc = "保存" })

vim.keymap.set("i", "<C-Down>", "<C-o>m`<C-o>4j<C-o>m`", { desc = "向下移动4行" })

vim.keymap.set("i", "<C-Up>", "<C-o>m`<C-o>4k<C-o>m`", { desc = "一次向上移动4行" })

vim.keymap.set("i", "<C-S-Up>", "<C-o>m`<C-o>v4k", { desc = "向上选中4行" }) -- Ctrl + Shift + Up, 本质向上选中五行

vim.keymap.set("i", "<C-S-Down>", "<C-o>m`<C-o>v4j", { desc = "向下选中4行" })

vim.keymap.set("i", "<C-S-Left>", "<Left><C-o>vb", { desc = "向左选中一个单词" })

vim.keymap.set("i", "<C-S-Right>", "<C-o>ve", { desc = "向右选中一个单词" })

vim.keymap.set("i", "<C-PageDown>", "<Cmd>BufferLineCycleNext<CR>", { desc = "下一个 buffer" })

vim.keymap.set("i", "<C-PageUp>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "上一个 buffer" })

vim.keymap.set("i", "<Home>", "<C-o>^", { desc = "回到开头非空处" })

vim.keymap.set("i", "<C-d>", "<C-o>viw", { desc = "选中当前的单词" })

vim.keymap.set("i", "<C-t>", "<Cmd>FzfLua lsp_definitions<CR>", { desc = "跳转到定义" })

vim.keymap.set("i", "<LeftMouse>", "<C-o>m`<LeftMouse><C-o>m`", { desc = "打个标记再跳转" })

vim.keymap.set("i", "<M-S-Down>", function()
	local col = vim.fn.col(".")
	vim.cmd("normal! yyp")
	vim.fn.cursor(vim.fn.line("."), col)
end, { desc = "向下复制一行" }) -- shift + alt + down

local function close_nvim_tab()
	local count = #vim.fn.getbufinfo({ buflisted = 1 }) -- 获取当前buffer数量
	if count == 1 then
		pcall(vim.cmd, "write")
		vim.cmd("q!")
	else
		pcall(vim.cmd, "write")
		vim.cmd("bdelete!")
	end
end
vim.keymap.set("i", "<C-w>", close_nvim_tab, { desc = "关闭当前 buffer" })

vim.keymap.set("i", "<S-Tab>", "<C-o><<", { desc = "向左缩进一个tab" })

local function ctrl_right_not_across_current_line()
	local currentLine = vim.fn.line(".") -- 获得当前行数
	local view = vim.fn.winsaveview() -- 保存当前视图，最后要恢复视图
	vim.cmd("normal! w") -- 执行normal模式下的w
	local nextLine = vim.fn.line(".") -- 获得当前光标所在行数
	vim.fn.winrestview(view) -- 恢复原来视图
	if currentLine == nextLine then
		vim.cmd("normal! w")
		vim.cmd("startinsert")
	else
		vim.fn.cursor(currentLine, vim.fn.col("$")) -- 设置光标位置
	end
end
vim.keymap.set("i", "<C-Right>", ctrl_right_not_across_current_line, { desc = "向右移动一个单词" })

local function ctrl_left_not_across_current_line()
	local currentLine = vim.fn.line(".") -- 获得当前行数
	local view = vim.fn.winsaveview() -- 保存当前视图，最后要恢复视图
	vim.cmd("normal! b") -- 执行normal模式下的b
	local nextLine = vim.fn.line(".") -- 获得当前光标所在行数
	vim.fn.winrestview(view) -- 恢复原来视图
	if currentLine == nextLine then
		vim.cmd("normal! b")
		vim.cmd("startinsert")
	else
		vim.fn.cursor(currentLine, vim.fn.col("^")) -- 设置光标位置
	end
end
vim.keymap.set("i", "<C-Left>", ctrl_left_not_across_current_line, { desc = "向左移动一个单词" })

local function select_between()
	local ch = vim.fn.getcharstr()
	if ch == "" or ch == "q" then
		return
	end
	vim.cmd("stopinsert")
	vim.api.nvim_input("vi" .. ch)
end

vim.keymap.set("i", "<C-e>", select_between, { desc = "选中左右两边双引号当中的内容" })

vim.keymap.set("i", "<C-f>", "<Cmd>FzfLua grep_curbuf<CR>", { desc = "在当前文件模糊查找" })

vim.keymap.set("i", "<A-Left>", "<C-o><C-o>", { desc = "回到上一次光标所处位置" })

vim.keymap.set("i", "<A-Right>", "<C-o><C-i>", { desc = "回到下一次光标所处位置" })

vim.keymap.set("i", "<M-C-F>", '<Cmd>lua require("conform").format({ async = true })<CR>', { desc = "格式化文档" }) -- ctrl+alt+f

vim.keymap.set("i", "<C-CR>", "<C-o>o", { desc = "向下新起一行" })

vim.keymap.set("i", "<C-S-CR>", "<C-o>O", { desc = "向上新起一行" })

vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { desc = "全选" })

vim.keymap.set("i", "<C-`>", "<Cmd>ToggleTerm<CR>", { desc = "打开终端" })

-- vim.keymap.set("i", "<C-b>", "<Cmd>NvimTreeToggle<CR>", { desc = "切换目录树" })

vim.keymap.set("i", "<C-o>", "<C-o>viw", { desc = "开始增量选中" })

vim.keymap.set("i", "<C-m>", "<CR>", { desc = "修复一个莫名其妙的bug" })

vim.keymap.set("i", "<C-Home>", "<C-o>m`<C-Home>", { desc = "回到文件开头" })

vim.keymap.set("i", "<C-End>", "<C-o>m`<C-End>", { desc = "回到文件结尾" })

-- local whatIsTheNext = nil
-- vim.keymap.set("i", "<C-n>", function()
-- 	whatIsTheNext = vim.fn.getcharstr()
-- 	if whatIsTheNext == "" then
-- 		whatIsTheNext = nil
-- 		return
-- 	end
-- 	vim.cmd("normal! f" .. whatIsTheNext)
-- end, { desc = "行内查找" })

-- vim.keymap.set("i", "<C-,>", function()
-- 	if whatIsTheNext == nil then
-- 		return
-- 	end
-- 	vim.cmd("normal! F" .. whatIsTheNext)
-- end, { desc = "接着行内前后查找" })
--
-- vim.keymap.set("i", "<C-;>", function()
-- 	if whatIsTheNext == nil then
-- 		return
-- 	end
-- 	vim.cmd("normal! f" .. whatIsTheNext)
-- end, { desc = "接着行内后前查找" })

vim.keymap.set("i", "<C-j>", function()
	require("flash").jump()
end, { desc = "jump" })

-- insert end

----------------------------------------------------------------可视模式----------------------------------------------------------------

vim.keymap.set("v", "<Left>", "<Esc>i<Left>", { desc = "取消选择并左移" })

vim.keymap.set("v", "<Right>", "<Esc>i<Right>", { desc = "取消选择并右移" })

vim.keymap.set("v", "<Up>", "<Esc>i<Up>", { desc = "取消选择并上移" })

vim.keymap.set("v", "<Down>", "<Esc>i<Down>", { desc = "取消选择并下移" })

vim.keymap.set("v", "<Home>", "<Esc>i<Home>", { desc = "取消选择并回到行开头" })

vim.keymap.set("v", "<End>", "<Esc>i<End>", { desc = "取消选中并回到行结尾" })

vim.keymap.set("v", "<BS>", '"_x', { desc = "删除选中内容, 不污染剪切板" })

vim.keymap.set("v", "<C-c>", "ygv", { desc = "复制选中内容并保持选中" }) -- y 复制后会退出可视模式，gv 会重新选中刚才的区域。这样看起来就像 VSCode 那样：复制完选区还在。

vim.keymap.set("v", "<C-x>", "xi", { desc = "剪切选中的内容" })

vim.keymap.set("v", "<S-Up>", "<Up>", { desc = "选择并上移" })

vim.keymap.set("v", "<S-Down>", "<Down>", { desc = "选择并下移" })

vim.keymap.set("v", "<S-Left>", "<Left>", { desc = "选择并左移" })

vim.keymap.set("v", "<S-Right>", "<Right>", { desc = "选择并右移" })

vim.keymap.set("v", "<C-l>", "<Down><End>", { desc = "接着选择下一行" })

vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "注释选中行" })

vim.keymap.set("v", "<C-v>", '"_c<C-r>+', { desc = "删掉选中内容并进行粘贴" })

vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "下移选中行" })

vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "上移选中行" })

vim.keymap.set("v", "<C-S-Up>", "5k", { desc = "向上选中5行" })

vim.keymap.set("v", "<C-S-Down>", "5j", { desc = "向下选中5行" })

vim.keymap.set("v", "<Tab>", ">gv", { desc = "向右缩进" })

vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "向左缩进" })

vim.keymap.set("v", "<C-d>", function()
	local mc = require("multicursor-nvim")
	mc.matchAddCursor(1)
end, { desc = "添加下一个匹配光标" })

vim.keymap.set("v", "<C-S-D>", function()
	mc.matchAddCursor(-1)
end, { desc = "添加上一个匹配光标" })

vim.keymap.set("v", "<C-o>", function()
	vim.api.nvim_input("an")
end, { desc = "增量选中" })

vim.keymap.set("v", "<C-i>", function()
	vim.api.nvim_input("in")
end, { desc = "增量选中" })

local function format_table(text)
	if not text or #text == 0 then
		return text
	end

	-- 1. 把一行按 | 拆成单元格（去首尾 |，每格 trim）
	local function split_row(line)
		local s = line:gsub("^%s+", ""):gsub("%s+$", "")
		if s:sub(1, 1) == "|" then
			s = s:sub(2)
		end
		if s:sub(-1) == "|" then
			s = s:sub(1, -2)
		end
		local cells = {}
		for cell in (s .. "|"):gmatch("(.-)|") do
			table.insert(cells, vim.trim(cell))
		end
		return cells
	end

	-- 2. 判断是否是 markdown 表格的分隔行（如 ---、:---、---:、:---:）
	local function is_separator(line)
		local core = line:gsub("[%s|:]", "")
		return core ~= "" and core:match("^[%-]+$") ~= nil
	end

	-- 3. 解析每一行；分隔行一定是第 2 行（如果有）
	local rows, sep_index = {}, nil
	for i, line in ipairs(text) do
		rows[i] = split_row(line)
		if i == 2 and is_separator(line) then
			sep_index = i
		end
	end

	-- 4. 统计列数
	local col_count = 0
	for _, cells in ipairs(rows) do
		if #cells > col_count then
			col_count = #cells
		end
	end
	if col_count == 0 then
		return text
	end

	-- 5. 计算每列的最大显示宽度（中文等宽用 strdisplaywidth，跳过分隔行）
	local col_widths = {}
	for c = 1, col_count do
		col_widths[c] = 3
	end -- 最小 3，保证能放下 ---
	for i, cells in ipairs(rows) do
		if i ~= sep_index then
			for c = 1, col_count do
				local w = vim.fn.strdisplaywidth(cells[c] or "")
				if w > col_widths[c] then
					col_widths[c] = w
				end
			end
		end
	end

	-- 6. 从分隔行提取每列的对齐方式
	local aligns = {}
	if sep_index then
		for c = 1, col_count do
			local cell = rows[sep_index][c] or ""
			local left = cell:sub(1, 1) == ":"
			local right = cell:sub(-1) == ":"
			if left and right then
				aligns[c] = "center"
			elseif right then
				aligns[c] = "right"
			else
				aligns[c] = "left"
			end
		end
	end

	-- 7. 按显示宽度用空格填充
	local function pad(cell, width, align)
		local diff = width - vim.fn.strdisplaywidth(cell)
		if diff <= 0 then
			return cell
		end
		if align == "right" then
			return string.rep(" ", diff) .. cell
		elseif align == "center" then
			local l = math.floor(diff / 2)
			return string.rep(" ", l) .. cell .. string.rep(" ", diff - l)
		else
			return cell .. string.rep(" ", diff)
		end
	end

	-- 8. 重建每一行；分隔行按对齐方式重新生成 ---
	local out = {}
	for i, cells in ipairs(rows) do
		local parts = {}
		if i == sep_index then
			for c = 1, col_count do
				local w = col_widths[c]
				local a = aligns[c] or "left"
				local dashes
				if a == "center" then
					dashes = ":" .. string.rep("-", math.max(w - 2, 1)) .. ":"
				elseif a == "right" then
					dashes = string.rep("-", math.max(w - 1, 2)) .. ":"
				else
					dashes = string.rep("-", math.max(w, 3))
				end
				table.insert(parts, " " .. dashes .. " ")
			end
		else
			for c = 1, col_count do
				local cell = cells[c] or ""
				local a = aligns[c] or "left"
				table.insert(parts, " " .. pad(cell, col_widths[c], a) .. " ")
			end
		end
		table.insert(out, "|" .. table.concat(parts, "|") .. "|")
	end

	return out
end

vim.keymap.set("v", "<leader>tfmt", function()
	local start_pos = vim.fn.getpos("v")
	local end_pos = vim.fn.getpos(".")

	-- 行模式：只用行号，列号忽略
	local text = vim.fn.getregion(start_pos, end_pos, { type = "V", exclusive = false })

	-- 规范化行号（getpos 返回 1-based）
	local s_lnum = math.min(start_pos[2], end_pos[2])
	local e_lnum = math.max(start_pos[2], end_pos[2])

	-- formatted 是你格式化后的行列表
	local formatted = format_table(text) -- TODO

	vim.api.nvim_buf_set_text(
		0,
		s_lnum - 1,
		0, -- 起始：0-based 行，第 0 列（行首）
		e_lnum - 1,
		#vim.fn.getline(e_lnum), -- 结束：0-based 行，行字节长度（exclusive 到行尾，不含换行符）
		formatted
	)

	vim.cmd("normal! \27") -- 进入normal模式
end, { desc = "格式化markdown格式table表" })

local function delete_surround_brackets()
	local current_mode = vim.fn.mode()
	-- print(current_mode)
	if current_mode == "V" then
		return
	end

	local s_pos = vim.fn.getpos("v")[3]
	local e_pos = vim.fn.getpos(".")[3]
	local s = math.min(s_pos, e_pos)
	local e = math.max(s_pos, e_pos)

	-- print(s, e)

	local line_str = vim.fn.getline(".")
	local res = line_str:sub(1, s - 2) .. line_str:sub(s, e) .. line_str:sub(e + 2)
	if s == 1 then
		res = line_str:sub(s, e) .. line_str:sub(e + 2)
	end

	local line = vim.fn.line(".")
	vim.api.nvim_buf_set_text(
		0,
		line - 1,
		0, -- 起始：0-based 行，第 0 列（行首）
		line - 1,
		#line_str, -- 结束：0-based 行，行字节长度（exclusive 到行尾，不含换行符）
		{ res }
	)
end

vim.keymap.set("v", "<leader>sd", delete_surround_brackets, { desc = "删除周围两侧" })

vim.keymap.set("v", "s", function()
	local surround = vim.fn.getcharstr()
	if surround == "\27" then
		-- <Esc>
		return
	end

	if surround == "d" then
		delete_surround_brackets() -- 删掉周围的括号
		return
	end

	local map = {
		["("] = ")",
		[")"] = "(",
		["["] = "]",
		["]"] = "[",
		["{"] = "}",
		["}"] = "{",
		["<"] = ">",
		[">"] = "<",
	}

	local left, right = surround, surround
	if surround == "(" or surround == "[" or surround == "{" or surround == "<" then
		right = map[surround]
	end
	if surround == ")" or surround == "]" or surround == "}" or surround == ">" then
		left = map[surround]
	end

	-- print(left, right)

	local pos_start = vim.fn.getpos("v")[3]
	local pos_end = vim.fn.getpos(".")[3]
	local start = math.min(pos_start, pos_end)
	local _end = math.max(pos_start, pos_end)
	local line = vim.fn.line(".")
	local line_str = vim.fn.getline(".")

	local char_idx = vim.fn.charidx(line_str, _end - 1) -- TODO: 这是啥意思？
	local byte_end = vim.fn.byteidx(line_str, char_idx + 1) -- TODO: 这是啥意思？

	if byte_end == -1 then
		byte_end = #line_str
	end

	-- print(char_idx, byte_end)

	local res = line_str:sub(1, start - 1)
		.. left
		.. line_str:sub(start, byte_end)
		.. right
		.. line_str:sub(byte_end + 1)
	-- print(res)

	vim.api.nvim_buf_set_text(
		0,
		line - 1,
		0, -- 起始：0-based 行，第 0 列（行首）
		line - 1,
		#line_str, -- 结束：0-based 行，行字节长度（exclusive 到行尾，不含换行符）
		{ res }
	)

	-- TODO: 周围插入括号之后，选中的位置变了，我希望他不变，这在多次插入括号的时候有用
end, { desc = "包围 or 删除周围括号" })

vim.keymap.set("v", "p", '"_xP', { desc = "覆盖粘贴" })

vim.keymap.set("v", "$", function()
	vim.fn.cursor(vim.fn.line("."), vim.fn.col("$") - 1)
end, { desc = "选中到结尾，不包含换行符" })

-- visual end

----------------------------------------------------------------普通模式----------------------------------------------------------------

vim.keymap.set("n", "<C-Up>", "4k", { desc = "一次向上移动4行" })

vim.keymap.set("n", "<C-Down>", "4j", { desc = "一次向下移动4行" })

local function compile()
	local src = vim.fn.expand("%:p") -- 源文件绝对路径
	local out = vim.fn.expand("%:p:r") -- 去掉扩展名，作为输出名
	if src == "" then
		print("当前 buffer 没有关联文件")
		return
	end

	vim.cmd("write") -- 先保存
	local type = ""
	for i = #src, 1, -1 do
		print("src[" .. i .. "] = " .. src:sub(i, i))
		if src:sub(i, i) == "." then
			type = src:sub(i + 1, #src)
			break
		end
	end
	print("type: " .. type)

	if type == "cpp" then
		local cmd = "g++ "
			.. vim.fn.shellescape(src)
			.. " -o "
			.. vim.fn.shellescape(out)
			.. " -g -std=c++17 -ljsoncpp -lmysqlclient -lcrypto -lfmt "
		print(cmd)
		vim.cmd("!" .. cmd)
	elseif type == "rs" then
		local cmd = "rustc -g " .. vim.fn.shellescape(src) .. " -o " .. vim.fn.shellescape(out)
		print(cmd)
		vim.cmd("!" .. cmd)
	elseif type == "c" then
		local cmd = "gcc -g " .. vim.fn.shellescape(src) .. " -o " .. vim.fn.shellescape(out)
		print(cmd)
		vim.cmd("!" .. cmd)
	else
		print("未知的文件类型: " .. type .. " 无法编译")
		return
	end
	print("编译完成✅")
end

vim.keymap.set("n", "<leader>cmp", compile, { desc = "编译cpp代码, 带-g选项" }) -- compile
vim.keymap.set("n", "<leader>run", "<Cmd>RunCode<CR>", { desc = "编译并运行, 不调试, 无调试信息" }) -- run

vim.keymap.set("n", "<F5>", function()
	local dap = require("dap")
	compile()
	dap.continue()
end, { desc = "编译，运行调试" })

vim.keymap.set("n", "<F9>", function()
	local dap = require("dap")
	dap.toggle_breakpoint()
end, { desc = "切换断点" })

vim.keymap.set("n", "<F10>", function()
	local dap = require("dap")
	dap.step_over()
end, { desc = "单步跳过" })

vim.keymap.set("n", "<F11>", function()
	local dap = require("dap")
	dap.step_into()
end, { desc = "单步进入" })

vim.keymap.set("n", "<F12>", function()
	local dap = require("dap")
	dap.step_out()
end, { desc = "单步跳出, 类似于finish" })

-- means debug close
vim.keymap.set("n", "<leader>dc", function() -- debug close
	require("dap").terminate()
end, { desc = "退出调试" })

vim.keymap.set("n", "<C-b>", "<Cmd>NvimTreeToggle<CR>", { desc = "切换目录树" })

vim.keymap.set("n", "<leader>yz", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" }) -- yazi

vim.keymap.set("n", "<C-PageDown>", "<Cmd>BufferLineCycleNext<CR>", { desc = "下一个 buffer" })

vim.keymap.set("n", "<C-PageUp>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "上一个 buffer" })

vim.keymap.set("n", "<C-`>", "<Cmd>ToggleTerm<CR>", { desc = "切换终端" })

vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLinePick<CR>", { desc = "挑选buffer" }) -- buffer pick

vim.keymap.set("n", "<leader>bc", "<Cmd>write<CR><Cmd>bdelete<CR>", { desc = "关闭当前buffer" }) -- buffer close

vim.keymap.set("n", "<A-Left>", "<C-o>", { desc = "回到上一次光标所处位置" })

vim.keymap.set("n", "<A-Right>", "<C-i>", { desc = "回到下一次光标所处位置" })

vim.keymap.set("n", "gd", ":FzfLua lsp_definitions<CR>", { desc = "跳转到定义" })

-- vim.keymap.set("n", "<leader>bf", ":FzfLua grep_curbuf<CR>", { desc = "在当前文件模糊查找" }) -- buffer find

vim.keymap.set("n", "<leader>ff", ":FzfLua grep_curbuf<CR>", { desc = "在当前文件模糊查找" })

vim.keymap.set("n", "<C-Right>", function()
	local currentLine = vim.fn.line(".") -- 获得当前行数
	local view = vim.fn.winsaveview() -- 保存当前视图，最后要恢复视图
	vim.cmd("normal! w") -- 执行normal模式下的w
	local nextLine = vim.fn.line(".") -- 获得当前光标所在行数
	vim.fn.winrestview(view) -- 恢复原来视图
	if currentLine == nextLine then
		vim.cmd("normal! w")
	else
		vim.fn.cursor(currentLine, vim.fn.col("$")) -- 设置光标位置
	end
end, { desc = "向右移动一个单词, 不跨行" })

vim.keymap.set("n", "<C-Left>", function()
	local currentLine = vim.fn.line(".") -- 获得当前行数
	local view = vim.fn.winsaveview() -- 保存当前视图，最后要恢复视图
	vim.cmd("normal! b") -- 执行normal模式下的w
	local nextLine = vim.fn.line(".") -- 获得当前光标所在行数
	vim.fn.winrestview(view) -- 恢复原来视图
	if currentLine == nextLine then
		vim.cmd("normal! b")
	else
		vim.fn.cursor(currentLine, vim.fn.col("^")) -- 设置光标位置
	end
end, { desc = "向左移动一个单词, 不跨行" })

-- vim.keymap.set("n", "<leader>du", function()
-- 	local dapui = require("dapui")
-- 	dapui.toggle()
-- end, { desc = "切换 DAP UI" })

-- vim.keymap.set("n", "<leader>dw", function()
-- 	local dapui = require("dapui")
-- 	dapui.float_element("watches")
-- end, { desc = "悬浮 Watches" })

-- file_symbols
vim.keymap.set(
	"n",
	"<leader>fs",
	"<Cmd>FzfLua lsp_document_symbols<CR>",
	{ desc = "file_symbols 当前文件符号大纲" }
)

vim.keymap.set("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "buffer delete" })

local ui_off = false
vim.keymap.set("n", "<leader>cpp", function()
	ui_off = not ui_off
	if ui_off then
		-- 关闭所有提示
		vim.b.completion = false
		vim.cmd("lsp disable clangd")
		print("🛑 已关闭所有代码提示 (Zen Mode)")
	else
		-- 恢复所有提示
		vim.b.completion = true
		vim.cmd("lsp enable clangd")
		print("✅ 已恢复代码提示")
	end
end, { desc = "一键开关代码提示" })

vim.keymap.set("n", "<leader>dl", "<Cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "打开诊断列表" })

vim.keymap.set(
	"n",
	"<leader>]",
	"<Cmd>lua vim.diagnostic.jump({count = 1, float = false})<CR>",
	{ desc = "去到下一个警告/报错" }
)

vim.keymap.set(
	"n",
	"<leader>[",
	"<Cmd>lua vim.diagnostic.jump({count = -1, float = false})<CR>",
	{ desc = "去到上一个警告/报错" }
)

vim.keymap.set("n", "<leader>jp", "<Cmd>lua require('flash').jump()<CR>", { desc = "跳转" })

vim.keymap.set("n", "<leader>kmp", "<Cmd>FzfLua keymaps<CR>", { desc = "预览快捷键" })

vim.keymap.set("n", "<leader>lps", "<Cmd>LivePreview start<CR>", { desc = "打开预览" })

vim.keymap.set("n", "<leader>lpc", "<Cmd>LivePreview close<CR>", { desc = "关闭预览" })

vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCycleNext<CR>", { desc = "下一个buffer" })

vim.keymap.set("n", "<leader>bh", "<Cmd>BufferLineCyclePrev<CR>", { desc = "上一个buffer" })

vim.keymap.set("n", "<M-J>", function()
	local col = vim.fn.col(".")
	vim.cmd("normal! yyp")
	vim.fn.cursor(vim.fn.line("."), col)
end, { desc = "向下复制一行" })

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "取消搜索高亮" })

vim.keymap.set(
	"n",
	"<leader>fmt",
	'<Cmd>lua require("conform").format({ async = true })<CR>',
	{ desc = "格式化文档" }
)

vim.keymap.set("n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "上一个buffer" })

vim.keymap.set("n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "下一个buffer" })

vim.keymap.set("n", "<leader>rt", function()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()
	-- print(node.name)
	api.tree.change_root_to_node(node)
end, { desc = "change nvim-tree root" })

vim.keymap.set("n", "<leader>ssh", "<Cmd>LspClangdSwitchSourceHeader<CR>", { desc = "切换头/源文件" })

vim.keymap.set("n", "<leader>ctb", function()
	local parts = vim.split(vim.fn.input("请输入表规格："), " ")
	local n, m = tonumber(parts[1]), tonumber(parts[2])
	local res = {}

	-- |     |     |
	-- | --- | --- |
	-- |     |     |

	for i = 1, n, 1 do
		local row = {}

		if i == 2 then
			row[#row + 1] = "|"
			for j = 1, m, 1 do
				row[#row + 1] = " --- |"
			end
			res[#res + 1] = table.concat(row)
			row = {}
		end

		row[#row + 1] = "|"
		for j = 1, m, 1 do
			row[#row + 1] = "     |"
		end
		res[#res + 1] = table.concat(row)
	end

	-- for key, value in pairs(res) do
	-- 	print(key, value)
	-- end
	vim.api.nvim_put(res, "l", true, true)
end, { desc = "制markdown表" })

vim.keymap.set("n", "<leader>img", function()
	-- local full_path = vim.api.nvim_buf_get_name(0)
	-- print(full_path)
	local dir_path = vim.fn.expand("%:p:h")
	-- print(dir_path)
	local img_dir_name = "image"
	local img_dir_path = dir_path .. "/" .. img_dir_name
	-- print(img_dir_path)

	-- 检查目录是否存在，不存在则创建
	if vim.fn.isdirectory(img_dir_path) == 0 then
		print("目录不存在，是否创建 " .. img_dir_path .. " (y/n)")
		local op = vim.fn.getcharstr()
		if op ~= "y" and op ~= "Y" then
			print("已取消")
			return
		end
		if vim.fn.mkdir(img_dir_path) == 0 then
			print("创建目录: " .. img_dir_path .. " 失败")
			return
		end
	end

	-- 获取剪切板内容
	local out = vim.system({ "wl-paste", "--no-newline" }, { text = false }):wait() -- 同步函数，text = false 可以读取二进制内容
	-- for key, value in pairs(img) do
	--     print(key, value)
	-- end

	if out.code ~= 0 then
		print("获取剪切板内容失败")
		return
	end

	local img_content = out.stdout

	-- 检查是否为图片内容
	local function detect_image_type(img)
		local len = #img
		if len >= 8 and img:sub(1, 8) == "\137PNG\r\n\26\n" then
			return "png"
		end
		if len >= 3 and img:byte(1) == 0xFF and img:byte(2) == 0xD8 and img:byte(3) == 0xFF then
			return "jpg" -- jpg / jpeg 都是这个
		end
		return nil
	end

	-- print(img_content)
	local type = detect_image_type(img_content)
	if type == nil then
		print("非图片类型")
		return
	end

	-- 提示用户输入图片名 img_name，图片将被放在 img_dir_path/img_name.xxx 里
	local img_name_no_suffix = vim.fn.input(
		"请输入图片名称（不要带后缀，为空视为取消，空格默认为时间格式 YYYY-mm-dd_HHMMSS）："
	)
	if img_name_no_suffix == "" then
		print("已取消")
		return
	end

	if img_name_no_suffix == " " then
		img_name_no_suffix = os.date("%Y-%m-%d_%H%M%S") --[[@as string]] -- 告诉 lua_ls 返回值确认为 string
	end

	local img_name_suffix = img_name_no_suffix .. "." .. type
	-- 判断文件是否存在，不存在就写入内容，存在就询问
	-- print("img_name = " .. img_name)
	local img_path = img_dir_path .. "/" .. img_name_suffix
	if vim.uv.fs_stat(img_path) then
		print("已存在 " .. img_path .. " ，是否覆盖原内容？(y / n)")
		local op = vim.fn.getcharstr()
		if op ~= "y" and op ~= "Y" then
			print("已取消")
			return
		end
	end

	local file, err = io.open(img_path, "w")
	if not file then
		print("打开 " .. img_path .. " 失败: " .. err)
		return
	end
	file:write(img_content)
	file:close()
	print("图片创建成功！" .. img_path)

	-- ![img](./image/abc.png)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local formatted = "![img](./" .. img_dir_name .. "/" .. img_name_suffix .. ")"
	vim.api.nvim_buf_set_text(
		0, -- 哪个缓冲区，0代表当前缓冲区
		row - 1, -- 起始行 0-based
		col, -- 起始列 0-based
		row - 1, -- 结束行 0-based
		col, -- 结束列 0-based 行，行字节长度（exclusive 到行尾，不含换行符）
		{ formatted } -- 插入的内容，table 类型
	)
end, { desc = "插入图片" })

vim.keymap.set("n", "L", function()
	local view = vim.fn.winsaveview() -- 保存当前视图，最后要恢复视图
	vim.cmd("normal! o") -- 执行normal模式下的o
	vim.fn.winrestview(view) -- 恢复原来视图
end, { desc = "向下开辟空行" })

vim.keymap.set("n", "H", function()
	local current_line = vim.fn.line(".")
	local current_col = vim.fn.col(".")
	local view = vim.fn.winsaveview() -- 保存当前视图，最后要恢复视图
	vim.cmd("normal! O") -- 执行normal模式下的o
	vim.fn.winrestview(view) -- 恢复原来视图
	vim.fn.cursor(current_line + 1, current_col)
end, { desc = "向上开辟新行" })
-- normal end

----------------------------------------------------------------命令模式----------------------------------------------------------------

vim.keymap.set("c", "<C-f>", "<C-u>lua FzfLua.files({cwd = '~'})<CR>", { desc = "全局查找文件" })

vim.keymap.set("c", "<C-BS>", "<C-w>", { desc = "向左删除一个单词" })

-- vim.keymap.set("c", "<C-BS>", "<C-w>", { desc = "向左删除一个单词"})

vim.keymap.set("c", "<C-v>", "<C-r>+", { desc = "粘贴" })

-- commandline end

----------------------------------------------------------------终端模式----------------------------------------------------------------

vim.keymap.set("t", "<C-`>", "<Cmd>ToggleTerm<CR>", { desc = "切换终端" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "terminal to normal" })

vim.keymap.set("t", "<C-b>", "<Cmd>NvimTreeToggle<CR>", { desc = "切换目录树" })

-- vim.keymap.set("t", "<C-BS>", "") -- 暂时还没办法实现向前删除一个单词

----------------------------------------------------------------可视块模式----------------------------------------------------------------

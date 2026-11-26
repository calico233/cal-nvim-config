return {
	"CRAG666/code_runner.nvim",
	config = function()
		local function find_cmake_target(cmake_file)
			local content = table.concat(vim.fn.readfile(cmake_file), "\n")

			-- 支持 add_executable(App ...) 和 qt_add_executable(App ...)
			return content:match("[Qq][Tt]_[Aa][Dd][Dd]_[Ee][Xx][Ee][Cc][Uu][Tt][Aa][Bb][Ll][Ee]%s*%(%s*([%w_%-]+)")
				or content:match("[Aa][Dd][Dd]_[Ee][Xx][Ee][Cc][Uu][Tt][Aa][Bb][Ll][Ee]%s*%(%s*([%w_%-]+)")
		end

		local function run_cpp()
			vim.cmd("update") -- 编译前保存当前文件

			local file = vim.api.nvim_buf_get_name(0)
			local dir = vim.fs.dirname(file)

			-- upward = false：只检查当前 .cpp 所在目录
			local cmake_file = vim.fs.find("CMakeLists.txt", {
				path = dir,
				upward = true,
				type = "file",
			})[1]

			local cmd

			if cmake_file then
				local target = find_cmake_target(cmake_file)

				if not target then
					vim.notify(
						"未能从 CMakeLists.txt 找到 add_executable 或 qt_add_executable 的目标名",
						vim.log.levels.ERROR
					)
					return
				end

				cmd = string.format(
					"cd %s && cmake -S . -B build && cmake --build build && ./build/%s",
					vim.fn.shellescape(dir),
					vim.fn.shellescape(target)
				)
			else
				local output = dir .. "/" .. vim.fn.fnamemodify(file, ":t:r")

				-- 适合单文件 Qt 6 Widgets，也能编译普通 C++。
				cmd = string.format(
					"g++ -std=c++17 %s -o %s $(pkg-config --cflags --libs Qt6Widgets) && %s",
					vim.fn.shellescape(file),
					vim.fn.shellescape(output),
					vim.fn.shellescape(output)
				)
			end

			require("code_runner.commands").run_from_fn(cmd)
		end

		require("code_runner").setup({
			-- mode = "tab",
			mode = "float",

			root_markers = {}, -- 避免默认 CMake 项目规则抢先执行

			float = {
				border = "rounded", -- 这里是 border，不是 bollrder
				width = 0.5,
				height = 0.8,
				x = 0.5,
				y = 0.5,
				float_hl = "MyCodeRunnerBg",
				blend = 0,
			},

			filetype = {
				cpp = run_cpp,
				c = "cd $dir && gcc $fileName -o $dir/$fileNameWithoutExt && $dir/$fileNameWithoutExt",
				java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
				rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
                lua = "cd $dir && lua $fileName",
                python = "cd $dir && python3 $fileName",
			},
		})
	end,
}

-- return {
-- 	"CRAG666/code_runner.nvim",
-- 	config = function()
-- 		require("code_runner").setup({
-- 			-- startinsert = true,
-- 			mode = "float", -- 浮动窗口的详细定制
-- 			float = {
-- 				border = "rounded", -- 边框样式，可选："none", "single", "double", "rounded", "solid", "shadow"
-- 				width = 0.5, -- 宽度：0.7 代表占屏幕宽度的 70%
-- 				height = 0.8, -- 高度：0.6 代表占屏幕高度的 60%
-- 				x = 0.5, -- 水平居中（0.5 即为居中）
-- 				y = 0.5, -- 垂直居中（0.5 即为居中）
-- 				-- border_hl = "MyCodeRunnerBorder", -- 边框颜色高亮组（默认即可）
-- 				float_hl = "MyCodeRunnerBg",
-- 				blend = 0,
-- 			},
-- 			filetype = {
-- 				c = "cd $dir && gcc $fileName -o $dir/$fileNameWithoutExt && $dir/$fileNameWithoutExt",
-- 				cpp = "cd $dir && g++ -std=c++17 $fileName -o $dir/$fileNameWithoutExt && $dir/$fileNameWithoutExt",
-- 				java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
-- 				-- python = "python3 -u",
-- 				rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
-- 				-- typescript = "deno run",
-- 			},
-- 		})
-- 	end,
-- }

-- The available variables are the following:
--
--     file: path to current open file (e.g. /home/user/current_dir/current_file.ext
--     fileName: filename of current open file (e.g. current_file.ext)
--     fileNameWithoutExt: filename without extension of current file (e.g. current_file)
--     dir: path to directory of current open file (e.g. /home/user/current_dir)
--     end: finish the command (it is useful for commands that do not require final autocompletion)

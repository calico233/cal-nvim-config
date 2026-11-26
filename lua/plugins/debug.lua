return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- 1. 配置 gdb 适配器
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}

			-- 2. 配置 C/C++/Rust 的调试方案
			local configs = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						local out = vim.fn.expand("%:p:r")
						-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						return out;
					end,
					args = {},
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
				-- {
				-- 	name = "Select and attach to process",
				-- 	type = "gdb",
				-- 	request = "attach",
				-- 	program = function()
				-- 		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				-- 	end,
				-- 	pid = function()
				-- 		local name = vim.fn.input("Executable name (filter): ")
				-- 		return require("dap.utils").pick_process({ filter = name })
				-- 	end,
				-- 	cwd = "${workspaceFolder}",
				-- },
				-- {
				-- 	name = "Attach to gdbserver :1234",
				-- 	type = "gdb",
				-- 	request = "attach",
				-- 	target = "localhost:1234",
				-- 	program = function()
				-- 		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				-- 	end,
				-- 	cwd = "${workspaceFolder}",
				-- },
			}

			dap.configurations.c = configs
			dap.configurations.cpp = configs
			dap.configurations.rust = configs

			-- 3. 初始化 DAP UI
			dapui.setup()

			-- 4. 自动打开/关闭 UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

		end,
	},
}

-- ~/.config/nvim/lua/plugins/multicursor.lua
return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set
		-- 上下添加光标 (类似 VS Code 的 Ctrl+Alt+Down/Up)
		set({ "n", "x" }, "<A-j>", function()
			mc.lineAddCursor(1)
		end, { desc = "向下添加光标" })
		set({ "n", "x" }, "<A-k>", function()
			mc.lineAddCursor(-1)
		end, { desc = "向上添加光标" })

		-- 在多光标模式下，用 <Esc> 清除所有光标或禁用
		mc.addKeymapLayer(function(layerSet)
			layerSet("n", "<Esc>", function()
				-- if mc.cursorsEnabled() then
				-- 	mc.disableCursors() -- 暂时禁用但保留光标，方便移动
				-- else
				-- 	mc.clearCursors() -- 彻底清除所有光标
				-- end
				mc.disableCursors()
				mc.clearCursors()
			end, { desc = "清除/禁用光标" })

			-- 删除当前主光标
			layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "删除当前光标" })
		end)
	end,
}

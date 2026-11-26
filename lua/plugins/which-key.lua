return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		defer = function()
			return true -- 永远不自动弹出
		end,
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}

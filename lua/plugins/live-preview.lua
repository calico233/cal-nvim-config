return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		-- You can choose one of the following pickers
		"ibhagwan/fzf-lua",
	},
	config = function()
		require("livepreview.config").set({
			port = 5500,
			browser = "firefox",
			dynamic_root = false,
			sync_scroll = true,
			picker = "",
			address = "127.0.0.1",
		})
	end,
}

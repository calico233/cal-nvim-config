return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	lazy = false,
	opts = {},
	config = function(_, opts)
		require("bufferline").setup(opts)
	end
}


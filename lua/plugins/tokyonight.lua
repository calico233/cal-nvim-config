return {
	-- "https://github.com/folke/tokyonight.nvim"
	"folke/tokyonight.nvim", -- lazy会帮我们把这个补全为https://github.com/folke/tokyonight.nvim
	opts = {
		style = "night"
	},
	config = function (_, opts)
		require("tokyonight").setup(opts)
		vim.cmd("colorscheme tokyonight")
	end
}



return {
	"folke/snacks.nvim",
	opts = {
		image = {
			enabled = true,
			-- 同名图片被替换后按内容重新加载，见 lua/config/image_rev.lua
			-- resolve = function(file, src)
			-- 	return require("config.image_rev").resolve(file, src)
			-- end,
		},
	},
	-- config = function(_, opts)
	-- 	require("snacks").setup(opts)
	-- 	require("config.image_rev").setup()
	-- end,
}

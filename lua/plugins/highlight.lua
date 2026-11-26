return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",  -- 关键：切换到 main 分支
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- main 分支的 API 变了，不再使用 configs.setup
        require("nvim-treesitter").setup()

        -- 手动安装你需要的解析器
        require("nvim-treesitter").install({ "cpp", "lua" })

        -- 高亮启用方式也变了，需要用 autocmd 手动触发
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "cpp", "lua", "hpp", "h" },
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}

-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	branch = "main",
-- 	lazy = false,
-- 	build = ":TSUpdate",
-- 	config = function()
-- 		require("nvim-treesitter").setup({
-- 			-- ensure_install = { "cpp", "lua" },
-- 			incremental_selection = {
-- 				enable = true,
-- 				keymaps = {
-- 					init_selection = "<A-o>", -- 开始选择并选中第一个节点
-- 					node_incremental = "<A-o>", -- 逐步扩大选择到父节点
-- 					scope_incremental = "<A-O>", -- 直接扩大到整个作用域 (如整个函数)
-- 					node_decremental = "<A-i>", -- 逐步缩小选择
-- 				},
-- 			},
-- 		})
-- 		vim.api.nvim_create_autocmd("FileType", {
-- 			pattern = { "cpp", "lua", "hpp", "h" },
-- 			callback = function()
-- 				vim.treesitter.start()
-- 			end,
-- 		})
-- 		-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- Indentation  缩排，我也不知道这有啥用
-- 	end,
-- }

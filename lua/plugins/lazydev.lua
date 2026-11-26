-- 独立的 lazydev.nvim 配置
return {
    "folke/lazydev.nvim",
    ft = "lua", -- 关键：确保只在 Lua 文件中加载并生效
    opts = {}, -- 使用默认配置即可，它会自动处理 Neovim 类型
}

return {
	"devilsakuya/nvim-translate",
	opts = {
		-- api_key = function ()
		-- 	return "sk-jbgaubmotuyfmkszhvgydwshhiuotnboxfufvpiovpwllpop"
		-- end,
		-- base_url = "https://api.siliconflow.cn/v1",
		-- model = "tencent/Hunyuan-MT-7B",
		api_key = function ()
			return os.getenv("DEEPSEEK_API_KEY")
		end,
		base_url = "https://api.deepseek.com",
		model = "deepseek-flash",
		prompt = "自动识别源语言,默认中英文互译,若为单个英文单词,返回它的意思,并额外返回音标.如果不知道返回什么,就返回不知道",
		trigger_key = "<leader>ts",
	},
}

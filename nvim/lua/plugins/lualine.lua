return {
	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = false,
			theme = "onedark",
			component_separators = "|",
			section_separators = "",
			max_width = 40,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "filename" },
			lualine_c = { "diff", "diagnostics" },
			lualine_x = { "fileformat" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}

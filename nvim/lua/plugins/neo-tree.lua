return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"luckasRanarison/neo-rename.nvim",
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function(_, opts)
		require("neo-tree").setup(opts)
		require("neo-rename").setup()
	end,
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		window = {
			position = "current",
			mappings = {
				["-"] = "navigate_up",
			},
		},
		filesystem = {
			hijack_netrw_behavior = "open_current",
			filtered_items = {
				visible = true,
			},
			follow_current_file = {
				enabled = false,
			},
		},
	},
}

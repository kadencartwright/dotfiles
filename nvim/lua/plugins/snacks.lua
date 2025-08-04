return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		lazygit = {},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			"<leader>g",
			function()
				require("snacks").lazygit.open()
			end,
			desc = "Lazy[G]it open",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command
			end,
		})
	end,
}

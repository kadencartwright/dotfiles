return {
	{ -- Highlight, edit, and navigate code

		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local languages = {
				"bash",
				"tsx",
				"diff",
				"html",
				"lua",
				"typescript",
				"javascript",
				"json",
				"json5",
				"luadoc",
				"markdown",
				"markdown_inline",
				"rust",
				"query",
				"vim",
				"vimdoc",
			}

			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			require("nvim-treesitter").install(languages):wait(300000)

			vim.treesitter.language.register("bash", "zsh")
			vim.treesitter.language.register("json5", "jsonc")

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true }),
				pattern = "*",
				callback = function()
					local ok = pcall(vim.treesitter.start)
					if not ok then
						return
					end

					if vim.bo.filetype ~= "ruby" then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}

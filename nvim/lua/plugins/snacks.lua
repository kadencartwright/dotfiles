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
		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = { "netrw" },
			group = vim.api.nvim_create_augroup("NetrwOnRename", { clear = true }),
			callback = function()
				vim.keymap.set("n", "R", function()
					local original_file_path = vim.b.netrw_curdir .. "/" .. vim.fn["netrw#Call"]("NetrwGetWord")

					vim.ui.input(
						{ prompt = "Move/rename to:", default = original_file_path },
						function(target_file_path)
							if target_file_path and target_file_path ~= "" then
								local file_exists = vim.uv.fs_access(target_file_path, "W")

								if not file_exists then
									vim.uv.fs_rename(original_file_path, target_file_path)

									Snacks.rename.on_rename_file(original_file_path, target_file_path)
								else
									vim.notify(
										"File '" .. target_file_path .. "' already exists! Skipping...",
										vim.log.levels.ERROR
									)
								end

								-- Refresh netrw
								vim.cmd(":Ex " .. vim.b.netrw_curdir)
							end
						end
					)
				end, { remap = true, buffer = true })
			end,
		})
	end,
}

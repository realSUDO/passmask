local passmask = require("passmask")

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*.env",
	callback = function()
		passmask.mask_buffer()
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*.env",
	callback = function()
		passmask.clear()
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*.env",
	callback = function()
		passmask.mask_buffer()
	end,
})

vim.api.nvim_create_user_command("PassMaskToggle", function()
	passmask.toggle()
end, {})

local passmask = require("passmask")

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*.env",
	callback = function()
		vim.opt_local.wrap = false
		passmask.mask_buffer()
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*.env",
	callback = function()
		vim.wo.wrap = true
		passmask.clear()
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*.env",
	callback = function()
		vim.wo.wrap = false
		passmask.mask_buffer()
	end,
})

vim.api.nvim_create_user_command("PassMaskToggle", function()
	passmask.toggle()
end, {})

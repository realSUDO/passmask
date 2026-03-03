local M = {}

M.ns = vim.api.nvim_create_namespace("passmask")

M.enabled = true

function M.mask_buffer(bufnr)
	if not M.enabled then
		return
	end

	bufnr = bufnr or vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_clear_namespace(bufnr, M.ns, 0, -1)

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	for i, line in ipairs(lines) do
		local key, value = line:match("^%s*([%w_]+)%s*=%s*(.+)$")

		if key and value then
			local eq_col = line:find("=")

			if eq_col then
				local value_len = #value
				local masked = string.rep("x", value_len)

				vim.api.nvim_buf_set_extmark(bufnr, M.ns, i - 1, eq_col, {
					end_col = eq_col + value_len,
					virt_text = { { masked, "Comment" } },
					virt_text_pos = "overlay",
					hl_mode = "replace",
				})
			end
		end
	end
end

function M.clear(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_clear_namespace(bufnr, M.ns, 0, -1)
end

function M.toggle()
	M.enabled = not M.enabled

	if M.enabled then
		M.mask_buffer()
	else
		M.clear()
	end
end

return M

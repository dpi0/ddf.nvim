local M = {}

local function has(bin)
	return vim.fn.executable(bin) == 1
end

function M.show_diff()
	if not has("git") then
		vim.notify("git not found in PATH", vim.log.levels.ERROR)
		return
	end

	if not has("delta") then
		vim.notify("delta not found in PATH", vim.log.levels.ERROR)
		return
	end

	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		vim.notify("Current buffer has no file", vim.log.levels.ERROR)
		return
	end

	if vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true") ~= "true" then
		vim.notify("Not inside a git repository", vim.log.levels.ERROR)
		return
	end

	vim.cmd("tabnew")
	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false

	local cmd = {
		"sh",
		"-c",
		"git diff -- " .. vim.fn.shellescape(file) .. " | delta",
	}

	vim.fn.termopen(cmd, {
		on_exit = function()
			vim.bo[buf].modifiable = false
		end,
	})

	vim.cmd("startinsert")

	-- Keybinds
	vim.keymap.set("n", "q", "<cmd>tabclose<CR>", { buffer = buf, silent = true })
	vim.keymap.set("t", "q", "<C-\\><C-n><cmd>tabclose<CR>", { buffer = buf, silent = true })
	vim.keymap.set("n", "<C-u>", "<C-u>", { buffer = buf, silent = true })
	vim.keymap.set("n", "<C-d>", "<C-d>", { buffer = buf, silent = true })
end

return M

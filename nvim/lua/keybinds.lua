vim.g.mapleader = " "
local bind = vim.keymap.set

-- Default
bind("i", "kj", "<Esc>")
bind("i", "kj", "<Esc>")
bind("n", "<Leader>n", "<CMD>noh<CR>")
-- Windows
bind("n", "<Leader>wl", "<C-W>l")
bind("n", "<Leader>wh", "<C-W>h")
bind("n", "<Leader>wk", "<C-W>k")
bind("n", "<Leader>wj", "<C-W>j")
-- NvimTree
bind("n", "<C-n>", "<CMD>NvimTreeToggle<CR>")
bind("n", "tf", "<CMD>NvimTreeFindFile<CR>")
-- Terminal
bind("n", "<A-i>", "<CMD>FloatermToggle<CR>")
bind({ "n", "v", "i" }, "<A-o>", "<CMD>stopinsert<CR>")
bind({ "t", "v", "i" }, "<Esc>", "<C-\\><C-n>")
bind({ "t", "v", "i" }, "kj", "<C-\\><C-n>")

local range_formatting = function()
	local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
	local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
	vim.lsp.buf.format({
		range = {
			["start"] = { start_row, 0 },
			["end"] = { end_row, 0 },
		},
		async = true,
	})
end
vim.keymap.set("v", "<leader>fc", range_formatting, { desc = "Range Formatting" })
local function format_range_operator()
	local old_func = vim.go.operatorfunc
	_G.op_func_formatting = function()
		local opts = {
			range = {
				["start"] = vim.api.nvim_buf_get_mark(0, "["),
				["end"] = vim.api.nvim_buf_get_mark(0, "]"),
			},
		}
		vim.lsp.buf.format(opts)
		vim.go.operatorfunc = old_func
		_G.op_func_formatting = nil
	end
	vim.go.operatorfunc = "v:lua.op_func_formatting"
	vim.api.nvim_feedkeys("g@", "n", false)
end

local function format_current_buffer()
	local cur_buf = vim.nvim_get_current_buf
	print(cur_buf)
	local opts = { buf = cur_buf }
	vim.lsp.buf.format(opts)
end

-- vim.keymap.set("n", "gf", "<Cmd>lua format_range_operator()<CR>")
vim.keymap.set("n", "gf", format_range_operator, { desc = "Range Formatting" })
-- vim.keymap.set("n", "<leader>F", format_current_buffer, { desc = "Range Formatting" })
vim.keymap.set("n", "<leader>fo", format_current_buffer, { desc = "Range Formatting" })

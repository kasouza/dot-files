function split(inputstr, sep)
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end

	return t
end

function join(t, sep)
	local str = ""
	for k, v in pairs(t) do
		str = str .. v .. sep
	end

	return str:sub(0, #str-1)
end

function put_header_guards(user_name)
	local cwd = split(vim.fn.getcwd(), '\\/')
	local project_name = cwd[#cwd]:upper()

	local filename = vim.fn.expand("%"):gsub("[%.\\/]", "_"):upper()

	local macro = join({ user_name, project_name, filename }, '_')

	local ifndef = "#ifndef " .. macro
	local define = "#define " .. macro
	local endif = "#endif"

	vim.api.nvim_put({ifndef, define, '', endif}, 'l', true, true)
end

vim.api.nvim_buf_set_keymap(0, 'n', '<C-h>', ':lua put_header_guards("KASOUZA")<CR>', { noremap=true, silent=true })

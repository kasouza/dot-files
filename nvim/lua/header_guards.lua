local M = {}
M.config = {}

-- A pattern to which separators should be replaced by '_' in the final guard
M.config.separators = '[%.\\/-]'

-- Splits a string (I don't know what else to say here lol)
function split(inputstr, sep)
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end

	return t
end

-- Joins a table (array) into a string, using `sep` as a separator between the string
function join(t, sep)
	local str = ""
	for k, v in pairs(t) do
		str = str .. v .. sep
	end

	return str:sub(0, #str-1)
end

-- Generate the header guards and output then into the current buffer
function M.header_guards(user_name)
	-- Uses the folder where nvim was started as a `project_name`
	local cwd = split(vim.fn.getcwd(), '\\/')
	local project_name = cwd[#cwd]:upper()

	-- Current open file (actually it's the path relative to `cwd`)
	local filename = vim.fn.expand("%"):upper()

	-- The macro to be used as the header guard 
	local macro = join({ user_name, project_name, filename }, '_'):gsub(M.config.separators, "_")

	-- Create the actual header guards
	local ifndef = "#ifndef " .. macro
	local define = "#define " .. macro
	local endif = "#endif"

	-- Put then in the file (with a empty line between the #define and #endif
	vim.api.nvim_put({ifndef, define, '', endif}, 'l', P, true)
end

return M

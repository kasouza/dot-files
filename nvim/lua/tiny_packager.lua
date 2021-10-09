local HOME = os.getenv('HOME')

local M = {}
M.plugins = {}

local paths = {}
paths.base  	= HOME .. '/.local/share/nvim/site/pack/tiny_packager'
paths.start 	= paths.base .. '/start'
paths.opt   	= paths.base .. '/opt'
paths.ftplugin 	= paths.base .. '/ftplugin'

--- Check if a git repo is acessible
function check_repo(url)
	local command = 'curl -o /dev/null -s -I -w "%{http_code}\n" -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/' .. url
	
	local handle = io.popen(command)
	local result = handle:read('*a')
	handle:close()

	result = result:gsub("%s+", "")

	return result == 200
end

--- Check if a file or directory exists in this path
function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

--- Check if a directory exists in this path
function isdir(path)
	if (not path) then
		return false
	end

	return exists(path.."/")
end

--- Create base dirs
function mkdirs_if_not_exist()
	for _,path in pairs(paths) do
		if (not isdir(path)) then
			os.execute('mkdir -p '..path)
		end
	end
end

-- Given a github url (minus the http://github.com/, i.e. 'developer/plugin'),
-- downloads a plugin and put it in the `plugin_type` folder
function M.add_plugin(url, --[[optional]]plugin_type)
	plugin_type = plugin_type or 'start'
	local path = paths[plugin_type]

	M.plugins[#M.plugins + 1] = {
		path=path,
		url=url
	}
end

function M.install_plugins()
	mkdirs_if_not_exist()

	for _,plugin in ipairs(M.plugins) do
		local _, _, _, name = string.find(plugin.url, "(/)(.+)")

		local full_path = plugin.path .. '/' .. name
		local is_installed,_ = isdir(full_path)

		if (not is_installed) then
			local is_repo_acessible = check_repo(plugin.url)
			if (not is_repo_acessible) then
				print(vim.inspect('Could not install plugin: "' .. plugin.url .. '"'))

			else
				local command = 'git clone https://github.com/' .. plugin.url .. ' ' .. full_path
				local handle = io.popen(command)
				local result = handle:read('*a')

				handle:close()
			end
		end
	end
end

return M

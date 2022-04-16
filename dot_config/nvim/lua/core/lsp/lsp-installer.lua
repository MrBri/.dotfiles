local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
	local opts = { -- server:get_default_options()
		on_attach = require("core.lsp.handlers").on_attach,
		capabilities = require("core.lsp.handlers").capabilities,
	}

	-- Apply AstroVim server settings (if available)
	local present, av_overrides = pcall(require, "core.lsp.server-settings." .. server.name)
	if present then
		opts = vim.tbl_deep_extend("force", av_overrides, opts)
	end

	server:setup(opts)
end)

-- Include the servers you want to have installed by default below
local servers = {
	-- "bashls",
	-- "pyright",
	-- "vuels",
	"yamlls",
}

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found and not server:is_installed() then
		print("Installing " .. name)
		server:install()
	end
end

--[[
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local user_plugin_opts = require("core.utils").user_plugin_opts

lsp_installer.on_server_ready(function(server)
end)
]]

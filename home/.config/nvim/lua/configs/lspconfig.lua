require("nvchad.configs.lspconfig").defaults()

local servers = { "pyright", "rust_analyzer", "lua_ls", "jsonls", "yamlls", "gopls" }
vim.lsp.enable(servers)

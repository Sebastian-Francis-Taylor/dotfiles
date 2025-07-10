-- LSP Server configurations
require('lspconfig').clangd.setup({})
require('lspconfig').jdtls.setup({})
require('lspconfig').nil_ls.setup({})
require('lspconfig').pyright.setup({})
require('lspconfig').texlab.setup({})
require('lspconfig').bashls.setup({})
--
-- Install null-ls with your package manager
local null_ls = require("null-ls")

--null_ls.setup({
--  sources = {
--    -- C/C++ (clangd has its own formatter, but you can also use these)
--    null_ls.builtins.formatting.clang_format,
--    
--    -- Java (jdtls has its own formatter, but you can also use these)
--    null_ls.builtins.formatting.google_java_format,
--    
--    -- Nix
--    null_ls.builtins.formatting.nixpkgs_fmt,
--    
--    -- Python
--    null_ls.builtins.formatting.black,
--    null_ls.builtins.formatting.isort,
--    
--    -- LaTeX
--    null_ls.builtins.formatting.latexindent,
--    
--    -- Bash - add shfmt as a formatter through null-ls
--    null_ls.builtins.formatting.shfmt.with({
--      args = { "-i", "2", "-ci", "-bn" }, -- 2 space indentation, indent switch cases, binary ops may start a line
--    }),
--  },
--})

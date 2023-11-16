local conform = require 'conform'

local function init()
	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { { "prettierd", "prettier" } },
			scala = { "scalafmt" },
			terraform = { "terraform_fmt" },
			rust = { "rustfmt" },
			csharp = { { "uncrustify", "csharpier" } },
			sql = { "sql-formatter" },
			nix = { "nixfmt" },
		},
		format_on_save = {
			lsp_fallback = true,
		},
	})
end

return {
	init = init,
}

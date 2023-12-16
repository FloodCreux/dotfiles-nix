local function init()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { { "prettierd", "prettier" } },
			scala = { "scalafmt" },
			terraform = { "terraform_fmt" },
			rust = { "rustfmt" },
			csharp = { { "uncrustify", "csharpier" } },
			sql = { "sqlfmt", "sql-formatter" },
			nix = { "nixfmt" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
	})
end

return {
	init = init,
}
